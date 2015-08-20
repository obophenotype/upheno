1.  labels Featured
2.  Imported ontologies

Introduction
============

Imports directory:

`* `[`http://purl.obolibrary.org/obo/upheno/imports/`](http://purl.obolibrary.org/obo/upheno/imports/)

Currently the imports includes:

`* imports/chebi_import.owl`\
`* imports/doid_import.owl`\
`* imports/go_import.owl`\
`* imports/mpath_import.owl`\
`* imports/pato_import.owl`\
`* imports/pr_import.owl`\
`* imports/uberon_import.owl`\
`* imports/wbbt_import.owl`

Anatomy
=======

To avoid multiple duplicate classes for heart, lung, skin etc we map all
classes to [Uberon] where this is applicable. For more divergent species
such as fly and C elegans we use the appropriate species-specific
ontology.

Currently there are a small number of highly specific classes in FMA
that are being used and have no corresponding class in Uberon

Methods
=======

We use the OWLAPI SyntacticLocalityModularityExtractor, via [OWLTools].
See the <http://purl.obolibrary.org/obo/upheno/Makefile> for details
