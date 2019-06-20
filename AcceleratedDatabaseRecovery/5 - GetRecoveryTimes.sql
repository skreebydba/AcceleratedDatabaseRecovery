USE master;

DROP TABLE IF EXISTS #errorlog;

CREATE TABLE #errorlog
(RowId INT IDENTITY(1,1)
,LogDate DATETIME
,ProcessInfo NVARCHAR(30)
,ErrorText NVARCHAR(MAX));

INSERT INTO #errorlog
EXEC sp_readerrorlog 0, 1, N'Recovery completed for database';

SELECT 
CASE 
	WHEN ErrorText LIKE '%Accelerated%' THEN 'AcceleratedRecovery'
	WHEN ErrorText LIKE '%Regular%' THEN 'RegularRecovery'
END AS DatabaseName, 
SUBSTRING(ErrorText, (PATINDEX('%analysis%', ErrorText) + 9), ((PATINDEX('%,%', ErrorText) - 3) -(PATINDEX('%analysis%', ErrorText) + 9))) AS [Analysis (ms)], 
SUBSTRING(ErrorText, (PATINDEX('%redo%', ErrorText) + 5), ((CHARINDEX(',', ErrorText, PATINDEX('%redo%', ErrorText)) - 3) - (PATINDEX('%redo%', ErrorText) + 5))) AS [Redo (ms)],
SUBSTRING(ErrorText, (PATINDEX('%undo%', ErrorText) + 5), ((CHARINDEX('.', ErrorText, PATINDEX('%undo%', ErrorText)) - 3) - (PATINDEX('%undo%', ErrorText) + 5))) AS [Undo(ms)]
FROM #errorlog
WHERE ErrorText LIKE '%AcceleratedRecovery%'
OR ErrorText LIKE '%RegularRecovery%'
ORDER BY LogDate;







