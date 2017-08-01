USE [msdb]
GO

DECLARE   @return_value int

EXEC  @return_value = [dbo].[rds_backup_database]
      @source_db_name = 'your_database_name',
      @S3_arn_to_backup_to = 'arn:aws:s3:::your-bucket-name/folder/db.bak',
      @KMS_master_key_arn = NULL,
      @overwrite_S3_backup_file = NULL

SELECT    'Return Value' = @return_value

GO
