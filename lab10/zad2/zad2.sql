USE testCLR;
GO

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    firstName VARCHAR(60),
    surName VARCHAR(60),
);

GO

CREATE TABLE task (
    task_id INT PRIMARY KEY,
    name VARCHAR(60),
);

GO

CREATE TABLE employee_task (
    task_id INT FOREIGN KEY REFERENCES employee(task_id),
    task_id INT FOREIGN KEY REFERENCES task(task_id)
);

EXEC dbo.SimpleTransactionScope;
