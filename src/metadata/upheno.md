---
layout: ontology_detail
id: upheno
title: upheno
jobs:
  - id: https://travis-ci.org/obophenotype/upheno
    type: travis-ci
build:
  checkout: git clone https://github.com/obophenotype/upheno.git
  system: git
  path: "."
contact:
  email: cjmungall@lbl.gov
  label: Chris Mungall
description: upheno is an ontology...
domain: stuff
homepage: https://github.com/obophenotype/upheno
products:
  - id: upheno.owl
  - id: upheno.obo
dependencies:
 - id: iao
 - id: go
 - id: ro
 - id: pato
 - id: bfo
 - id: chebi
 - id: cl
 - id: uberon
tracker: https://github.com/obophenotype/upheno/issues
license:
  url: http://creativecommons.org/licenses/by/3.0/
  label: CC-BY
---

Enter a detailed description of your ontology here
