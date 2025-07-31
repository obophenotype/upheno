PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

### PUT ALL CLASSES NOT UNDER A TOP LEVEL CLASS UNDER AN _OTHER_ CLASS

INSERT {
    <http://purl.obolibrary.org/obo/UPHENO_000THER> rdfs:subClassOf <http://purl.obolibrary.org/obo/UPHENO_0001001> .
    <http://purl.obolibrary.org/obo/UPHENO_000THER> rdfs:label "other phenotype (not classified)" .
    ?class rdfs:subClassOf <http://purl.obolibrary.org/obo/UPHENO_000THER> .
}
WHERE {
  ?class a owl:Class ; 
    rdfs:subClassOf* <http://purl.obolibrary.org/obo/UPHENO_0001001> .
  
  # Class does not have the specified inSubset
  FILTER NOT EXISTS {
    ?class oboInOwl:inSubset <http://purl.obolibrary.org/obo/upheno#top_level> .
  }

  # Manually exclude some classes from the rewrite rule
  FILTER NOT EXISTS {
    VALUES ?class { 
        <http://purl.obolibrary.org/obo/UPHENO_0001001> 
        <http://purl.obolibrary.org/obo/UPHENO_0001002>
        <http://purl.obolibrary.org/obo/UPHENO_000THER> 
        <http://purl.obolibrary.org/obo/UPHENO_0034024>
        <http://purl.obolibrary.org/obo/UPHENO_0081815>
        <http://purl.obolibrary.org/obo/UPHENO_0076692>
        <http://purl.obolibrary.org/obo/UPHENO_0002536>
        <http://purl.obolibrary.org/obo/UPHENO_0082875>
        <http://purl.obolibrary.org/obo/UPHENO_0049587>
        <http://purl.obolibrary.org/obo/UPHENO_0006889>
        <http://purl.obolibrary.org/obo/UPHENO_0080300>
    }
    ?class rdf:type owl:Class .
}
  
  # Class does not have an ancestor with the specified inSubset
  FILTER NOT EXISTS {
    ?class rdfs:subClassOf+ ?ancestor .
    ?ancestor oboInOwl:inSubset <http://purl.obolibrary.org/obo/upheno#top_level> .
  }

}