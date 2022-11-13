-- zadnie 1 --

USE AdventureWorks;
GO

IF OBJECT_ID('dbo.task1') IS NOT NULL
 DROP PROC dbo.task1;
GO

CREATE PROC dbo.task1
AS BEGIN
	DECLARE @sale_bonus int, @id_sale_parson int
	DECLARE saleCursor CURSOR FOR
	SELECT	Bonus, SalesPersonID FROM Sales.SalesPerson WHERE SalesPersonID <= 290;
	OPEN saleCursor
		FETCH NEXT FROM saleCursor INTO  @sale_bonus, @id_sale_parson;
		WHILE @@FETCH_STATUS = 0
		BEGIN
            print 'A bonus of ' + cast(@sale_bonus as varchar) + ' rubles goes to a candidate with an ID = ' + cast(@id_sale_parson as varchar) + '.'
			FETCH NEXT FROM saleCursor INTO @sale_bonus, @id_sale_parson;
		END
	CLOSE saleCursor
	DEALLOCATE saleCursor
END

GO
EXECUTE dbo.task1;