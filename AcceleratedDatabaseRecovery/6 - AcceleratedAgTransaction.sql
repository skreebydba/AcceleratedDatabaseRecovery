/* Steps for setting up an Availability Group environment can be found here 
   This document references SQL Server 2012, but the steps will work for 
   later versions https://www.brentozar.com/archive/2011/07/how-set-up-sql-server-denali-availability-groups/ 
   
   A tutorial for setting up an Availability Group on Azure VMs can be found here 
   https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sql/virtual-machines-windows-portal-sql-availability-group-tutorial
   
   As with everything here, feel free to contact me with any questions. */


DECLARE @waitfor DATETIME;

SELECT @waitfor = CAST(DATEADD(SECOND, 10, CURRENT_TIMESTAMP) AS TIME);

WAITFOR TIME @waitfor;

USE AcceleratedAg;
GO
DROP TABLE IF EXISTS dbo.fl1, dbo.fl2, dbo.fl3;

--BEGIN TRANSACTION
SELECT s2.* INTO dbo.fl1 FROM sys.all_columns AS s1 CROSS JOIN sys.all_objects AS s2;
SELECT s2.* INTO dbo.fl2 FROM sys.all_columns AS s1 CROSS JOIN sys.all_objects AS s2;
SELECT s2.* INTO dbo.fl3 FROM sys.all_columns AS s1 CROSS JOIN sys.all_objects AS s2;

--ROLLBACK TRANSACTION