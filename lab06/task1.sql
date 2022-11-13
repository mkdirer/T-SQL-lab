IF EXISTS
(
	SELECT * 
	FROM sys.databases 
	WHERE name='Lab6db'
)
	BEGIN
		--ALTER DATABASE Lab6db SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE Lab6db;
END;
GO
CREATE DATABASE Lab6db;
GO
USE Lab6db;
GO

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lab6user')
DROP LOGIN [Lab6user]

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'Lab6user')
DROP USER [Lab6user]

CREATE LOGIN [Lab6user] WITH PASSWORD=N'789Passw0rd', DEFAULT_DATABASE=[Lab6db], DEFAULT_LANGUAGE=[polski]
GO
ALTER LOGIN [Lab6user] DISABLE

CREATE USER [Lab6user] FOR LOGIN [Lab6user]
EXEC sp_addrolemember @rolename=db_owner, @membername=[Lab6user];

