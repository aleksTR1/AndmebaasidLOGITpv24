## AndmebaasidLOGITpv24
andmebaaside haldusega seotud sql kood ja konspektid

## Põhimõisted
- Andmebaasi haldussüsteemid - tarkvara, millega abil saab luua andmebaas (mariaDB - XAMPP, SQL Server - SQL Server Management Studio (Server Name - (localdb)\MSSQLLocalDB))
- Andmebaas - struktureeritud andmete kogum
- Tabel - olem - сущности
- Veerg = väli - поле
- Rida = kirje - запись
- Primaarne võti - primary key -PK- veerg, unikaalse identifikatooriga (tavaliselt nimetakse id)
- Välisvõti (võõrvõti) - foreign key - FK - veerg, mis loob seose  teise tabeli primaarne võtmega

 ## SQL - structured query language - struktureeritud päringu keel
   - päring - запрос
   - <img width="504" height="411" alt="{858DD690-0B0E-4468-8390-C9E340768F1B}" src="https://github.com/user-attachments/assets/7c86f86b-e60c-4201-a336-6916cea2cf6e" />
1. DDL - Data Definition Language
2. DML - Data Manipulation Language

   ## Piirangud - ограничения - CONSTRAINT (5)
   1. PRIMARY KEY
   2. NOT NULL
   3. CHECK - valik
   4. UNIQUE
   5. FOREIGN KEY
      
   ## Andmetüübid
   ```
   1. int, smallint, decimal(5,2) - numbrilised
   2. varchar(30), char(5), TEXT - tekst/sümbolised
   3. date, time, datetime - kuupäeva
   4. boolean, bit, bool - loogilised
   ```
