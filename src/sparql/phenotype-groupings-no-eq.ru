PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX semapv: <https://w3id.org/semapv/vocab/>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

### I WILL KEEP THIS QUERY FOR FUTURE REFERENCE
### BUT IT IS NOT USED IN THE PIPELINE

CONSTRUCT {
  ?phenotype_grouping a owl:Class ;
                      rdfs:label ?grouping_label ;
                      rdfs:subClassOf ?uph_parent .

                       ?phenotype1 rdfs:subClassOf ?phenotype_grouping .
                       ?phenotype2 rdfs:subClassOf ?phenotype_grouping .
}
WHERE {
  ?phenotype1 semapv:crossSpeciesExactMatch ?phenotype2 .

  # Get labels
  ?phenotype1 rdfs:label ?label1 .
  ?phenotype2 rdfs:label ?label2 .

  FILTER (!STRSTARTS(STR(?phenotype1), "http://purl.obolibrary.org/obo/UPHENO_"))
  FILTER (!STRSTARTS(STR(?phenotype2), "http://purl.obolibrary.org/obo/UPHENO_"))

  # Avoid existing groupings based on shared direct superclasses
  FILTER NOT EXISTS {
    ?phenotype1 semapv:crossSpeciesExactMatch ?common .
    ?phenotype2 semapv:crossSpeciesExactMatch ?common .
    FILTER STRSTARTS(STR(?common), "http://purl.obolibrary.org/obo/UPHENO_")
  }

  # Generate a grouping class IRI
  BIND(IRI(CONCAT("http://purl.obolibrary.org/obo/UPHENO_", 
  REPLACE(STR(?phenotype1), "http://purl.obolibrary.org/obo/", ""), 
  "_", 
  REPLACE(STR(?phenotype2), "http://purl.obolibrary.org/obo/", "")
)) AS ?phenotype_grouping)
  # Generate a label
  BIND(CONCAT(?label1, " / ", ?label2) AS ?grouping_label)

  # Find UPHENO_ superclasses of either phenotype1 or phenotype2
  {
    ?phenotype1 rdfs:subClassOf ?uph_parent .
    FILTER STRSTARTS(STR(?uph_parent), "http://purl.obolibrary.org/obo/UPHENO_")
  }
  UNION
  {
    ?phenotype2 rdfs:subClassOf ?uph_parent .
    FILTER STRSTARTS(STR(?uph_parent), "http://purl.obolibrary.org/obo/UPHENO_")
  }
}
