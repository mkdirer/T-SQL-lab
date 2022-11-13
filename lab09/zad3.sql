USE [testCLR]
GO
IF OBJECT_ID('table_aggr') IS NOT NULL
	DROP TABLE table_aggr
GO
CREATE TABLE table_aggr(a1 int);
GO
INSERT INTO table_aggr VALUES (1)
INSERT INTO table_aggr VALUES (2)
INSERT INTO table_aggr VALUES (3)
INSERT INTO table_aggr VALUES (4)
INSERT INTO table_aggr VALUES (5)
INSERT INTO table_aggr VALUES (6)
INSERT INTO table_aggr VALUES (7)
INSERT INTO table_aggr VALUES (8)
INSERT INTO table_aggr VALUES (9)
INSERT INTO table_aggr VALUES (1)
INSERT INTO table_aggr VALUES (2)
INSERT INTO table_aggr VALUES (3)
INSERT INTO table_aggr VALUES (4)
INSERT INTO table_aggr VALUES (5)
INSERT INTO table_aggr VALUES (6)
SELECT dbo.uda_avg(a1) FROM table_aggr