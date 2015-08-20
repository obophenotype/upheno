This repository contains common files ontologies and workflows shared
between multiple phenotype ontologies.

See (docs/)[docs] for details

For more background, please see:

 * Sebastian Köhler, Sandra C Doelken, Barbara J Ruef, Sebastian Bauer, Nicole Washington, Monte Westerfield, George Gkoutos, Paul Schofield, Damian Smedley, Suzanna E Lewis, Peter N Robinson, Christopher J Mungall (2013) [Construction and accessibility of a cross-species phenotype ontology along with gene annotations for biomedical research](http://f1000research.com/articles/2-30/v1) F1000Research
 * C J Mungall, Georgios Gkoutos, Cynthia Smith, Melissa Haendel, Suzanna Lewis, Michael Ashburner (2010) [Integrating phenotype ontologies across multiple species](http://genomebiology.com/2010/11/1/R2) Genome Biology 11 (1)

Getting Started
===============

Please see [GettingStarted] for details on how to work with the OWL
files

OWL axiomatization
==================

The [OWLAxiomatization] page describes how we represent phenotypes in
OWL, and how we reason with the resulting structures

Applications
============

The [Applications] page describes how the OWL axiomatization is used in
applications such as [OWLSim](http://owlsim.org). This also describes
the [CrossSpeciesPhenotypeOntology].

Diseases
========

The primary focus of this repository is on phenotypes, which we consider
distinct from diseases. However the [DiseaseIntegration] page contains
preliminary information on integrating and axiomatization of disease
ontologies.

Traits
======

See [TraitsAndPhenotypes].

Automated builds and QC
=======================

See the
[build-pheno-ontologies](http://build.berkeleybop.org/job/build-pheno-ontologies)
job on the Berkeley jenkins server

Getting phenotype data
======================

Note that this repository is *not* intended to aggregate data - just
the ontologies themselves. For the data, please see the respected
sources, including:

 * [http://human-phenotype-ontology.org/](http://human-phenotype-ontology.org/) (human)
 * [http://informatics.jax.org/](http://informatics.jax.org/) (mouse)
 * [http://wormbase.org](http://wormbase.org) (worm)
 * [http://monarchinitiative.org](http://monarchinitiative.org) (aggregated)
