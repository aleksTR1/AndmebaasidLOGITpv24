## Andmebaaside konspektid
[Keys](keys.md) | [Konspekt](kasutaja.md) | [trigerMysql](triger.md) | [trigeridXAMPP](trigeridXAMPP.md) | [Ülesanne_1](ÜL1.md)

# Andmebaasi võtmed (Keys)

Käesolev konspekt selgitab andmebaaside projekteerimisel kasutatavaid võtmeid, nende eesmärke ja erinevusi. Näited on koostatud elektroonika e-poe süsteemi baasil.

---

## 1. Primary Key (Esmased võti / Peavõti)

* **Definitsioon:** Veerg või veergude kogum, mis tuvastab unikaalselt iga kirje (rea) tabelis.
* **Milleks kasutatakse:** Tagab tabeli andmete unikaalsuse ja terviklikkuse. See ei tohi sisaldada tühje (`NULL`) väärtusi ning selle põhjal luuakse automaatselt indeks kiireks otsinguks.
* **Mille poolest erineb:** Tabelis saab olla **ainult üks** Primary Key. See on peamine viis, kuidas teised tabelid viitavad antud tabeli kirjetele.

### SQL Näide:
```sql
CREATE TABLE Kliendid (
    klient_id INT PRIMARY KEY,
    eesnimi VARCHAR(50) NOT NULL,
    perekonnanimi VARCHAR(50) NOT NULL
);

```

### Ekraanipilt:

---

## 2. Foreign Key (Välisvõti)

* **Definitsioon:** Veerg või veergude kogum, mis viitab teise tabeli esmasele võtmele (Primary Key).
* **Milleks kasutatakse:** Kasutatakse tabelite vaheliste seoste loomiseks ja andmete seostusreeglite (referential integrity) tagamiseks. See takistab orbkirjete tekkimist.
* **Mille poolest erineb:** Erinevalt peavõtmest võib välisvõti sisaldada korduvaid väärtusi ja ka `NULL` väärtusi. Ühes tabelis võib olla mitu välisvõtit.

### SQL Näide:

```sql
CREATE TABLE Tellimused (
    tellimus_id INT PRIMARY KEY,
    tellimuse_kuupaev DATE NOT NULL,
    klient_id INT,
    FOREIGN KEY (klient_id) REFERENCES Kliendid(klient_id)
);

```

### Ekraanipilt:

---

## 3. Unique Key (Unikaalne võti)

* **Definitsioon:** Piirang, mis tagab, et kõik väärtused konkreetses veerus või veergude kombinatsioonis on unikaalsed.
* **Milleks kasutatakse:** Kasutatakse selliste andmete kaitsmiseks duplikaatide eest, mis ei ole tabeli peavõtmeks (näiteks isikukood, kasutajanimi või e-post).
* **Mille poolest erineb:** Erinevalt Primary Key'st võib tabelis olla **mitu** unikaalset võtit ja see lubab sisestada `NULL` väärtusi (tavaliselt ühte, sõltuvalt andmebaasisüsteemist).

### SQL Näide:

```sql
CREATE TABLE Kasutajakontod (
    konto_id INT PRIMARY KEY,
    kasutajanimi VARCHAR(30) UNIQUE,
    email VARCHAR(100) UNIQUE,
    klient_id INT,
    FOREIGN KEY (klient_id) REFERENCES Kliendid(klient_id)
);

```

### Ekraanipilt:

---

## 4. Simple Key (Lihtvõti)

* **Definitsioon:** Võti (mis tahes tüüpi), mis koosneb ainult **ühest ainukesest** veerst.
* **Milleks kasutatakse:** Kasutatakse andmebaasi struktuuri lihtsustamiseks, kui unikaalsuse tagamiseks piisab ühest atribuudist.
* **Mille poolest erineb:** Erineb liitvõtmetest (Composite / Compound Key), kuna ei vaja rea unikaalsuse tuvastamiseks teiste veergude abi.

### SQL Näide:

```sql
CREATE TABLE Tooted (
    toode_id INT PRIMARY KEY, -- See on Simple Key, kuna koosneb ühest veerust
    toote_nimi VARCHAR(100) NOT NULL,
    hind DECIMAL(10, 2)
);

```

### Ekraanipilt:

---

## 5. Composite Key (Kombineeritud võti / Liitvõti)

* **Definitsioon:** Võti, mis koosneb kahest või enamast veerust, mis koos tagavad rea unikaalsuse.
* **Milleks kasutatakse:** Kasutatakse juhtudel, kui ükski veerg eraldi ei suuda tagada unikaalsust, kuid nende kombinatsioon on kordumatu.
* **Mille poolest erineb:** Koosneb alati mitmest veerust. Erinevalt Compound Key'st võivad mõned selle osad olla tavalised kirjeldavad atribuudid (näiteks aastaarv või järjekorranumber), mitte tingimata välisvõtmed.

### SQL Näide:

