## Integrating phenotype data using the uPheno framework

### Prerequisites

- [Familiarise yourself with the core concepts](../reference/core-concepts.md)
- [Familiarise the basics of phenotype data](../reference/phenotype-data.md)

### Level 1 integration: Data

Before we get started, let's remind ourselves of the basic structure of phenotype data.

![Core concepts](../images/core_concepts.png)

!!! note "Figure 1: Core concepts"

    _Characteristics_ (A) and _bearers_ of characteristics (B) are the core constituents of traits/biological attributes (C). _Phenotypes_ are comprised of trait terms (C) combined with a modifier (D). Species-specific phenotypes (F), including _phenotypic abnormalities_ defined in the Human Phenotype Ontology (HPO) are feature of diseases (G). Measurements (H), such as assays, quantify or qualify (measure) traits (C).

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

_Core ontological relationships_ such as "is-a" or "part-of" are the most boring of all kinds of knowledge, but they already hold a lot of promise.
For example, in Figure 1 above we can see that "Hypolysinemia" (a human phenotype) is a subclass of "decreased level of lysine in the blood" (a species independent class).

This is already nice, but lets look at what we _really_ get when we employ uPheno in Figure 2:

![Core concepts](../images/upheno_hierarchy.png)

!!! note "Figure 2: uPheno class hierarchy excerpt"

    _Characteristics_ (A) and _bearers_ of characteristics (B) are the core constituents of traits/biological attributes (C). _Phenotypes_ are comprised of trait terms (C) combined with a modifier (D). Species-specific phenotypes (F), including _phenotypic abnormalities_ defined in the Human Phenotype Ontology (HPO) are feature of diseases (G). Measurements (H), such as assays, quantify or qualify (measure) traits (C).

Here we can see just how deeply a concept like "Hypolysinemia" can be integrated:

- `Hypolysinemia` is a `decreased level of lysine in blood`
- which is a `changed blood lysine level`
- which is a `changed blood amino acid level`
- which is a `changed blood nitrogen molecular entity level`
- which is a `changed blood chemical entity level`
- which is a `hematopoietic system phenotype`

!!! warning

    The exact naming conventions in uPheno are under review at the moment, so the reader may experience some discrepancies between Figure 2, the listing above, and the [ontology in Monarch's OLS](https://ols.monarchinitiative.org/ontologies/upheno2).

Not everyone will agree that all of these groupings are particularly useful (`changed blood amino acid level` may not have that many realy world use cases), 
but the fact that we _can_ aggregate our data on so many levels is compelling.
For example, we can aggregate all genes associated to phenotype from different species related to any change in the level of lysine in the blood.

<a id="phenorel"></a>

_Core phenotype relationships_ such as "characteristic-of", "has-phenotype-affecting" and "has-modifier" can be extracted directly from the computational
definitions of the uPheno and OBA ontology terms. A nice way to [query some of these relations](https://api.triplydb.com/s/cfAZXUS3V) (example query below) is [Ubergraph](https://github.com/INCATools/ubergraph).

??? Ubergraph query

    PREFIX dcterms: <http://purl.org/dc/terms/>
    PREFIX obo: <http://purl.obolibrary.org/obo/>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX oboInOwl: <http://www.geneontology.org/formats/oboInOwl#>

    SELECT DISTINCT ?phenotype ?phenotype_label ?property_label ?uberon_id ?uberon_label ?property2_label ?chebi_id ?chebi_label
    WHERE {
    ?phenotype rdfs:subClassOf <http://purl.obolibrary.org/obo/HP_0033107> .
    ?phenotype rdfs:label ?phenotype_label .
    
    OPTIONAL {
        ?uberon_id rdfs:subClassOf <http://purl.obolibrary.org/obo/UBERON_0006314> .
        ?uberon_id rdfs:label ?uberon_label .
        ?phenotype ?property ?uberon_id .
        ?property rdfs:label ?property_label .
    }
    
    OPTIONAL {
        ?chebi_id rdfs:subClassOf <http://purl.obolibrary.org/obo/CHEBI_33709> .
        ?chebi_id rdfs:label ?chebi_label .
        ?phenotype ?property2 ?chebi_id .
        ?property2 rdfs:label ?property2_label .
    }
    
    } LIMIT 20

There are many relationships that can be directly extracted from uPheno, including:

- has phenotype affecting: a relationship provided by the uPheno framework that links a phenotypic change to the bearer entity
- has part: linking a trait or phenotype to another trait or phenotype it has as a constituent part
- part of: linking a trait or phenotype to another trait or phenotype it is part of
- in taxon: linking a trait or phenotype to the the specific taxon they are observed in
- characteristic of: linking a trait to a bearer
- characteristic of part of: linking a trait to the location in which the bearer is located (e.g. `blood` in the case of `blood lysine`)
- has modifier: linking a trait to a change modifier such as `abnormal` or `increased`

