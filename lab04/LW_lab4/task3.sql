-- zadanie 3 --

/*
Use AdventureWorks;
go

Select * From Sales.SalesReason;
--Select * From Purchasing.Vendor;
*/


USE AdventureWorks;
GO

IF OBJECT_ID('dbo.task3') IS NOT NULL
 DROP PROC dbo.task3;
GO

CREATE PROC dbo.task3
@IDReasonType AS sysname = NULL
AS
DECLARE @error_message AS NVARCHAR(700);


IF @IDReasonType IS NULL
BEGIN
 RAISERROR(15600,-1,-1, 'dbo.task3');
 RETURN;
END

IF LEN(@IDReasonType) < 5
BEGIN
 SET @error_message = N'Enter a @IDReasonType that is longer than 5 characters.';
 RAISERROR(@error_message, 15, 1);
 RETURN;
END

SELECT * FROM Sales.SalesReason 
WHERE ReasonType = @IDReasonType;
GO


EXEC dbo.task3 @IDReasonType = 'now';