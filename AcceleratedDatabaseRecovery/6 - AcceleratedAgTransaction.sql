DECLARE @waitfor DATETIME;

SELECT @waitfor = CAST(DATEADD(SECOND, 10, CURRENT_TIMESTAMP) AS TIME);

WAITFOR TIME @waitfor;

USE AcceleratedAg;
GO
DROP TABLE IF EXISTS dbo.fl1, dbo.fl2, dbo.fl3;

BEGIN TRANSACTION
SELECT s2.* INTO dbo.fl1 FROM sys.all_columns AS s1 CROSS JOIN sys.all_objects AS s2;
SELECT s2.* INTO dbo.fl2 FROM sys.all_columns AS s1 CROSS JOIN sys.all_objects AS s2;
SELECT s2.* INTO dbo.fl3 FROM sys.all_columns AS s1 CROSS JOIN sys.all_objects AS s2;