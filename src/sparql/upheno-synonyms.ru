PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>
PREFIX obo: <http://purl.obolibrary.org/obo/>


INSERT {
	?phenotype oboInOwl:hasExactSynonym ?synonym .
}

WHERE {
  VALUES ?property {
    obo:IAO_0000118
    oboInOwl:hasExactSynonym
    rdfs:label
  }
  ?phenotype ?property ?label .
  FILTER(regex(str(?label),"variant") || regex(str(?label),"abnormally") || regex(str(?label),"aberrant") || regex(str(?label),"abnormal"))
  BIND(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(lcase(STR(?label)),
            "aberrant ", "phenotype "),
            " aberrant", " phenotype"),
            "abnormal ", "phenotype "),
            " abnormal", " phenotype"),
            "variant ", "phenotype "),
            " variant", " phenotype"),
            " abnormally", " phenotype"),
            "abnormally ", "phenotype ") as ?synonym)
}