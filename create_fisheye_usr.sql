-- Fisheye --
CREATE DATABASE fisheye
GO
USE fisheye
GO
ALTER DATABASE fisheye SET ALLOW_SNAPSHOT_ISOLATION ON
GO
ALTER DATABASE fisheye SET READ_COMMITTED_SNAPSHOT ON
GO
ALTER DATABASE fisheye COLLATE SQL_Latin1_General_CP1_CS_AS
GO
SET NOCOUNT OFF
GO
USE master
GO
CREATE LOGIN fisheyeuser WITH PASSWORD=N'fisheyeuser', DEFAULT_DATABASE=fisheye, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

use fisheye
go

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'fisheyeuser')
BEGIN
    CREATE USER fisheyeuser FOR LOGIN fisheyeuser
    EXEC sp_addrolemember N'db_owner', N'fisheyeuser'
END;
GO

create schema fisheyeschema
go

alter user fisheyeuser with default_schema=fisheyeschema
go
