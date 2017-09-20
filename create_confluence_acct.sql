create database confluencedb
go

ALTER DATABASE confluencedb COLLATE SQL_Latin1_General_CP1_CS_AS
go

SELECT is_read_committed_snapshot_on FROM sys.databases WHERE name= 'confluencedb'
go


ALTER DATABASE confluencedb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
<your ALTER DATABASE query>
ALTER DATABASE confluencedb SET MULTI_USER;


ALTER DATABASE confluencedb
   SET READ_COMMITTED_SNAPSHOT ON
   WITH ROLLBACK IMMEDIATE;
go

CREATE LOGIN confluenceuser WITH PASSWORD = 'confluenceuser'
GO

use confluencedb
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'confluenceuser')
BEGIN
    CREATE USER confluenceuser FOR LOGIN confluenceuser
    EXEC sp_addrolemember N'db_owner', N'confluenceuser'
END;
GO

CREATE SCHEMA confluenceschema authorization confluenceuser
GO
