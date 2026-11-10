## MP-HP mappings

The landscape of MP-HP mappings is somewhat complicated, as they are generated / maintained by multiple resources, such as [Monarch Initiative](https://monarchinitiative.org/) and [MGI](https://www.informatics.jax.org/). Here, you will learn the different ways HP-MP mappings are generated, and how to obtain them.

There are two major classes of MP-HP mappings: Semantic Entity Mappings (SEM) and Semantic Similarity Mappings (SSM).

_Semantic Entity Mappings (SEM)_: SEMs are correspondences between two entities which are qualified by explicit semantic relations (e.g. `skos:exactMatch`, the most typical, or `skos:broadMatch` etc, or more exotic ones, like `semapv:crossSpeciesExactMatch`).
For example,  HP:0001640 (Cardiomegaly) and MP:0000274 (enlarged heart) map to each other using the `semapv:crossSpeciesExactMatch`.
We typically represent a number of SEMs using a [SSSOM file](https://mapping-commons.github.io/sssom/), for example (taken from the [uPheno lexical mappings](https://github.com/obophenotype/upheno/blob/master/src/mappings/upheno-lexical.sssom.tsv)):

| subject_id	| predicate_id	| object_id	| mapping_justification | subject_label	| object_label |
| --- | --- | --- | --- | --- | --- |
| HP:0009124	| skos:exactMatch	| MP:0000003	| semapv:LexicalMatching	| Abnormal adipose tissue morphology	| abnormal adipose tissue morphology |
| HP:0008551	| skos:exactMatch	| MP:0000018	| semapv:LexicalMatching	| Microtia	| small ears |
| HP:0001640	| skos:exactMatch	| MP:0000274	| semapv:LexicalMatching	| Cardiomegaly	| enlarged heart |

(The last two are lexical matches because the MP terms carry the exact synonyms "microtia" and "cardiomegaly".)

_Semantic Similarity Mappings (SSM)_: SSMs are correspondences that are, rather than qualified by an explicit mapping relation, qualified by one or more similarity scores. For example, HP:0001640 (Cardiomegaly) and MP:0000274 (enlarged heart) have a Jaccard similarity of 0.56 in PhenIO, the highest of all MP terms compared to Cardiomegaly.
We typically represent a number of SSMs as a [Semantic Similarity Profile](https://incatools.github.io/ontology-access-kit/datamodels/similarity/index.html). The following rows are taken from the [PhenIO HP-MP similarity table](https://data.monarchinitiative.org/semantic-similarity/latest/phenio-monarch-hp-mp.0.4.semsimian.tsv.gz) (only some of the columns are shown):

| subject_id | subject_label | object_id | object_label | ancestor_id | ancestor_label | ancestor_information_content | jaccard_similarity | phenodigm_score |
| ---------- | ------------- | --------- | ------------ | ----------- | -------------- | ---------------------------- | ------------------ | --------------- |
| HP:0001640 | Cardiomegaly | MP:0000274 | enlarged heart | UPHENO:0001471 | increased size of the heart | 13.148 | 0.556 | 2.703 |
| HP:0001640 | Cardiomegaly | MP:0001625 | cardiac hypertrophy | UPHENO:0001471 | increased size of the heart | 13.148 | 0.500 | 2.564 |
| HP:0001640 | Cardiomegaly | MP:0000291 | enlarged pericardium | UPHENO:0076810 | abnormal heart morphology | 7.506 | 0.514 | 1.965 |
| HP:0001640 | Cardiomegaly | MP:0010875 | increased bone volume | UPHENO:0065599 | increased size of the anatomical entity in independent continuant | 5.961 | 0.432 | 1.605 |

The scores are not based on any explicit mappings, but on the shared superclasses of the two terms in the PhenIO class hierarchy (which integrates HP and MP under the species-neutral uPheno terms).
`jaccard_similarity` is the size of the intersection of the two sets of superclasses divided by the size of their union (between 0 and 1).
`ancestor_id` is the most informative common superclass, and `ancestor_information_content` its information content (the rarer the class, the higher).
`phenodigm_score` is the square root of the product of the two.
The table only includes pairs with a Jaccard similarity of at least 0.4 (hence `0.4` in the file name).
As the example shows, a high score does not mean "the same phenotype": the closest pairs share a very specific ancestor, while _increased bone volume_ only shares the very general "increased size of the anatomical entity in independent continuant" with _Cardiomegaly_.

In the following, we describe what kind of MP-HP mappings exist and where to get them.

!!! warning "A human phenotype is not a mammalian phenotype"

    It is critical to understand that the community has made the pragmatic decision to not subsume the HPO (which is about human phenotypes) under the MP ontology (which is scoped as Mammalian), despite the fact that humans are clearly Mammals.
    The rationale is that in the context of [uPheno](https://www.biorxiv.org/content/10.1101/2024.09.18.613276v1), the community sought to avoid any two phenotype ontologies "bleeding into each other".
    Understanding this is beyond the scope of this article, but in summary, the problem is that manual phenotype classification has always been fairly idiosyncratic (e.g. some groups subsume morphological abnormalities under physiological ones), and the community wanted to avoid the one ontology inheriting the classification philosophy of another.

!!! info "What is a matching phenotype?"

    Before you read on, you should remember that matching phenotypes is in many ways a "dark art".
    What does it mean for two phenotypes to "match"?
    The same quality (weight, size, amount) is a characteristic of a (a) homologous (anatomical) structure or (b) of a "conserved" cellular pathway / physiology or (c) of a functionally equivalent behaviour (and similar)?
    There are good and bad reasons for each of these, and many use cases where each of these could be relevant.
    The phenotype ontology community is driven heavily by genetics concerns, so for them, it is crucial that a match has a reasonable chance to correspond to _shared molecular underpinnings_, i.e. corresponding phenotypes are caused by the same (ortholog) genes.
    Therefore, the most beloved HP-MP matches are (1) and (2), while (3) is a bit of a grey area (_abnormal courting behaviour_ in mice can have a considerably different, even disjoint, genetic profile associated with it compared to _abnormal courting behaviour_ in frogs).

!!! warning "If you are looking for shared genetic underpinnings, most cross-species mappings are wrong"

    One of the most misunderstood aspects about phenotype matching is that a match magically reveals candidate genes across species.
    _This is generally wrong_.
    A worm tail is not the same as a mouse tail, even if we call it the same, and the genes involved in letting the mouse tail grow longer are likely not quite the same as those letting the tail of _C. elegans_ grow longer.
    However, it [has been proven](https://pmc.ncbi.nlm.nih.gov/articles/PMC3649640/) that there _is_ indeed a lot of signal, especially between species that are not too distant taxonomically such as mice and humans, and this signal can be used, effectively, for a variety of applications [such as clinical diagnostics](https://pmc.ncbi.nlm.nih.gov/articles/PMC7230372/).
    It is best we understand cross-species phenotype matches as _candidates for shared molecular underpinnings_ - and then expect them, in most cases, to fail as such.

### HP-MP Semantic Entity Mappings

!!! warning "There is no single HP-MP mapping"

    There is no _single_ HP-MP mapping out there.
    Several groups have created mappings, and there are some places where those mappings are collected and collated, but it is still important to understand their origin.

There are four approaches to determining MP-HP Semantic Entity Mappings (the fourth is not yet used in production).

1. [Manual curation](#manual): Usually for specific projects curators have been funded to manually link phenotypes in one ontology to the other.
2. [Lexical matching](#lexical): Without considering the ontologies, the labels of the phenotype terms in HP and MP are analysed, preprocessed and, if possible, matched.
3. [Logical matching](#logical): In essence, if two phenotype terms have equivalent logical definitions, they are considered a logical match.
4. [AI-assisted matching](#llm): LLMs have a good "grasp" of language and can bridge the gap between manual curation and lexical matching by their ability to handle lexical variation much better.

We will discuss all four mappings types as follows and where to get them from.

<a id="manual"></a>

#### Manually curated HP-MP mappings

Currently, most manual HP-MP mapping efforts are, or should be, coordinated in the [Mouse-Human Ontology Mapping Initiative (MHMI)](https://github.com/mapping-commons/mh_mapping_initiative). The two most important manual curation efforts are the MGI and the IMPC HP-MP mappings.

_The MGI HP-MP mappings_: Driven by [Mouse Genome Informatics (MGI)](https://www.informatics.jax.org/) at JAX, these mappings are curated manually to enable search on the MGI webpages ([source](https://doi.org/10.1093/genetics/iyae031)).
There are currently more than 1500 mappings, curated [here](https://github.com/mapping-commons/mh_mapping_initiative/blob/master/mappings/mp_hp_mgi_all.sssom.tsv).

_The IMPC HP-MP mappings_: Driven by the International Mouse Phenotyping Consortium (IMPC), these mappings are manually curated for the purpose of data integration and analysis. An example for the Eye Morphology related mappings can be [found here](https://github.com/mapping-commons/mh_mapping_initiative/blob/master/mappings/mp_hp_eye_impc.sssom.tsv).

<a id="lexical"></a>

#### Lexical matching

Lexical mappings are those that are determined by deterministic lexical rules, for example "exact lexical matches" after applying some explicit preprocessing rules (such as whitespace removal or case normalisation).

There are two pipelines currently generating uPheno lexical mappings: a custom pipeline implemented in Python (which predates OAK), and an OAK lexmatch pipeline. Both run as part of the uPheno release, driven by the [uPheno Makefile](https://github.com/obophenotype/upheno/blob/master/src/ontology/upheno.Makefile).

_The custom lexical matching pipeline_ is essentially a Python function (`generate_mapping_files(..)` in [`src/scripts/lib.py`](https://github.com/obophenotype/upheno/blob/master/src/scripts/lib.py)) that combines a bunch of preprocessing with a SSSOM export. It is run by the `generate-cross-species-mappings` command of [`src/scripts/upheno_build.py`](https://github.com/obophenotype/upheno/blob/master/src/scripts/upheno_build.py), which merges its lexical matches with the logical matches (see below) into the uPheno cross-species mapping set. There are a lot of custom rules for labels in this script, so it is unclear how much of it is covered by the much more standardised OAK pipeline.

_The OAK lexical matching pipeline_ runs with every uPheno release and simply executes OAK lexmatch (see the `$(TMPDIR)/upheno-species-lexical-oak.sssom.tsv` goal in the [uPheno Makefile](https://github.com/obophenotype/upheno/blob/master/src/ontology/upheno.Makefile)); the `skos:exactMatch` mappings are then published as `upheno-lexical.sssom.tsv`.
The matching rules are maintained in a special [rules file](https://github.com/obophenotype/upheno/blob/master/src/ontology/config/upheno-match-rules.yaml).
OAK lexmatch leverages synonyms and preprocessing to compute candidate mapping across all classes in an ontology in an efficient manner.

<a id="logical"></a>

#### Logical matching

The uPheno release system computes up to date logical matches with every release and combines them with the custom lexical matches into the cross-species mapping set.
In the past, the reasoner was used to compute logical matches; at the moment, logical matches are determined through a quick structural check.
Both come down to the same thing:

!!! info "When are two phenotypes considered logical matches?"

    Two phenotypes P1 and P2 are considered logical matches if their EQ-logical definitions are equivalent under cross-species conflation assumption.
    This means, in practical terms: if the EQ logical definition refers to the same characteristics and the bearer of P1 corresponds to the bearer of P2 either by virtue of being identical (e.g. the same GO biological process) or of being cross-species exact matches (e.g. two species specific anatomical classes are exact matches to the same Uberon class), we consider P1 and P2 a "logical match".

Note that you do not need a reasoner for this task: you can just map all bearer entities to their species-independent integration ontologies, and then just match the bearer entities exactly using string equivalence.

<a id="llm"></a>

#### AI-assisted matching

There are no active pipelines that generate production ready mappings using LLMs, and uPheno does not publish any LLM-generated mappings.
We plan to use [OntoGPT's MapperGPT](https://monarch-initiative.github.io/ontogpt/functions/#categorize-mappings) and OAK's [validate-mappings](https://incatools.github.io/ontology-access-kit/cli.html#runoak-validate-mappings) command to scale our mapping efforts in the future.

### Mapping availability

| Mapping set | Maintainers | Format | Description |
| ----------- | ----------- | ------ | ----------- |
| [HP-MP (manually curated)](https://github.com/mapping-commons/mh_mapping_initiative/tree/master/mappings) | Monarch Initiative, MGI, IMPC and others. | [SSSOM](https://mapping-commons.github.io/sssom) | Mapping sets connected HP to MP terms curated manually by multiple organisations. |
| [uPheno integration mappings](https://data.monarchinitiative.org/mappings/latest/upheno-species-independent.sssom.tsv) | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) with species-neutral phenotype terms in uPheno. |
| [uPheno cross-species mappings](https://data.monarchinitiative.org/mappings/latest/upheno-cross-species.sssom.tsv) | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) to each other based on the custom lexical matching pipeline and logical matching (EQ definitions). It contains no manually curated mappings. |
| [uPheno lexical mappings (OAK)](https://github.com/obophenotype/upheno/blob/master/src/mappings/upheno-lexical.sssom.tsv) | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) to each other based on simple lexical matching using OAK (`skos:exactMatch` only). |
| [PhenIO semantic similarity matches](https://data.monarchinitiative.org/semantic-similarity/latest/index.html) | Monarch Initiative | [OAK Semantic Similarity](https://w3id.org/oak/similarity) | These are the semantic similarity matches computed over PhenIO, which contains uPheno. |
