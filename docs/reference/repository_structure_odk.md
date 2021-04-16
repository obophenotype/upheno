1.  summary Getting started with OWL phenotype axioms

Introduction
============

This page describes how to get started with the OWL axioms

Opening OWL files in Protege
============================

Unfortunately the full OWL axiomatization is not yet visible in OntoBee,
the best way to view these is to look at them in Protege 4.

You can open any of the PURLs directly in Protege. For example

`* `[`http://purl.obolibrary.org/obo/mp/mp-importer.owl`](http://purl.obolibrary.org/obo/mp/mp-importer.owl)` - for [MP]`\
`* `[`http://purl.obolibrary.org/obo/hp/hp-importer.owl`](http://purl.obolibrary.org/obo/hp/hp-importer.owl)` - for [HP]`

Loading over the web can be slow, so you may want to check files out
locally. Click on the link "source" above to see how to check out the
repo using SVN. Once checked out, you should have a directory structure:

`* `[`src`](http://phenotype-ontologies.googlecode.com/svn/trunk/src/)\
` * `[`ontology`](http://phenotype-ontologies.googlecode.com/svn/trunk/src/ontology/)\
`  * `[`mp`](http://phenotype-ontologies.googlecode.com/svn/trunk/src/ontology/mp/)\
`  * `[`hp`](http://phenotype-ontologies.googlecode.com/svn/trunk/src/ontology/hp/)\
`  * ...`

If you open any of the importer files, Protege will be use the catalog
XML to route requests to the local files.

If you are using [OWLTools], you can use the "--use-catalog" option to
load ontologies using the catalog

Multi-species importers
=======================

`* `[`http://purl.obolibrary.org/obo/upheno/mammal.owl`](http://purl.obolibrary.org/obo/upheno/mammal.owl)\
`* `[`http://purl.obolibrary.org/obo/upheno/vertebrate.owl`](http://purl.obolibrary.org/obo/upheno/vertebrate.owl)\
`* `[`http://purl.obolibrary.org/obo/upheno/metazoa.owl`](http://purl.obolibrary.org/obo/upheno/metazoa.owl)\
`* `[`http://purl.obolibrary.org/obo/upheno/eukaryote.owl`](http://purl.obolibrary.org/obo/upheno/eukaryote.owl)

See Also
========

See also [Imports]
