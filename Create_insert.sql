CREATE DATABASE LOGITpv24baas;
GO

USE LOGITpv24baas;
GO

-- 1. tootaja
CREATE TABLE tootaja(
    tootajaID int PRIMARY KEY identity(1,1),
    eesnimi varchar(15) not null,
    perenimi varchar(30) not null,
    synniaeg date,
    aadress text,
    koormus int CHECK (koormus > 0),
    aktiivne bit
);

-- 2. koolitus
CREATE TABLE koolitus(
    koolitusID int PRIMARY KEY identity(1,1),
    nimetus varchar(255),
    kestvus int,
    algus date,
    lopp date,
    opetaja int
);

-- 3. toovahetus
CREATE TABLE toovahetus(
    toovahetusID int PRIMARY KEY identity(1,1),
    kuupaev date,
    tundideArv int,
    tootajaID int,
    FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID)
);

-- 4. opetamine
CREATE TABLE opetamine(
    opetamineID int PRIMARY KEY identity(1,1),
    tootajaID int,
    koolitusID int,
    tunnistus varchar(50),
    hinne int,
    FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID),
    FOREIGN KEY (koolitusID) REFERENCES koolitus(koolitusID)
);

-- tootaja data
INSERT INTO tootaja (eesnimi, perenimi, synniaeg, aadress, koormus, aktiivne)
VALUES 
('Liis', 'Ilus', '2002-12-04', 'Tallinn', 10, 1),
('Katja', 'Punane', '2012-10-04', 'Tartu', 20, 1),
('Petja', 'Sinine', '2001-05-10', 'Narva', 15, 0);

-- koolitus data
INSERT INTO koolitus (nimetus, kestvus, algus, lopp, opetaja)
VALUES 
('IT kursus', 10, '2026-05-01', '2026-05-05', 1),
('SQL kursus', 15, '2026-05-10', '2026-05-15', 2),
('Python kursus', 20, '2026-06-01', '2026-06-10', 3);

-- toovahetus data
INSERT INTO toovahetus (kuupaev, tundideArv, tootajaID)
VALUES 
('2026-04-15', 3, 1),
('2026-04-16', 5, 2);

-- opetamine data
INSERT INTO opetamine (tootajaID, koolitusID, tunnistus, hinne)
VALUES 
(1, 1, 'Jah', 5),
(2, 1, 'Jah', 4),
(3, 2, 'Ei', 2),
(1, 3, 'Jah', 5),
(2, 2, 'Jah', 3);

-- check
SELECT * FROM tootaja;
SELECT * FROM koolitus;
SELECT * FROM toovahetus;
SELECT * FROM opetamine;

DROP TABLE opetamineCreate Database LOGITpv24baas;

--ab kustutamine
DROP Database veebipood2;


USE LOGITpv24baas;
CREATE TABLE tootaja(
tootajaID int PRIMARY KEY identity(1,1), --identity - automaatselt kasvav arv +1
eesnimi varchar(15) not null,
perenimi varchar(30) not null,
synniaeg date,
aadress TEXT,
koormus int CHECK (koormus>0), --   piirang, et koormus >0
aktiivne bit);

--tabeli kuvamine
SELECT * FROM tootaja;

--andmete lisamine tabelisse
INSERT INTO tootaja(perenimi, eesnimi, synniaeg)
VALUES ('Ilus', 'Liis', '2002-12-4')

INSERT INTO tootaja
VALUES ('Katja', 'Punane', '2012-10-4', 'Tartu', 120, 1),
('Petja', 'Runane', '2002-10-4', 'Narva', 200, 0);

--andmete uuendamine tabelis
UPDATE tootaja SET aadress='Tallinn', koormus=10, aktiivne=1
WHERE tootajaID=1;
