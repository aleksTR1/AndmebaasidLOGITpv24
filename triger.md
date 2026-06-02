## Andmebaaside konspektid
[Create_insert](Create_insert.sql) | [Kasutaja](kasutaja.md) | [triger](triger.md) | [trigeridXAMPP](trigeridXAMPP.md) | [Ülesanne_1](ÜL1)

## Triger - trigger -päästik

### Triger - andmebaasi objekt, mis käivitub automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE, DELETE).
Trigerite loomine - automatseerub protsessid SQL Serveris.

Tabelid mis tuleb luua enna trigerit!
```sql
Create database trigerLogitpv24;

use trigerLogitpv24;
CREATE TABLE linnad(
linnId int primary key identity(1,1),
linnanimi varchar(30) unique,
maakond varchar(50),
rahvaarv int);
select * from linnad;
INSERT INTO linnad(linnanimi, maakond, rahvaarv)
VALUES ('Tallinn', 'Harjumaa', 600000);

--tabel logi - tabel, mis täidab triger, kui kasutaja täidab tabeli linnad!
CREATE TABLE logi(
id int primary key identity(1,1),
kasutaja varchar(50),
aeg DATETIME,
andmed TEXT);
```

```
--Triger lisatud andmete jälgimeseks tabelis linnad.
--jälgib linna sisestamine tabelisse ja teeb vastava kirje logi-tabelis
CREATE TRIGGER linnaLisamine
ON linnad -- tabel, mida triger jälgib
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('lisatud: ',inserted.linnanimi,', ',
inserted.maakond,', ',inserted.rahvaarv)
FROM inserted;

--kontrollimiseks tuleb lisada linna tabelisse linnad
Insert into linnad(linnanimi, rahvaarv)
Values('Pärnu',15633)

SELECT * FROM linnad;
SELECT * FROM logi;
```
<img width="438" height="444" alt="{6929D138-D4FA-47F9-8316-EA82F5B63DC1}" src="https://github.com/user-attachments/assets/17cd416b-099f-439e-842c-c1992b6e9687" />


```
--DELETE triger - jälgib kustutamine tabelis linnad 
--ja teeb vastava kirje logi tabelisse
CREATE TRIGGER linnaKustutamine
ON linnad -- tabel, mida triger jälgib
FOR DELETE
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('kustutatud: ',deleted.linnanimi,', ',
deleted.maakond,', ',deleted.rahvaarv)
FROM deleted;
```


```
--Update triger
CREATE TRIGGER linnaUuendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SUSER_NAME(),
GETDATE(), 
'on tehtud UPDATE käsk', 
CONCAT('vanad andmed -linn: ', deleted.linnanimi,', elanike arv: ', deleted.rahvaarv,'uued andmed -linn: ', inserted.linnanimi,', elanike arv: ', inserted.rahvaarv) 
FROM deleted
INNER JOIN inserted
ON deleted.linnID=inserted.linnID;
```
<img width="964" height="547" alt="{20A9CDCC-F192-4413-B545-16CA9E5E578D}" src="https://github.com/user-attachments/assets/b4987faf-7c06-41ee-ae56-9640ae17b2c5" />




















































Create database trigerLogitpv24;

use trigerlogitpv24;
CREATE TABLE linnad(
linnId int primary key identity(1,1),
linnanimi varchar(30) unique,
maakond varchar(50),
rahvaarv int);
select * from linnad;
INSERT INTO linnad(linnanimi, maakond, rahvaarv)
VALUES ('Tallinn', 'Harjumaa', 600000);

--tabel logi - tabel, mis täidab triger, kui kasutaja täidab tabeli linnad!
CREATE TABLE logi(
id int primary key identity(1,1),
kasutaja varchar(50),
aeg DATETIME,
andmed TEXT);

--1. Triger lisatud andmete jälgimeseks tabelis linnad.
--jälgib linna sisestamine tabelisse ja teeb vastava kirje logi-tabelis
CREATE TRIGGER linnaLisamine
ON linnad -- tabel, mida triger jälgib
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('lisatud: ',inserted.linnanimi,', ',
inserted.maakond,', ',inserted.rahvaarv)
FROM inserted;

--kontrollimiseks tuleb lisada linna tabelisse linnad
INSERT INTO linnad(linnanimi, maakond, rahvaarv)
VALUES ('Viljandi', 'Viljandimaa', 50000);

SELECT * FROM linnad;
SELECT * FROM logi;

--2. DELETE triger - jälgib kustutamine tabelis linnad 
--ja teeb vastava kirje logi tabelisse
CREATE TRIGGER linnaKustutamine
ON linnad -- tabel, mida triger jälgib
FOR DELETE
AS
INSERT INTO logi(kasutaja, aeg, andmed)
SELECT 
SYSTEM_USER, --siselogitud user
GETDATE(), 
CONCAT('kustutatud: ',deleted.linnanimi,', ',
deleted.maakond,', ',deleted.rahvaarv)
FROM deleted;

--DISABLE TRIGGER ....
DISABLE TRIGGER linnakustutamine ON linnad;
ENABLE TRIGGER linnaKustutamine ON linnad;

--DELETE trigeri kontroll
DELETE FROM linnad WHERE linnId=2;
select * from linnad
select * from logi;

--UPDATE triger
CREATE TRIGGER linnaUuendamine
on linnad --tabelinimi, mis on vaja jälgida
for update
as
insert into logi(kuupäev, kasutaja, toiming, andmed)
SELECT
GETDATE(), --aeg
SYSTEM_USER, --kasutaja mis on sisse logitud serverisse 
'on tehtud UPDATE käsk', --toiming
CONCAT('vanad andmed - linn', deleted.linnanimi, ', rahvaarv: ' deleted.rahvaarv
'uued andmed -linn', inserted.linnanumu, ',rahvaarv -', inserted.rahvaarv) --andmed tabelist linnad
FROM deleted INNER JOIN inserted
ON deleted linnID=inserted.linnID

--UPDATE kontroll
UPDATE linnad SET linnanimi='narva22', rahvaarv=0 WHERE linnanimi='Narva';
select * from linnad;
select * from logi;

--kasutaja sekretaarTagirov, parool 12345
--õigused - sekretarTagirov ei saa luua ja kustutada tabelist linnad

GRANT SELECT, INSERT, DELETE ON linnad TO sekretaarTagirov;
DENY select, Delete ON linnad TO sekretaarTagirov;


