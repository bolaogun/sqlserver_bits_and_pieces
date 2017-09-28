use [msdb]
go

exec msdb.dbo.rds_restore_database
@restore_db_name='jira',
@s3_arn_to_restore_from='arn:aws:s3:::almtoolsmigration.cdg.org/SqlsvrBckps/20170926_set/MISVCDHMRCDB-JIRA.bak'
go

DECLARE @return_value int

EXEC @return_value = [dbo].[rds_task_status]
@db_name = 'jira',
@task_id = 1

SELECT 'Return Value' = @return_value

GO

Exec sp_defaultdb @loginame='jirauser', @defdb='jira'
go

use jira
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jirauser')
BEGIN
    CREATE USER jirauser FOR LOGIN jirauser
    EXEC sp_addrolemember N'db_owner', N'jirauser'
END;
GO

create schema jiraschema authorization jirauser
go
