use [msdb]
go

exec msdb.dbo.rds_restore_database
@restore_db_name='jiradb',
@s3_arn_to_restore_from='arn:aws:s3:::almtools/SqlsvrBckps/jiradb_20170731.bkp';
go

