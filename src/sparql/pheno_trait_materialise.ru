prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

INSERT {

 <http://purl.obolibrary.org/obo/UPHENO_phenotypeToTrait> a owl:ObjectProperty .
 ?subject_id_descendant rdfs:subClassOf [
               owl:onProperty <http://purl.obolibrary.org/obo/UPHENO_phenotypeToTrait> ;
               owl:someValuesFrom ?oba_trait1 ] .     
}

WHERE 
{
  ?subject_id rdfs:subClassOf [
               owl:onProperty <http://purl.obolibrary.org/obo/UPHENO_phenotypeToTrait> ;
               owl:someValuesFrom ?oba_trait1 ] .  

  ?subject_id_descendant rdfs:subClassOf+ ?subject_id .

  FILTER NOT EXISTS {
    ?subject_id_descendant rdfs:subClassOf+ [
               owl:onProperty <http://purl.obolibrary.org/obo/UPHENO_phenotypeToTrait> ;
               owl:someValuesFrom ?oba_trait2 ] . 
    ?oba_trait2 rdfs:subClassOf+ ?oba_trait1 .
    FILTER(?oba_trait1 != ?oba_trait2)
  }

 FILTER( !isBlank(?subject_id))
 FILTER( !isBlank(?subject_id_descendant))
}