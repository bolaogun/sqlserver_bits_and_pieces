   USE jira
GO
ALTER DATABASE jira SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE jira SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE jira COLLATE SQL_Latin1_General_CP437_CI_AI
GO
SET NOCOUNT OFF
GO
USE master
GO

DECLARE @loginName char(30);
set @loginName = 'jirauser'
If not Exists (select loginname from master.dbo.syslogins where name = @loginName and dbname = 'master')
BEGIN
CREATE LOGIN jirauser WITH PASSWORD=N'jirauser',DEFAULT_DATABASE=jira, 
CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

END
go

use jira
go
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jirauser')
BEGIN
    CREATE USER jirauser FOR LOGIN jirauser
    EXEC sp_addrolemember N'db_owner', N'jirauser'
END;
GO

IF NOT EXISTS (
SELECT  schema_name
FROM    information_schema.schemata
WHERE   schema_name = 'jiraschema' )
 
BEGIN
EXEC sp_executesql N'CREATE SCHEMA jiraschema AUTHORIZATION jirauser' 
END
GO

    -- Drop
    --ALTER DATABASE jiradb SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE;
    --GO
    --DROP DATABASE jiradb
    --GO


