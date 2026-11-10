prefix IAO: <http://purl.obolibrary.org/obo/IAO_>
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix oio: <http://www.geneontology.org/formats/oboInOwl#>
prefix def: <http://purl.obolibrary.org/obo/IAO_0000115>
prefix owl: <http://www.w3.org/2002/07/owl#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

INSERT {

 <http://purl.obolibrary.org/obo/UPHENO_phenotypeToTrait> a owl:ObjectProperty .
 ?subject_id rdfs:subClassOf [
               owl:onProperty <http://purl.obolibrary.org/obo/UPHENO_phenotypeToTrait> ;
               owl:someValuesFrom ?object_id ] .     
}

WHERE 
{
  ?subject_id 
        rdfs:subClassOf+ <http://purl.obolibrary.org/obo/UPHENO_0001001> ;
        rdfs:subClassOf+ [
                owl:onProperty <http://purl.obolibrary.org/obo/BFO_0000051> ;
                owl:someValuesFrom ?object_id ] .
  ?object_id rdfs:subClassOf+ <http://purl.obolibrary.org/obo/OBA_0000001> .

#  FILTER NOT EXISTS {
#        ?object_id_more_specific rdfs:subClassOf ?object_id .
#        ?subject_id rdfs:subClassOf+ [
#                owl:onProperty <http://purl.obolibrary.org/obo/BFO_0000051> ;
#                owl:someValuesFrom ?object_id_more_specific ] .
#  }

 FILTER( !isBlank(?subject_id))
 FILTER( !isBlank(?object_id))
}