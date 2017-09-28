use [msdb]
go

exec msdb.dbo.rds_restore_database
@restore_db_name='confluence',
@s3_arn_to_restore_from='arn:aws:s3:::almtoolsmigration.cdg.org/SqlsvrBckps/20170926_set/MISVCDHMRCDB-CONFLUENCE.bak'
go

DECLARE @return_value int

EXEC @return_value = [dbo].[rds_task_status]
@db_name = 'confluence',
@task_id = 3

SELECT 'Return Value' = @return_value

GO

Exec sp_defaultdb @loginame='confluenceuser', @defdb='confluence'
go

use confluence
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'confluenceuser')
BEGIN
    CREATE USER confluenceuser FOR LOGIN confluenceuser
    EXEC sp_addrolemember N'db_owner', N'confluenceuser'
END;
GO

CREATE SCHEMA confluenceschema authorization confluenceuser
GO
