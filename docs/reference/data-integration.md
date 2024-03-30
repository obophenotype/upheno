## Integrating phenotype data using the uPheno framework

### Prerequisites

- [Familiarise yourself with the core concepts](../reference/core-concepts.md)
- [Familiarise the basics of phenotype data](../reference/phenotype-data.md)

### Level 1 integration: Data

Before we get started, let's remind ourselves of the basic structure of phenotype data.

![Core concepts](../images/core_concepts.png)

!!! note "Figure 1: Core concepts"

    Figure 1: _Characteristics_ (A) and _bearers_ of characteristics (B) are the core constituents of traits/biological attributes (C). _Phenotypes_ are comprised of trait terms (C) combined with a modifier (D). Species-specific phenotypes (F), including _phenotypic abnormalities_ defined in the Human Phenotype Ontology (HPO) are feature of diseases (G). Measurements (H), such as assays, quantify or qualify (measure) traits (C).

Phenotype data can be integrated to various degrees into the uPheno framework.

!!! note "The goal of integration is always the same:"

    Associate phenotype data records with pre-coordinated trait and/or phenotype terms.

The [promise of phenotype data integrated this way](../reference/use-cases.md) ranges from simple data aggregation (give me all data pertaining to changed levels of amino acids)
to complex semantic comparisons of phenotypic profiles for matching patients to diseases.

!!! warning

    The question of how to turn phenotype data records into [associations](https://biolink.github.io/biolink-model/association-examples-with-qualifiers/),
    for example for use in a knowledge graph, is out of scope for this document. We are only concerned with how the phenotype described by the data record
    can be integrated.

The "uPheno framework" is a loose term that describes a family of techniques and ontologies. In terms of ontologies, it includes (among others):

- The Phenotype And Trait Ontology (PATO) for the representation of general characteristics (the fact that its called "Phenotype and Trait" is a bit misleading, as it contains a lot of characteristics that are widely used also for environmental data, like `weight` and `amount`)
- The Ontology of Biological Attributes (OBA) for the representation of biological traits
- The Unified Phenotype Ontology (uPheno) for the representation of phenotypic change

As can be seen in Figure 1 at the top of this document, all of these are interconnected:

1. Biological traits (e.g. "lysine level in the blood") in OBA are a direct extension of the "general" characteristics described in PATO (e.g. "level", or "amount").
1. Terms describing phenotypic change (such as "decreased levels of lysine in the blood") are automatically liked to their corresponding traits (at the time of this writing using "has part", for reasons too complicated to explain here)

Integrating all kinds of phenotype data into the "uPheno framework" is a complex process which we will break down in the following.
We will look at a [range of different kinds of phenotype data](../reference/phenotype-data.md) to illustrate the system (not exhaustive!):

- [Integrating cross-species pre-coordinated phenotype data](#cross-species)
- [Integrating post-coordinated phenotype data](#postcoordinated)
- [Integrating quantitative phenotype data](#quantitative)
- [Integrating unstructured phenotype data](#unstructured)

<a id="cross-species"></a>

#### Integrating cross-species pre-coordinated phenotype data

<a id="postcoordinated"></a>

#### Integrating post-coordinated phenotype data

<a id="quantitative"></a>

#### Integrating quantitative phenotype data

<a id="unstructured"></a>

#### Integrating unstructured phenotype data


### Level 2 integration: Knowledge

The real magic with respect to computational phenotype data comes through the integration of knowledge.

!!! info

    Knowledge is an elusive term, but here we mean simply: [qualified associations](https://biolink.github.io/biolink-model/association-examples-with-qualifiers/) to other entities, such as gene-to-phenotype associations.

In the following we discuss a few of the most common forms of knowledge.

1. [Core ontological relationships such as "is-a" or "part-of"](#ontological)
1. [Core phenotype relationships such as "characteristic-of" and "has-modifier"](#phenorel)

<a id="ontological"></a>

Core ontological relationships such as "is-a" or "part-of" are the most boring of all kinds of knowledge, but they already hold a lot of promise.
For example, in Figure 1 above we can see that "Hypolysinemia" (a human phenotype) is a subclass of "decreased level of lysine in the blood" (a species independent class).

This is already nice, but lets look at what we _really_ get when we employ uPheno in Figure 2:

![Core concepts](../images/upheno_hierarchy.png)

!!! note "Figure 1: Core concepts"

    Figure 1: _Characteristics_ (A) and _bearers_ of characteristics (B) are the core constituents of traits/biological attributes (C). _Phenotypes_ are comprised of trait terms (C) combined with a modifier (D). Species-specific phenotypes (F), including _phenotypic abnormalities_ defined in the Human Phenotype Ontology (HPO) are feature of diseases (G). Measurements (H), such as assays, quantify or qualify (measure) traits (C).


This, in turn, is a subclass 

#### Important relationships wrt to phenotype data

- inheres in / characteristic of
- bearer of
