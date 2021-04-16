1.  summary Worm Phenotype Ontology
2.  labels Featured

Links
=====

`* Schindelman, Gary, et al. `[`Worm` `Phenotype` `Ontology:`
`integrating` `phenotype` `data` `within` `and` `beyond` `the` `C.`
`elegans`
`community.`](http://www.biomedcentral.com/1471-2105/12/32/)` BMC bioinformatics 12.1 (2011): 32.`\
`* `[`WBPhenotype` `in`
`OntoBee`](http://www.ontobee.org/browser/index.php?o=WBPhenotype)\
`* `[`WBPhenotype` `in`
`OLSVis`](http://ols.wordvis.com/q=WBPhenotype:0000886)

OWL Axiomatization
==================

The OWL axioms for WBPhenotype are in the
[src/ontology/wbphenotype](http://phenotype-ontologies.googlecode.com/svn/trunk/src/ontology/wbphenotype/)
directory on this site.

`* `[`http://purl.obolibrary.org/obo/wbphenotype.owl`](http://purl.obolibrary.org/obo/wbphenotype.owl)` - direct conversion of WormBase-supplied obo file`\
`* `[`http://purl.obolibrary.org/obo/wbphenotype/wbphenotype-importer.owl`](http://purl.obolibrary.org/obo/wbphenotype/wbphenotype-importer.owl)` - imports additional axioms.`

The structure roughly follows that of the [MP]. The worm anatomy is
used.

Editing the axioms
==================

Currently the source is wbphenotype/wbphenotype-equivalence-axioms.obo,
the OWL is generated from here. We are considering switching this
around, so the OWL is edited, using Protege.
