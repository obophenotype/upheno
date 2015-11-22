[![Build Status](https://travis-ci.org/obophenotype/upheno.svg?branch=master)](https://travis-ci.org/obophenotype/upheno)
[![DOI](https://zenodo.org/badge/13996/obophenotype/upheno.svg)](https://zenodo.org/badge/latestdoi/13996/obophenotype/upheno)

This repository contains common files ontologies and workflows shared
between multiple phenotype ontologies.

See [docs/](docs/) for more about phenotype ontologies

## Imports

Currently import modules are shared between MP and HP.

The import modules are created here in the import directory.

A redirect at OCLC maps

 * http://purl.obolibrary.org/obo/upheno/ ==> this repository on github

HP and MP import modules with this prefix

The modules are created using the [Makefile](Makefile) which runs the
OWLAPI SLME via OWLTools.

The mp-edit and hp-edit files are used as seeds. 

## History

Previously we had various things on:

 * https://code.google.com/p/phenotype-ontologies

This was split across multiple github repos

 * {data,server} ==> https://github.com/monarch-initiative/monarch-owlsim-data
 * src/ontology
    * mp ==> https://github.com/obophenotype/mammalian-phenotype-ontology/
    * hp ==> https://github.com/obophenotype/human-phenotype-ontology/ (may change)
    * imports/ ==> https://github.com/obophenotype/upheno
    * monarch.owl ==> https://github.com/monarch-initiative/monarch-ontology
    * zp.owl ==> TODO
 * wiki ==> https://github.com/obophenotype/upheno ([docs/](docs/) directory)

Issues: TODO
