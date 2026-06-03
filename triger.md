## Andmebaaside konspektid
[Keys](keys.md) | [Konspekt](kasutaja.md) | [TrigerMysql](triger.md) | [trigeridXAMPP](trigeridXAMPP.md) | [Andmebaasi loomine](ÜL1.md)


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
<img width="770" height="384" alt="{DD486A37-E731-4021-9D0F-DF819AD9AAC7}" src="https://github.com/user-attachments/assets/42c00344-dfb0-427c-a536-62d453d0e773" />



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
GRANT SELECT, INSERT, DELETE ON linnad TO sekretaarTagirov;
DENY select, Delete ON linnad TO sekretaarTagirov;
```

