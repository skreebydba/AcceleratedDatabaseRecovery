USE master;

DROP TABLE IF EXISTS #errorlog;

CREATE TABLE #errorlog
(RowId INT IDENTITY(1,1)
,LogDate DATETIME
,ProcessInfo NVARCHAR(30)
,ErrorText NVARCHAR(MAX));

INSERT INTO #errorlog
EXEC sp_readerrorlog 0, 1, N'Recovery completed for database';

SELECT *, PATINDEX('%analysis%', ErrorText) AS [Analysis (ms)], 
SUBSTRING(ErrorText, PATINDEX('%analysis%', ErrorText), ),
PATINDEX('%redo%', ErrorText) AS [Redo (ms)], 
PATINDEX('%undo%', ErrorText) AS [Undo(ms)]
FROM #errorlog
WHERE ErrorText LIKE '%AcceleratedRecovery%'
OR ErrorText LIKE '%RegularRecovery%';

SELECT SUBSTRING('a','bcabca', 3);

SELECT * FROM #errorlog


