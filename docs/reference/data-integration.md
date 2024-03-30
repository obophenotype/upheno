## Integrating phenotype data using the uPheno framework

### Prerequisites

- [Familiarise yourself with the core concepts](../reference/core-concepts.md)
- [Familiarise the basics of phenotype data](../reference/phenotype-data.md)

### Level 1 integration: Data

Before we get started, let's remind ourselves of the basic structure of phenotype data.



<figure markdown="span">
  ![Core concepts](../images/core_concepts.png){ width="600" }
  <figcaption>Figure 1: _Characteristics_ (A) and _bearers_ of characteristics (B) are the core constituents of traits/biological attributes (C). _Phenotypes_ are comprised of trait terms (C) combined with a modifier (D). Species-specific phenotypes (F), including _phenotypic abnormalities_ defined in the Human Phenotype Ontology (HPO) are feature of diseases (G). Measurements (H), such as assays, quantify or qualify (measure) traits (C).</figcaption>
</figure>



Phenotype data can be integrated to various degrees into the uPheno framework. The goal of integration is always the same:

Associate phenotype data records with pre-coordinated trait and/or phenotype terms.

!!! note "The goal of integration is always the same:"

    Associate phenotype data records with pre-coordinated trait and/or phenotype terms.

!!! warning

    The question of how to turn phenotype data records into [associations](https://biolink.github.io/biolink-model/association-examples-with-qualifiers/),
    for example for use in a knowledge graph, is out of scope for this document. We are only concerned with how the phenotype described by the data record
    can be integrated.

The "uPheno framework" is a loose term that describes a family of techniques and ontologies. In terms of ontologies, it includes (among others):

- The Phenotype And Trait Ontology (PATO) for the representation of general characteristics (the fact that its called "Phenotype and Trait" is a bit misleading, as it contains a lot of characteristics that are widely used also for environmental data, like `weight` and `amount`)
- The Ontology of Biological Attributes (OBA) for the representation of biological traits
- The Unified Phenotype Ontology (uPheno) for the representation of phenotypic change

As can be seen in Figure 1 at the top of this document, all of these are interconnected:

1. Biological traits in OBA are a direct extension of the "general" characteristics described in PATO.
1. Terms describing phenotypic change (such as in)

Integrating all kinds of phenotype data into the "uPheno framework" is a complex process which we will break down in the following.
We will look at a [range of different kinds of phenotype data](../reference/phenotype-data.md), which is probably not exhaustive.




### Level 2 integration: Knowledge


#### Important relationships wrt to phenotype data

- inheres in / characteristic of
- bearer of
