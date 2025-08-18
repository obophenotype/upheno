PREFIX semapv: <https://w3id.org/semapv/vocab/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

INSERT {
  ?pheno_id1 rdf:type owl:Class .
  ?pheno_id2 rdf:type owl:Class .
  # Massive hack for
  semapv:crossSpeciesExactMatch a owl:AnnotationProperty .
  ?pheno_id2 semapv:crossSpeciesExactMatch ?pheno_id1
}
WHERE {
    ?pheno_id1 semapv:crossSpeciesExactMatch ?pheno_id2 .
}
