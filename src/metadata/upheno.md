---
layout: ontology_detail
id: upheno
title: Unified Phenotype Ontology
jobs:
  - id: https://travis-ci.org/obophenotype/upheno
    type: travis-ci
build:
  checkout: git clone https://github.com/obophenotype/upheno.git
  system: git
  path: "."
contact:
  email: 
  label: 
  github: 
description: Unified Phenotype Ontology is an ontology...
domain: stuff
homepage: https://github.com/obophenotype/upheno
products:
  - id: upheno.owl
    name: "Unified Phenotype Ontology main release in OWL format"
  - id: upheno.obo
    name: "Unified Phenotype Ontology additional release in OBO format"
  - id: upheno.json
    name: "Unified Phenotype Ontology additional release in OBOJSon format"
  - id: upheno/upheno-base.owl
    name: "Unified Phenotype Ontology main release in OWL format"
  - id: upheno/upheno-base.obo
    name: "Unified Phenotype Ontology additional release in OBO format"
  - id: upheno/upheno-base.json
    name: "Unified Phenotype Ontology additional release in OBOJSon format"
dependencies:
- id: nbo
- id: pr
- id: go
- id: uberon
- id: ro
- id: chebi
- id: hsapdv
- id: pato
- id: cl
- id: mpath

tracker: https://github.com/obophenotype/upheno/issues
license:
  url: http://creativecommons.org/licenses/by/3.0/
  label: CC-BY
activity_status: active
---

Enter a detailed description of your ontology here. You can use arbitrary markdown and HTML.
You can also embed images too.

