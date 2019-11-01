[![Build Status](https://travis-ci.org/obophenotype/upheno.svg?branch=master)](https://travis-ci.org/obophenotype/upheno)

<img src="https://raw.githubusercontent.com/jmcmurry/closed-illustrations/master/logos/upheno-logos/upheno-logo_black-banner.svg?sanitize=true" width="400px"/>

This repository contains common files ontologies and workflows shared
between multiple phenotype ontologies.

See the [wiki](https://github.com/obophenotype/upheno/wiki) for additional documentation

## Inter-ontology Closest Matches

 * [hp-to-mp-bestmatches.tsv](mappings/hp-to-mp-bestmatches.tsv)
 * [hp-to-zp-bestmatches.tsv](mappings/hp-to-zp-bestmatches.tsv)
 * [hp-to-wbphenotype-bestmatches.tsv](mappings/hp-to-wbphenotype-bestmatches.tsv)

See [mappings/README.md](mappings/README.md) for explanation of fields

## Background

Many databases use their own ontology geared towards their species of
interest or an area of interest. The purpose of this repository is to
provide a mechanism for integrating these together into a unified
phenotype ontology. We do this primarily through *OWL Axiomatization*
and *OWL Reasoning*.

This approach takes advantages of the fact that phenotype ontologies
typically follow a compositional structure. If each contributing
ontology makes the semantics of this composition transparent through
*OWL Axioms* then a reasoner can piece the ontologies together and
find the overarching classification.

For example, if a phenotype ontology `A` contains a class for `limb size`,
and also provides an OWL axiom that maps onto a decomposed form, for
example:

 * `A:limb size` equivalentTo `pato:size` and `inheres in` some `limb`

And if phenotype ontology `B` has a class `short forelimb`, with axiom:

 * `B:short forelimb` equivalentTo `pato:short` and `inheres in` some `forelimb`

Then a reasoner can infer that `B:short forelimb` is a subclass of `A:limb size`

The OWL Axioms we use follow a design pattern called `EQ` or `Entity-Quality` descriptions.

Furthermore, if a database `C` provides a row for a genotype described
compositionally, the placement of these phenotypes can also be
inferred.

For background on the original formulation, see:

C J Mungall, Georgios Gkoutos, Cynthia Smith, Melissa Haendel, Suzanna Lewis, Michael Ashburner (2010) [Integrating phenotype ontologies across multiple species](http://genomebiology.com/2010/11/1/R2) _Genome Biology_ 11 (1)

## Exploring uPheno

The Monarch website uses uPheno to group data from multiple species. See for example: https://monarchinitiative.org/phenotype/MP:0003631

You can also query this using Monarch SciGraph services: https://scigraph-ontology.monarchinitiative.org/scigraph/docs/

To understand the mechanics of how uPheno works, we recommend opening
the OWL in Protege and exploring with a fast reasoner such as Elk
running

The remainder of these docs assumes some familiarity with Protege/OWL

We provide various modules:

 * mammal.owl
 * vertebrate.owl
 * metazoa.owl

## Contributing Ontologies

 * [mp](http://obofoundry.org/ontology/mp.html)* - mouse // mammal.owl
 * [hp](http://obofoundry.org/ontology/hp.html)* - human // mammal.owl
 * zp - zebrafish** // vertebrate.owl
 * [wbphenotype](http://obofoundry.org/ontology/wbphenotype.html) - C elegans // metazoa.owl
 * [dpo](http://obofoundry.org/ontology/dpo.html)* - Drosophila  // metazoa.owl
 * [fypo](http://obofoundry.org/ontology/fypo.html)* - Fission Yeast // eukaryote.owl

`*` -- this ontology provides their own OWL axiomatization
`**` -- separately generated ontology

## External Imports Modules

The OWL axiomatization depends on a number of external ontologies, including

 * pato
 * uberon
 * cl
 * species-specific AOs
 * go
 * chebi

Many of these are large, so we create *import modules* in the upheno ontology purl space

See the [imports](imports) directory

## PURLs

This ontology has the OBO PURL `upheno`

A redirect at [obolibrary.org](https://github.com/OBOFoundry/purl.obolibrary.org/) maps

 * http://purl.obolibrary.org/obo/upheno/ ==> this repository on github

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
    * zp.owl ==> http://compbio.charite.de/jenkins/job/zp-owl/
 * wiki ==> https://github.com/obophenotype/upheno ([docs/](docs/) directory)
 
 ## Design patterns
 
 The design patterns are grouped into three higher level groupings:
 1. anatomical entity (anatomical entities (Uberon), cells (CL))
 2. cellular component (from GO)
 3. chemical entity (includes chemicals (CHEBI), proteins (PRO))

