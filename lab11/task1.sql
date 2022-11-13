USE tempdb
GO

declare @xdoc xml
set @xdoc = '<?xml version="1.0"?><lista></lista>';

set @xdoc.modify('insert <student><nazwisko>Nowacki</nazwisko><imie>Paweł</imie></student> into (/lista)[1]');
set @xdoc.modify('insert <student><nazwisko>Harlicak</nazwisko><imie>Jakub</imie></student> after (/lista/student)[1]');
set @xdoc.modify('insert <student><nazwisko>Adamski</nazwisko><imie>Adam</imie></student> after (/lista/student)[2]');
set @xdoc.modify('insert <student><nazwisko>Michalski</nazwisko><imie>Jan</imie></student> after (/lista/student)[3]');
set @xdoc.modify('insert <student><nazwisko>Konik</nazwisko><imie>Kamil</imie></student> after (/lista/student)[4]');
set @xdoc.modify('insert <grupa>1</grupa> as last into (/lista/student)[1]');
set @xdoc.modify('insert <grupa>1</grupa> as last into (/lista/student)[2]');
set @xdoc.modify('insert <grupa>1</grupa> as last into (/lista/student)[3]');
set @xdoc.modify('insert <grupa>1</grupa> as last into (/lista/student)[4]');
set @xdoc.modify('insert <grupa>1</grupa> as last into (/lista/student)[5]');
select T.c.query('.') results from @xdoc.nodes('lista/student') T(c)