USE AdventureWorks
GO
WITH XMLNAMESPACES(DEFAULT 'http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey')
SELECT * FROM Sales.Individual WHERE Demographics.query('IndividualSurvey/TotalChildren[1]').value('.','int')>1