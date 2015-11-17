Introduction
============

This page describes the generation of the zebrafish phenotype ontology

Details
=======

The ZP differs considerably from [HP], [MP] and others. ZFIN do not
annotate with a pre-composed phenotype ontology - all annotations
compose phenotypes on-the-fly using a combination of PATO, ZFA, GO and
other ontologies.

We use these combinations to construct ZP on the fly, by naming each
distinct combination, assigning it an ID, and placing it in the
hierarchy.

The process is described here:

-   Sebastian Köhler, Sandra C Doelken, Barbara J Ruef, Sebastian Bauer,
    Nicole Washington, Monte Westerfield, George Gkoutos, Paul
    Schofield, Damian Smedley, Suzanna E Lewis, Peter N Robinson,
    Christopher J Mungall (2013) [Construction and accessibility of a
    cross-species phenotype ontology along with gene annotations for
    biomedical research](http://f1000research.com/articles/2-30/v1)
    F1000Research

The OWL formalism for ZFIN annotations is described here:

-   [<https://docs.google.com/document/d/1Vbokc9aFHR4awNE6DrrLtgpE6axeTS4VEfxqDHsWyPQ/edit>\#
    Mapping ZFIN phenotypes to OWL]

The java implementation is here:

-   https://github.com/sba1/bio-ontology-zp

OWL Axiomatization
==================

The OWL axioms for ZP are in 
[zp.owl](https://compbio.charite.de/hudson/job/zp-owl/lastSuccessfulBuild/artifact/)
that is build on our hudson server.
