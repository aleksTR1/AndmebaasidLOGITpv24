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








