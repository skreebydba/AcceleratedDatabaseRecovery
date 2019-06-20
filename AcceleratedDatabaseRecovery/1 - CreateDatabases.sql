USE master;

DROP DATABASE IF EXISTS RegularRecovery;
DROP DATABASE IF EXISTS AcceleratedRecovery;

CREATE DATABASE RegularRecovery;
GO
CREATE DATABASE AcceleratedRecovery;
ALTER  DATABASE AcceleratedRecovery SET ACCELERATED_DATABASE_RECOVERY = ON;
GO

EXEC sp_helpdb RegularRecovery;
EXEC sp_helpdb AcceleratedRecovery;

SELECT DB_NAME(database_id) AS DBName,
[name] AS [FileName],
[size] / 128 AS FileSize,
[growth] / 128 AS FileGrowth
FROM sys.master_files
WHERE DB_NAME(database_id) IN (N'RegularRecovery','AcceleratedRecovery');