```sql
CREATE TABLE Tootepartii (
    toode_id INT,
    partii_number VARCHAR(20),
    laoseis INT,
    PRIMARY KEY (toode_id, partii_number) -- Liitvõti tavalisest andmest ja ID-st
);

```

### Ekraanipilt:

---

## 6. Compound Key (Liitvõti välisvõtmetest)

* **Definitsioon:** Composite Key alamliik, kus **kõik** võtme koosseisu kuuluvad veerud on samal ajal ka välisvõtmed (Foreign Keys) teistest tabelitest.
* **Milleks kasutatakse:** Kasutatakse peamiselt vahetabelites (junction tables), et realiseerida "mitu-mitmele" (many-to-many) seoseid kahe põhiseose vahel.
* **Mille poolest erineb:** Range piirang: erinevalt tavalisest Composite Key'st ei tohi siin olla ühtegi "tavalist" veergu – iga võtme osa peab olema kuskilt pärinev välisvõti.

### SQL Näide:

```sql
CREATE TABLE Tellimuse_Read (
    tellimus_id INT,
    toode_id INT,
    kogus INT NOT NULL,
    PRIMARY KEY (tellimus_id, toode_id), -- Compound Key
    FOREIGN KEY (tellimus_id) REFERENCES Tellimused(tellimus_id),
    FOREIGN KEY (toode_id) REFERENCES Tooted(toode_id)
);

```

### Ekraanipilt:

---

## 7. Superkey (Supervõti)

* **Definitsioon:** Mis tahes veergude komplekt, mis võimaldab tabeli ridade unikaalset tuvastamist. See võib sisaldada ka üleliigseid veerge, mida tegelikult otseseks tuvastamiseks vaja poleks.
* **Milleks kasutatakse:** Teoreetiline kontseptsioon andmebaasi normaliseerimisel ja kandidaatvõtmete leidmisel.
* **Mille poolest erineb:** Sisaldab "liigset" infot. Näiteks kui tabelis on unikaalne isikukood, siis kombinatsioon `(isikukood + eesnimi)` on supervõti, sest see tuvastab rea unikaalselt, kuigi eesnimi on seal ülearune.

### SQL Näide (Teoreetiline vaade andmetele):

```sql
CREATE TABLE Kullerid (
    kuller_id INT PRIMARY KEY,
    autonumber VARCHAR(10) UNIQUE,
    telefon VARCHAR(20)
);
-- Supervõtmed selles tabelis on: 
-- {kuller_id}, {autonumber}, {kuller_id, telefon}, {autonumber, telefon}, {kuller_id, autonumber, telefon}

```

### Ekraanipilt:

---

## 8. Candidate Key (Kandidaatvõti)

* **Definitsioon:** Minimaalne võimalik supervõti (Superkey), millest ei saa eemaldada ühtegi veergu, ilma et see kaotaks oma unikaalsuse omadust.
* **Milleks kasutatakse:** Nende hulgast valib andmebaasi projekteerija välja selle ühe kõige sobivama, millest saab ametlik Primary Key.
* **Mille poolest erineb:** Erinevalt supervõtmest puudub kandidaatvõtmel igasugune ülearune andmemaht. Kõik kandidaatvõtmed on potentsiaalsed peavõtmed.

### SQL Näide:

```sql
CREATE TABLE Tootja_Tehased (
    tehase_kood INT PRIMARY KEY,      -- Valitud peavõtmeks (Candidate Key 1)
    registrikood VARCHAR(20) UNIQUE,  -- Kandidaatvõti 2
    litsentsi_number VARCHAR(30) UNIQUE -- Kandidaatvõti 3
);

```

### Ekraanipilt:

---

## 9. Alternate Key (Alternatiivne võti)

* **Definitsioon:** Kandidaatvõti (Candidate Key), mida andmebaasi looja **ei valinud** tabeli peavõtmeks (Primary Key).
* **Milleks kasutatakse:** Kasutatakse unikaalsuse tagamiseks teisejärgulistes veergudes. Andmebaasis realiseeritakse see alati `UNIQUE` piirangu abil.
* **Mille poolest erineb:** See on nö "hõbemedali omanik". Kui eelnevas näites sai `tehase_kood` peavõtmeks, siis `registrikood` ja `litsentsi_number` muutusid automaatselt alternatiivseteks võtmeteks.

### SQL Näide:

```sql
-- Tuginedes eelnevale tabelile 'Tootja_Tehased':
-- Kuna 'tehase_kood' on Primary Key, siis 'registrikood' on Alternate Key.
SELECT registrikood FROM Tootja_Tehased WHERE registrikood = 'EE1234567';

```

### Ekraanipilt:

---

## Kasutatud allikad

* W3Schools SQL Constraints & Keys: https://www.w3schools.com/sql/
* GeeksforGeeks - Types of Keys in Relational Database Management System: https://www.geeksforgeeks.org/types-of-keys-in-dbms/
* Database Star - Guide to Database Keys: https://www.databasestar.com/database-keys/

```

```
