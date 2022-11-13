USE tempdb
GO

DROP XML SCHEMA COLLECTION AddressSchema

CREATE XML SCHEMA COLLECTION AddressSchema AS
'
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
targetNamespace="http://www.microsoft.com/schemas/adventureworks/addresses"
xmlns:adr="http://www.microsoft.com/schemas/adventureworks/addresses">
		<xs:element name="adres">
			<xs:complexType>
				<xs:sequence>
					<xs:element name="miejscowosc" />
					<xs:element name="kod" />
					<xs:element name="ulica" />
					<xs:element name="numer" />
				</xs:sequence>
			</xs:complexType>
		</xs:element>
    <xs:element name="miejscowosc" type="xs:string" />
	<xs:element name="kod" type="xs:string" />
	<xs:element name="ulica" type="xs:string" />
	<xs:element name="numer" type="xs:integer" />
	</xs:schema>
'
GO

DROP TABLE task2
CREATE TABLE task2(
	id int,
	nazwisko varchar(30),
	imie varchar(30),
	adres xml(AddressSchema)
)
GO

INSERT INTO task2 VALUES(1, 'Jan', 'Kowalski', '
	<adres>
		<miejscowosc> Krakow </miejscowosc>
		<kod> 35-073 </kod>
		<ulica> Starowislna </ulica>
		<numer> 43 </numer>
	</adres>
')
GO

SELECT * FROM task2;