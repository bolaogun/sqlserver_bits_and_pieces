use [msdb]
go

exec msdb.dbo.rds_restore_database
@restore_db_name='bitbucket',
@s3_arn_to_restore_from='arn:aws:s3:::almtoolsmigration.cdg.org/SqlsvrBckps/20170926_set/MISVCDHMRCDB-BITBUCKET.bak'
go

DECLARE @return_value int

EXEC @return_value = [dbo].[rds_task_status]
@db_name = 'bitbucket',
@task_id = 4

SELECT 'Return Value' = @return_value

GO

Exec sp_defaultdb @loginame='bitbucketuser', @defdb='bitbucket'
go

use bitbucket
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bitbucketuser')
BEGIN
    CREATE USER bitbucketuser FOR LOGIN bitbucketuser
    EXEC sp_addrolemember N'db_owner', N'bitbucketuser'
END;
GO
