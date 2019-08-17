/*  Code modified from Aaron Bertrand's blog post 
    https://www.mssqltips.com/sqlservertip/5971/accelerated-database-recovery-in-sql-server-2019/  */

USE master;

/* Do not run this script in production, unless you are 
   interested in generating a resume-updating event */
WAITFOR DELAY '00:02:00';
SHUTDOWN WITH NOWAIT;