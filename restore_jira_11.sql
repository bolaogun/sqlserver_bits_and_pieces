use [msdb]
go

exec msdb.dbo.rds_restore_database
@restore_db_name='jira_11',
@s3_arn_to_restore_from='arn:aws:s3:::almtools/SqlsvrBckps/jira_11_20170801.bak';
go

