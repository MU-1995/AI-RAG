# Tool Descriptions

AI Agenten har adgang til to søgeværktøjer, som begge er implementeret som separate n8n-workflows.

## 1. Vector Search

**Workflow:** `02 - Opskrift Vector Search - Agent`

**Beskrivelse:**

Søg efter opskrifter ud fra brugerens ønsker og beskrivelser. Brug dette værktøj, når brugeren beskriver en ret, smag eller type mad, de har lyst til.

**Input:**

| Parameter | Type | Beskrivelse |
|---|---|---|
| query | String | Brugerens spørgsmål eller beskrivelse af den type opskrift, de leder efter. |

**Eksempel:**

```text
Jeg vil gerne have noget cremet og krydret med kikærter og kokosmælk.
```

Værktøjet omdanner brugerens spørgsmål til en embedding med Ollama og søger efter lignende opskriftstekster i Neo4j's vector index.

## 2. Graph Search

**Workflow:** `03 - Opskrift Graph Search - Agent`

**Beskrivelse:**

Find opskrifter ud fra konkrete ingredienser og kategorier.

Brug værktøjet, når brugeren spørger efter opskrifter med bestemte ingredienser eller inden for en bestemt kategori.

Hvis brugeren nævner både en ingrediens og en kategori, skal begge oplysninger sendes med, så søgningen finder opskrifter, der opfylder begge krav.

Hvis brugeren kun nævner en ingrediens, udfyld ingredient og lad category være tom.

Hvis brugeren kun nævner en kategori, udfyld category og lad ingredient være tom.

**Input:**

| Parameter | Type | Beskrivelse |
|---|---|---|
| ingredient | String | Den ingrediens, brugeren søger efter. |
| category | String | Den opskriftskategori, brugeren søger efter. |

**Eksempel 1 – Ingrediens:**

```text
ingredient: Kikærter
category:
```

**Eksempel 2 – Kategori:**

```text
ingredient:
category: Vegetarisk
```

**Eksempel 3 – Ingrediens og kategori:**

```text
ingredient: Tomat
category: Vegetarisk
```

Værktøjet bruger Cypher-forespørgsler til at finde opskrifter i Neo4j-grafdatabasen.

## Samspil mellem værktøjerne

AI Agenten vælger værktøj ud fra brugerens spørgsmål:

- Vector Search bruges til semantiske ønsker.
- Graph Search bruges til konkrete ingredienser og kategorier.

Begge værktøjer returnerer oplysninger fra Neo4j-databasen, som AI Agenten bruger til at formulere sit svar.