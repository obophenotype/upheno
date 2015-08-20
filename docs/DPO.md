1.  summary Drosophila Phenotype Ontology

`* `[`The` `Drosophila` `phenotype`
`ontology`](http://www.jbiomedsem.com/content/4/1/30/abstract)` Osumi-Sutherland et al, J Biomed Sem.`

The DPO is formally a subset of FBcv, made available from
<http://purl.obolibrary.org/obo/fbcv/dpo.owl>

Phenotypes in FlyBase may either by assigned to FBcv (dpo) classes, or
they may have a phenotype\_manifest\_in to FBbt (anatomy).

For integration we generate the following ontologies:

`* `[`http://purl.obolibrary.org/obo/upheno/imports/fbbt_phenotype.owl`](http://purl.obolibrary.org/obo/upheno/imports/fbbt_phenotype.owl)\
`* `[`http://purl.obolibrary.org/obo/upheno/imports/uberon_phenotype.owl`](http://purl.obolibrary.org/obo/upheno/imports/uberon_phenotype.owl)\
`* `[`http://purl.obolibrary.org/obo/upheno/imports/go_phenotype.owl`](http://purl.obolibrary.org/obo/upheno/imports/go_phenotype.owl)\
`* `[`http://purl.obolibrary.org/obo/upheno/imports/cl_phenotype.owl`](http://purl.obolibrary.org/obo/upheno/imports/cl_phenotype.owl)

(see Makefile)

This includes a phenotype class for every anatomy class - the IRI is
suffixed with "PHENOTYPE". Using these ontologies, Uberon and CL
phenotypes make the groupings.

We include

`* `[`http://purl.obolibrary.org/obo/upheno/dpo/dpo-importer.owl`](http://purl.obolibrary.org/obo/upheno/dpo/dpo-importer.owl)

Which imports dpo plus auto-generated fbbt phenotypes.

The dpo-importer is included in the [MetazoanImporter]

Additional Notes
----------------

We create a local copy of fbbt that has "Drosophila " prefixed to all
labels. This gives us a hierarchy:

`* eye phenotype (defined using Uberon)`\
` * compound eye phenotype  (defined using Uberon)`\
`  * drosophila eye phenotype (defined using FBbt)`

TODO
----

`* `[`http://code.google.com/p/cell-ontology/issues/detail?id=115`](http://code.google.com/p/cell-ontology/issues/detail?id=115)` ensure all CL to FBbt equiv axioms are present (we have good coverage for Uberon)`
