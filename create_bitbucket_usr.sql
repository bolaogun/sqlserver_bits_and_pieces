CREATE DATABASE bitbucket
GO
USE bitbucket
GO
ALTER DATABASE bitbucket SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE bitbucket SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE bitbucket COLLATE SQL_Latin1_General_CP1_CS_AS
GO
SET NOCOUNT OFF
GO
USE master
GO
CREATE LOGIN bitbucketuser WITH PASSWORD=N'bitbucketuser', DEFAULT_DATABASE=bitbucket, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

use bitbucket
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'bitbucketuser')
BEGIN
    CREATE USER bitbucketuser FOR LOGIN bitbucketuser
    EXEC sp_addrolemember N'db_owner', N'bitbucketuser'
END;
GO

create schema bitbucketschema authorization bitbucketuser
go
