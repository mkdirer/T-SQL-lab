USE testCLR;
GO

CREATE TABLE test1 (
	item int
);

CREATE TABLE info (
    user VARCHAR(60) NOT NULL,
	content VARCHAR(60) NOT NULL,
	log_id INT IDENTITY PRIMARY KEY,
	insertion_date DATETIME NOT NULL DEFAULT (getDate()),
	
);

INSERT INTO test1 VALUES(4);
