## Andmebaaside konspektid
[Keys](keys.md) | [Konspekt](kasutaja.md) | [TrigerMysql](triger.md) | [trigeridXAMPP](trigeridXAMPP.md) | [Ülesanne_1](ÜL1.md)

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

<img width="694" height="582" alt="{DCBA1B2E-C52C-453B-95FA-8B288B741785}" src="https://github.com/user-attachments/assets/da14981f-14ed-4e7d-8359-d7400d547aa1" />
<img width="316" height="91" alt="{FDCE117B-33E2-47AA-8A93-4D5F1B9A915D}" src="https://github.com/user-attachments/assets/f9d0e1bc-8932-43b6-bfa2-5bbd66b43021" />




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

<img width="666" height="311" alt="{B66EFF6B-772D-42CB-AA8B-154A1360A395}" src="https://github.com/user-attachments/assets/5e3b2047-f4bd-4ae2-a773-c9a961cf9641" />
<img width="289" height="110" alt="{7B6B28BA-4223-44A1-96ED-916E591D8334}" src="https://github.com/user-attachments/assets/283a11b2-341d-4938-8df0-1a01247cca8c" />






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

<img width="716" height="612" alt="{5415D058-956A-42B9-B72F-31EEAAC9C21A}" src="https://github.com/user-attachments/assets/e79090f3-29b7-4eb3-a1d3-7a02b57020fa" />
<img width="278" height="109" alt="{E530615F-4AB7-48E1-A938-D4824E0EFF40}" src="https://github.com/user-attachments/assets/3f610515-ad66-4e06-b940-0d9cca2082b4" />





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

<img width="618" height="620" alt="{B4142CB6-F761-4B70-AAD7-9CE1002C0D6C}" src="https://github.com/user-attachments/assets/5c84548e-d953-478b-91f5-074bb5738be5" />
<img width="280" height="92" alt="{0466DBE6-1D7A-4614-B598-FE05C2E15288}" src="https://github.com/user-attachments/assets/304cc364-b2b2-4860-88c7-e0636b171c0c" />





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

<img width="735" height="589" alt="{A2BA73F4-5FD3-4401-A5ED-A0D7DDEFB971}" src="https://github.com/user-attachments/assets/05219355-0029-48f3-9d80-3bc1a5624d92" />
<img width="318" height="95" alt="{51276082-2F45-4522-A9CE-5BDCB973AFA8}" src="https://github.com/user-attachments/assets/0d1771c9-1293-48b3-a974-76557c1e40ee" />




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

<img width="657" height="612" alt="{AB1E5C07-B35E-4F87-9AFF-334F918BED76}" src="https://github.com/user-attachments/assets/8ff264b4-0ec7-41ba-9322-c8182ab365da" />
<img width="301" height="92" alt="{355590A7-8F5E-41B5-89EA-B0B7AD2D1561}" src="https://github.com/user-attachments/assets/2675203e-2638-4264-9b6c-93e2eea58c2c" />



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

<img width="576" height="598" alt="{8512646E-4A53-4A02-8C0E-83AEEC07332C}" src="https://github.com/user-attachments/assets/466fa3cf-c9db-4f43-adf7-212ab42c5df3" />
<img width="297" height="94" alt="{6E25C343-C052-422F-9811-3F8D93E0C083}" src="https://github.com/user-attachments/assets/07f00ca2-ef6f-4763-be56-bed1477f9c50" />



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

<img width="834" height="628" alt="{9C17E6B3-8EA7-48FB-A37C-4C89B66034DE}" src="https://github.com/user-attachments/assets/f8f49e68-8cc6-48f9-b5a5-f0b21db6b026" />
<img width="339" height="89" alt="{D9876EF8-3E9B-4FEA-9C7B-26F22FE76628}" src="https://github.com/user-attachments/assets/98b6f747-f56f-40f4-9ed1-f1120ee5d221" />



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

<img width="903" height="753" alt="{F22F35CD-5557-4AF9-B73B-1C76CC25767A}" src="https://github.com/user-attachments/assets/1ef9d752-23de-46a5-8864-3ee7ebd7f8e0" />
<img width="295" height="75" alt="{B404BD1C-B8FF-44FC-947A-B7D79001380E}" src="https://github.com/user-attachments/assets/b4d2f2e4-a22b-477a-8154-974ab31c751b" />


## Kasutatud allikad

* W3Schools SQL Constraints & Keys: https://www.w3schools.com/sql/
* GeeksforGeeks - Types of Keys in Relational Database Management System: https://www.geeksforgeeks.org/types-of-keys-in-dbms/
* Database Star - Guide to Database Keys: https://www.databasestar.com/database-keys/
