PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

### RELABEL AMBIGUOUS PATTERN FILLERS FOR DOSDP GENERATION ONLY
# Applied to the ontology dosdp-tools reads labels from, so generated uPheno labels and
# definitions use the new label. The filler keeps its original label as an exact synonym.
# Add a row to VALUES to relabel another filler.

DELETE {
  ?term rdfs:label ?old_label .
}
INSERT {
  ?term rdfs:label ?new_label .
  ?term oboInOwl:hasExactSynonym ?old_label .
}
WHERE {
  VALUES (?term ?new_label) {
    (<http://purl.obolibrary.org/obo/GO_0005634> "cell nucleus") # #972, 'nucleus' clashes with brain nuclei
  }
  ?term rdfs:label ?old_label .
}
