## SQL sever - Kasutajate autemine ja õiguste haldamine

1. Windows Authentication
2. SQL server Authentication

## Kasutaja loomine SQL serveris

serveritaseme kasutaja loomine (Login) Sammud Ava:

Security -> Login; Tee paremklikk ja vali:

New Login...

<img width="710" height="659" alt="{29329B6B-4FD4-4B86-905B-D7A804D72CA8}" src="https://github.com/user-attachments/assets/d594083c-2875-4d39-91bc-b356a1c75b69" />

2. Avame Server Roles:
  
<img width="706" height="665" alt="{CC48522A-2E9A-4149-8541-7D13717AD3B7}" src="https://github.com/user-attachments/assets/a59cea7d-66d9-47d3-bb7d-13654e1b694b" />

Valime Public:

<img width="708" height="658" alt="{7DD0F318-D04B-45EC-B6D6-5C8C0267AE1F}" src="https://github.com/user-attachments/assets/27ad466b-2ab4-4b5c-9f85-e4e86c0aa0f1" />

3. Pärast avame User Mapping:

<img width="707" height="661" alt="{CA4FA8CE-928D-4CD3-8AE2-8A385A78788E}" src="https://github.com/user-attachments/assets/c68ea197-ed54-4fe8-8aa7-a5bd7b84233c" />

  4. SQL commands
     
Grant <- õiguste määramine

Deny <- õiguste keelamine

anname kasutajale õigus vaadata tabelit (SELECT), lisada andmed (INSERT )ning uuendada need(UPDATE)

  ```
  grant select on opilane_table to DirectorTagirov
  grant insert on opilane_table to DirectorTagirov
  grant update on opilane_table to DirectorTagirov
  ```

5. kasutaja õiguste kontroll

<img width="471" height="510" alt="{6439342E-BF35-491C-8FC2-8B58D6ABBC5A}" src="https://github.com/user-attachments/assets/e5088a19-4d42-41fe-b035-0b9894f1363d" />

Kasutaja Director ei saa kasutada Delete:
<img width="824" height="177" alt="{D9B857E1-1D67-4B9B-BEC1-A968007294ED}" src="https://github.com/user-attachments/assets/152267c6-658e-4319-92ab-55547f8ab48f" />

1. Luua tabliet, andmebaas:
````
Create database MovieBaseLogitpv24;

Use MovieBaseLogitpv24;

create table movies(
id int primary key identity(1,1),
moviesNimi varchar(50) not null,
moviesYear int,
movieDir varchar(50),
movieCost decimal(10,2)
)

create table guest(
id int primary key identity(1,1),
name varchar(50)
)

insert into movies(moviesNimi, moviesYear, movieDir, movieCost)
values ('Titanic',1997,'James Cameron',2000000),


insert into guest (name)
values ('Anna');

select * from movies
select * from guest
````
<img width="517" height="430" alt="{0098C5B8-A2B3-4C49-A871-3A8A4ABB8624}" src="https://github.com/user-attachments/assets/5247219e-2ed7-4390-b310-0dd284002bad" />

2. Lisame uus kasutaja: nimetasin kasutaja - Produss
   
<img width="311" height="385" alt="{A1EA9026-47F4-4959-B04B-43A390ABC374}" src="https://github.com/user-attachments/assets/b53eafb6-1005-4547-80ed-0940c42e7159" />


3. õigused
   
```sql
GRANT SELECT, UPDATE (movieDir, movieCost)
ON movies TO Produss;

GRANT INSERT, SELECT
ON guest TO Produss;

DENY DELETE
ON movies TO Produss;

DENY DELETE
ON guest TO Produss;
```

4. Logime sisse nagu Produss ja proovime näiteks kasutada delete:
```
USE MovieBaseLogitpv24;
delete from movies
```
<img width="1130" height="646" alt="{4FD79335-E614-42ED-B8AE-E7A2E56F49EC}" src="https://github.com/user-attachments/assets/cda0a53f-5b12-4391-af9e-d08b0ecca6b2" />

<img width="855" height="388" alt="{953720EC-BE66-4423-998C-FB09D1698390}" src="https://github.com/user-attachments/assets/5e7470c8-456f-4750-b845-71b74f560270" />


