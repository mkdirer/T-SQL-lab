
--zadanie 1--
USE AdventureWorks2008;
GO
IF OBJECT_ID('dbo.task_1') IS NOT NULL
 DROP FUNCTION dbo.task_1;
GO

CREATE FUNCTION dbo.task_1(@businessID INT)
    RETURNS NCHAR(600)
    AS
    BEGIN
        DECLARE @firstName AS NCHAR(60);
        DECLARE @lastName AS NCHAR(60);
        DECLARE @email AS NCHAR(60);
        DECLARE @adress AS NCHAR(100);
        SELECT @firstName = FirstName FROM Person.Person WHERE BusinessEntityID = @businessID;
        SELECT @lastName = LastName FROM Person.Person WHERE BusinessEntityID = @businessID;
        SELECT @adress = AddressLine1 FROM Person.Address WHERE AddressID = @businessID;
        SELECT @email = EmailAddress FROM Person.EmailAddress WHERE BusinessEntityID = @businessID;
    RETURN (@lastName + ';' + @firstName + ';' + @adress + ';' + @email);
END;

GO
SELECT dbo.task_1(4);

--zadanie 2--
USE AdventureWorks2008;
GO
IF OBJECT_ID('dbo.task_2') IS NOT NULL
 DROP FUNCTION dbo.task_2;
GO

CREATE FUNCTION dbo.task_2(@firstRow INT, @lastRow INT)
RETURNS @temp TABLE
(
    lastName NCHAR(60),
	firstName NCHAR(60),
	email NCHAR(60),
	address NCHAR(60)
)
AS
BEGIN
	DECLARE @temp2 TABLE
	(
        lastName NCHAR(60),
		firstName NCHAR(60),
		email NCHAR(60),
		address NCHAR(60),
		rowNumb INT
	)
	INSERT INTO @temp2(lastName, firstName, email, address, rowNumb)
	SELECT one.LastName, one.FirstName, one.EmailAddress, two.AddressLine1, Row_Number() OVER (ORDER BY one.LastName,one.FirstName,two.AddressLine1) AS rowNumb 
	FROM (SELECT one.BusinessEntityID, LastName, FirstName, EmailAddress FROM Person.Person one, Person.EmailAddress two WHERE one.BusinessEntityID = two.BusinessEntityID) AS one,
	(SELECT two.BusinessEntityID, one.AddressLine1 FROM Person.Address one INNER JOIN Person.BusinessEntityAddress two ON one.AddressID = two.AddressID) As two 
	WHERE one.BusinessEntityID = two.BusinessEntityID ORDER BY one.LastName, one.FirstName,two.AddressLine1;
	INSERT INTO @temp(lastName, firstName, email, address)
	SELECT lastName, firstName, address, email FROM @temp2 WHERE rowNumb BETWEEN @firstRow AND @lastRow;
RETURN
END;

GO
SELECT * FROM dbo.task_2(25, 45);

--zadanie 3--
USE AdventureWorks2008;
GO
IF OBJECT_ID('dbo.task_3') IS NOT NULL
 DROP FUNCTION dbo.task_3;
GO

CREATE FUNCTION dbo.task_3(@name NCHAR(60))
RETURNS TABLE AS
RETURN
WITH CTE3
AS
(
	SELECT * FROM
	( SELECT customer.CustomerId as customer, person.FirstName, person.LastName  FROM Person.Person person, Sales.Customer customer WHERE person.BusinessEntityID = customer.PersonID AND LastName = @name) AS one,
	( SELECT * FROM Sales.SalesOrderHeader ) AS two
	WHERE one.customer = two.CustomerId
) SELECT * FROM CTE3;

GO
SELECT * FROM dbo.task_3('Adams');
