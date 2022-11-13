------------------- zadanie 1
CREATE LOGIN [MSSQLSERVER\testerl] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks], DEFAULT_LANGUAGE=[us_english] 
GO 
CREATE LOGIN [MSSQLSERVER\tester2] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks], DEFAULT_LANGUAGE=[us_english] 
GO 
CREATE LOGIN [MSSQLSERVER\tester3] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks], DEFAULT_LANGUAGE=[us_english] 
GO
EXEC sp_grantlogin 'MSSQLSERVER\Grupal' 
GO
CREATE LOGIN [MSSQLSERVER\tester4] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks], DEFAULT_LANGUAGE=[us_english] 
GO
CREATE LOGIN [MSSQLSERVER\tester5] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks], DEFAULT_LANGUAGE=[us_english] 
GO
EXEC sp_denylogin 'MSSQLSERVER\grupa2' 

------------------- zadanie 2
CREATE LOGIN [MSSQLSERVER\tester6] FROM WINDOWS WITH DEFAULT_DATABASE=[AdventureWorks], DEFAULT_LANGUAGE=[us_english] 
GO
EXEC sp_addsrvrolemember 'MSSQLSERVER\tester5', 'dbcreator' 
GO
EXEC sp_addsrvrolemember 'MSSQLSERVER\tester6', 'serveradmin' 
GO

------------------- zadanie 3
EXEC sp_addrolemember 'db_datewriter', 'MSSQLSERVER\Grupa1'
GO 
EXEC sp_addrolemember 'db_datewriter', 'MSSQLSERVER\grupa2'
GO 
EXEC sp_addsrvrolemember 'MSSQLSERVER\tester3', 'sysadmin' 
