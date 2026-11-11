
// ==========================================
// Opskrift RAG - Neo4j Database Setup
// ==========================================

// Unikke opskriftsnavne
CREATE CONSTRAINT recipe_name_unique IF NOT EXISTS
FOR (r:Recipe)
REQUIRE r.name IS UNIQUE;

// Unikke ingrediensnavne
CREATE CONSTRAINT ingredient_name_unique IF NOT EXISTS
FOR (i:Ingredient)
REQUIRE i.name IS UNIQUE;

// Unikke kategorinavne
CREATE CONSTRAINT category_name_unique IF NOT EXISTS
FOR (c:Category)
REQUIRE c.name IS UNIQUE;

// Unikke chunk ID'er
CREATE CONSTRAINT chunk_id_unique IF NOT EXISTS
FOR (ch:Chunk)
REQUIRE ch.id IS UNIQUE;

// Vector index til semantisk søgning
CREATE VECTOR INDEX chunk_embedding IF NOT EXISTS
FOR (ch:Chunk)
ON (ch.embedding)
OPTIONS {
  indexConfig: {
    `vector.dimensions`: 768,
    `vector.similarity_function`: 'cosine'
  }
};
