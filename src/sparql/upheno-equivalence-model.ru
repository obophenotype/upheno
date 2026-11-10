PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX obo: <http://purl.obolibrary.org/obo/>
PREFIX oio: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

DELETE { ?x obo:UPHENO_0000002 ?y . 
				 ?x owl:equivalentClass ?eq1 .
 			 	 ?y owl:equivalentClass ?eq2 . }

INSERT { ?y owl:equivalentClass ?x . }

WHERE {
  ?x obo:UPHENO_0000002 ?y .
  OPTIONAL { ?x owl:equivalentClass ?eq1 . }
  OPTIONAL { ?y owl:equivalentClass ?eq2 . }
}