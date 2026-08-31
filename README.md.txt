# Fleet Management System

Kompletan sistem za praćenje, telemetriju i upravljanje voznim parkom u realnom vremenu, zasnovan na IoT hardveru, mašinskom učenju i višekomponentnoj softverskoj arhitekturi.

## Arhitektura i Tehnologije

Projekt je podijeljen u nekoliko ključnih modula:

- **Firmware (`/firmware`):** Kod za ESP32 mikrokontroler zadužen za prikupljanje GPS lokacija (NEO-7M), GSM prijenos (SIM900A) i čitanje OBDII podataka (ELM327).
- **Backend .NET (`/dotnet-backend`):** API servis za obradu podataka i upravljanje bazom podataka.
- **Backend FastAPI & ML (`/ML`):** Python servis zadužen za mašinsko učenje (detekciju anomalija i obradu OBD podataka).
- **Frontend (`/frontend`):** Mobilna aplikacija izrađena u Flutteru za pregled i kontrolu voznog parka.

## Pokretanje projekta

Svaki modul sadrži sopstvene konfiguracije. Za detaljnije upute o pokretanju pojedinačnih servisa, pogledajte dokumentaciju unutar odgovarajućih direktorijuma.