    ###### Jira ######
    CREATE DATABASE jira_11
    GO
    USE jira_11
    GO
    ALTER DATABASE jira_11 SET ALLOW_SNAPSHOT_ISOLATION ON
    GO
    ALTER DATABASE jira_11 SET READ_COMMITTED_SNAPSHOT ON
    GO
    ALTER DATABASE jira_11 COLLATE SQL_Latin1_General_CP437_CI_AI
    GO
    SET NOCOUNT OFF
    GO
    USE master
    GO
    CREATE LOGIN jirauser WITH PASSWORD=N'jirauser', DEFAULT_DATABASE=jira_11, 
    CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
    GO
    use jira_11
    go
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'jirauser')
    BEGIN
        CREATE USER jirauser FOR LOGIN jirauser
        EXEC sp_addrolemember N'db_owner', N'jirauser'
    END;
    GO
    create schema jiraschema authorization jirauser
    go

    create table Jira_Migration11 (first integer);
go

begin transaction
insert into Jira_Migration11 values (1);
insert into Jira_Migration11 values (2);
insert into Jira_Migration11 values (3);
insert into Jira_Migration11 values (4);
insert into Jira_Migration11 values (5);
commit;
go



