# Example Questions and Test Results

## 1. Formål med testene

Formålet med testene er at undersøge, om Opskrift RAG-systemet kan:

- Søge efter opskrifter ud fra naturlige sproglige beskrivelser.
- Søge efter konkrete ingredienser.
- Kombinere ingredienser og opskriftskategorier.
- Bruge de to søgeværktøjer gennem AI Agenten.
- Returnere relevante oplysninger fra Neo4j-databasen.

## 2. Test af Vector Search

**Testspørgsmål:**

"Jeg vil gerne have noget cremet og krydret med kikærter og kokosmælk."

**Forventet resultat:**

Cremet kikærtekarry.

**Faktisk resultat:**

Vector Search fandt Cremet kikærtekarry med den korrekte beskrivelse, ingredienser og tilberedning.

**Vurdering:** Bestået.

**Observation:**

AI Agenten tilføjede parmesan som serveringsforslag, selvom parmesan ikke indgår i opskriften på Cremet kikærtekarry. Det er en hallucination og viser, at agenten ikke altid overholder begrænsningen om kun at bruge oplysninger fra databasen.

## 3. Test af Graph Search – ingrediens

**Testspørgsmål:**

"Hvilke opskrifter kan jeg lave med kikærter?"

**Input til Graph Search:**

- ingredient: Kikærter
- category: Tom

**Forventet resultat:**

1. Cremet kikærtekarry
2. Middelhavspasta med kikærter
3. Ovnbagte grøntsager med kikærter og tomat

**Faktisk resultat:**

AI Agenten returnerede alle tre forventede opskrifter.

**Vurdering:** Søgningen bestået.

**Observation:**

Agenten samlede ingredienser fra flere opskrifter i én fælles liste. Den nævnte også Cherrytomater, selvom databasen angiver Tomat for ovnretten. Den tilføjede desuden en uopfordret opfordring til at begynde tilberedningen af én bestemt opskrift.

## 4. Test af Graph Search – ingrediens og kategori

**Testspørgsmål:**

"Jeg vil gerne lave noget vegetarisk med tomat. Hvilke opskrifter har I?"

**Input til Graph Search:**

- ingredient: Tomat
- category: Vegetarisk

**Forventet resultat:**

1. Shakshuka med feta
2. Ovnbagte grøntsager med kikærter og tomat

**Faktisk resultat:**

Begge forventede opskrifter blev returneret af Graph Search og AI Agenten.

**Vurdering:** Bestået.

## 5. Test af manglende søgeresultat

**Testspørgsmål:**

"Har I en opskrift med laks?"

**Forventet resultat:**

AI Agenten skal oplyse, at databasen ikke indeholder en opskrift med laks.

**Faktisk resultat:**

AI Agenten svarede, at der fandtes en opskrift med laks, selvom den ikke havde modtaget et opskriftsresultat fra databasen.

Den genererede desuden en ufuldstændig opskriftsskabelon med laks og andre ikke-specificerede ingredienser.

**Vurdering:** Ikke bestået.

**Observation:**

Dette er en hallucination. Agenten overholder ikke systempromptens regel om kun at bruge opskrifter fra Neo4j-databasen.

Fejlen blev observeret og dokumenteret. Systemprompten blev ikke ændret efter testen.

## 6. Samlet testoversigt

| Test | Resultat |
|---|---|
| Vector Search | Bestået med observation |
| Graph Search – ingrediens | Bestået med observation |
| Graph Search – ingrediens og kategori | Bestået |
| Manglende søgeresultat | Ikke bestået |

## 7. Samlet vurdering

Testene viser, at systemet kan udføre både semantisk søgning med Vector Search og struktureret søgning med Graph Search.

Graph Search kunne finde opskrifter ud fra både enkelte ingredienser og kombinationer af ingredienser og kategorier.

Vector Search kunne finde en relevant opskrift ud fra en naturlig sproglig beskrivelse.

Testene viste samtidig begrænsninger ved AI Agentens svar. Agenten tilføjede oplysninger, som ikke fandtes i databasen, og håndterede ikke manglende søgeresultater korrekt.

Disse observationer er medtaget som en del af evalueringen af systemet.