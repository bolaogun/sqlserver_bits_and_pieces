use [msdb]
go

exec msdb.dbo.rds_restore_database
@restore_db_name='crowd',
@s3_arn_to_restore_from='arn:aws:s3:::almtoolsmigration.cdg.org/SqlsvrBckps/20170926_set/MISVCDHMRCDB-CROWD.bak'
go

DECLARE @return_value int

EXEC @return_value = [dbo].[rds_task_status]
@db_name = 'crowd',
@task_id = 4

SELECT 'Return Value' = @return_value

GO

Exec sp_defaultdb @loginame='crowduser', @defdb='crowd'
go

use crowd
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'crowduser')
BEGIN
    CREATE USER crowduser FOR LOGIN crowduser
    EXEC sp_addrolemember N'db_owner', N'crowduser'
END;
GO
