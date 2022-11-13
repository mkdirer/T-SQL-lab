------------------------------------ Zadanie 1 -------------------------------------
-- a)
-- Opperator WHERE (RowNumber > 51) AND (RowNumber < 100) zapewni wystąpeinie błedu, gdyż klauzula WHERE jest uwzględniona jescze przed wywołaniem funkcj RowNumber. 
-- Aby operator dał nam wynik RowNumber które znajduje się w przedziale (51,100), musimy skorzystać z wewnętrznych i zewnętrznych zapytań lub wyrażeń tablicowych. 

-- b) I 
USE AdventureWorks
GO

IF OBJECT_ID('temporary') IS NOT NULL
DROP TABLE temporary;
GO

CREATE TABLE temporary (
[RowNumber] int,
[City] nvarchar(50),
[AddressLine1] nvarchar(50),
[AddressID] int
);

INSERT INTO temporary SELECT Row_Number() OVER (ORDER BY [AddressLine1]) AS [RowNumber], [City], [AddressLine1], [AddressID]
FROM [Person].[Address] ORDER BY [RowNumber]

SELECT * from temporary WHERE ([RowNumber] > 51) AND ([RowNumber] < 100);

-- b) II

USE AdventureWorks
GO

WITH Address_CTE AS
(
SELECT Row_Number() OVER (ORDER BY [AddressLine1])
AS [RowNumber], [AddressID], [City], [AddressLine1]
FROM [Person].[Address]
)
SELECT * from Address_CTE WHERE ([RowNumber] > 51) AND ([RowNumber] < 100);

------------------------------------ Zadanie 2 -------------------------------------

USE AdventureWorks
GO
SELECT Person.StateProvince.Name, Person.Address.City, COUNT(Person.StateProvince.Name) AS "Liczba dostawcow" FROM Purchasing.Vendor
JOIN Purchasing.VendorAddress ON Purchasing.Vendor.VendorID = Purchasing.VendorAddress.VendorID
JOIN Person.Address ON Purchasing.VendorAddress.AddressID = Person.Address.AddressID
JOIN Person.StateProvince ON Person.Address.StateProvinceID = Person.StateProvince.StateProvinceID
GROUP BY GROUPING SETS( (Person.StateProvince.Name), (Person.StateProvince.Name, Person.Address.City))
ORDER BY "Liczba dostawcow" DESC;

------------------------------------ Zadanie 3 -------------------------------------
-- a) CASE dla Zadania 2

USE AdventureWorks
GO

SELECT
Person.StateProvince.Name,
CASE
WHEN Person.Address.City IS NULL THEN 'Nie zainicjalizowane'
ELSE Person.Address.City
END AS City,
CASE
WHEN COUNT(Person.StateProvince.Name) > 2 THEN 'powyzej sredniej'
WHEN COUNT(Person.StateProvince.Name) = 2 THEN 'srednia'
WHEN COUNT(Person.StateProvince.Name) < 2 THEN 'mniej niz srednia'
END AS "Liczba dostawcow"
FROM Purchasing.Vendor
JOIN Purchasing.VendorAddress ON Purchasing.Vendor.VendorID = Purchasing.VendorAddress.VendorID
JOIN Person.Address ON Purchasing.VendorAddress.AddressID = Person.Address.AddressID
JOIN Person.StateProvince ON Person.Address.StateProvinceID = Person.StateProvince.StateProvinceID
GROUP BY GROUPING SETS((Person.StateProvince.Name), (Person.StateProvince.Name, Person.Address.City))
ORDER BY "Liczba dostawcow" DESC;

-- b) Utworzenie tabeli z kolumnami dla godziny i minuty pomiaru ( dwie osobne kolumny) oraz dwie następne kolumny dla wartości mierzonych zawartość CO2
-- i Wykorzystanie PIVOT'ów dla pokazania agregatów MIN, MAX, SUM w kolejnych godzinach

USE tempdb
GO
IF OBJECT_ID('pomiary') IS NOT NULL
DROP TABLE pomiary;
GO
CREATE TABLE pomiary(
godzina int,
minuty int,
co2 float,
ilosc_pojazdow int
);
INSERT INTO pomiary VALUES(11, 14, 0.24, 23);
INSERT INTO pomiary VALUES(11, 16, 0.30, 14);
INSERT INTO pomiary VALUES(12, 23, 0.14, 43);
INSERT INTO pomiary VALUES(14, 14, 0.34, 24);
INSERT INTO pomiary VALUES(14, 15, 0.26, 18);
INSERT INTO pomiary VALUES(14, 24, 0.16, 28);
GO 
SELECT * FROM pomiary
PIVOT (MIN(ilosc_pojazdow) FOR godzina IN ([11], [12], [13], [14])) AS agregat ORDER BY minuty;
SELECT * FROM pomiary
PIVOT (MIN(co2) FOR godzina IN ([11], [12], [13], [14])) AS agregat ORDER BY minuty;
SELECT * FROM pomiary
PIVOT (MAX(ilosc_pojazdow) FOR godzina IN ([11], [12], [13], [14])) AS agregat ORDER BY minuty;
SELECT * FROM pomiary
PIVOT (MAX(co2) FOR godzina IN ([11], [12], [13], [14])) AS agregat ORDER BY minuty;
SELECT * FROM pomiary
PIVOT (SUM(ilosc_pojazdow) FOR godzina IN ([11], [12], [13], [14])) AS agregat ORDER BY minuty;
SELECT * FROM pomiary
PIVOT (SUM(co2) FOR godzina IN ([11], [12], [13], [14])) AS agregat ORDER BY minuty;












