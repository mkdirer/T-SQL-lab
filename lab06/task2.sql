USE Lab6db;
GO

IF OBJECT_ID(N'task2') IS NOT NULL
 DROP PROC task2;
GO

CREATE PROCEDURE task2
AS

BEGIN
	IF OBJECT_ID(N'student') IS NOT NULL 
	  DROP TABLE student; 
	
	CREATE TABLE student (id int PRIMARY KEY,fname varchar(30),lname varchar(30),);

	IF OBJECT_ID(N'wykladowca') IS NOT NULL 
	  DROP TABLE wykladowca; 
	
	CREATE TABLE wykladowca (id int PRIMARY KEY,fname varchar(30),lname varchar(30),);
 
	IF OBJECT_ID(N'przedmiot') IS NOT NULL 
	  DROP TABLE przedmiot;
	
	CREATE TABLE przedmiot (id int PRIMARY KEY,name varchar(50),);
	  
	IF OBJECT_ID(N'grupa') IS NOT NULL 
	  DROP TABLE grupa; 

	CREATE TABLE grupa (
		id_wykl int FOREIGN KEY REFERENCES wykladowca(id),
		id_stud int FOREIGN KEY REFERENCES student(id),
		id_przed int FOREIGN KEY REFERENCES przedmiot(id),
		PRIMARY KEY (id_wykl, id_stud, id_przed),
	);

END
