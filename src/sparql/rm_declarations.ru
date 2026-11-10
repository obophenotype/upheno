PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
DELETE {
  GRAPH ?g {
    ?class rdf:type owl:Class .
  }
}
WHERE {
  GRAPH ?g {
    ?class rdf:type owl:Class .
    FILTER NOT EXISTS {
      ?class ?predicate ?object .
      FILTER (?predicate != rdf:type)
    }
  }
}
