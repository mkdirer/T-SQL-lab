-- zadanie 2 --

IF OBJECT_ID('dbo.task2') IS NOT NULL
	DROP TABLE dbo.task2;
GO

CREATE TABLE dbo.task2 (id_rel INT, rel_name name,  rel_time datetime,);
GO

IF OBJECT_ID('Sales.Release', 'TR') IS NOT NULL
	DROP TRIGGER Sales.Release;
GO

CREATE TRIGGER Sales.Release ON Sales.SalesReason
	AFTER INSERT, UPDATE
	AS
	BEGIN
		INSERT INTO dbo.task2 VALUES((SELECT SalesReasonID FROM inserted), 'Marketing', getdate())
	END
GO

INSERT INTO Sales.SalesReason VALUES ('Second hand', 'Marketing', getdate());
UPDATE Sales.SalesReason SET Name = 'First hand' WHERE Name = 'Second hand';
SELECT * FROM dbo.task2;