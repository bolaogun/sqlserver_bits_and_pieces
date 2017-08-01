USE [msdb] 
GO

DECLARE   @return_value int

EXEC  @return_value = [dbo].[rds_task_status]         
@db_name = 'your_database_name',         
@task_id = <<<found in result of previous query>>>

SELECT    'Return Value' = @return_value

GO
