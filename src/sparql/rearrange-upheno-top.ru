PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

### PUT ALL THE TOP LEVEL CLASSES UNDER THE UPHENO_0001001 CLASS

INSERT {
  ?class rdfs:subClassOf <http://purl.obolibrary.org/obo/UPHENO_0001001> .
}
WHERE {
  ?class a owl:Class ;
         oboInOwl:inSubset <http://purl.obolibrary.org/obo/upheno#top_level> .
}
