USE [testCLR]
GO
create table test ( complexField dbo.ComplexNumber);
insert into test (complexField) values('25+52i');
select complexField.ToString() from test;
insert into test values(ComplexNumber::[Add]('12+25i','25+12i'));
select complexField.ToString() from test;
select ComplexNumber::[Modul]('3+4i');
select ComplexNumber::[spz]('3+4i').ToString();
drop table test;