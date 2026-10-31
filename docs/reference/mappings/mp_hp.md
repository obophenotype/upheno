## MP-HP mappings

The landscape of MP-HP mappings is somewhat complicated, as they are generated / maintained by multiple resources, such as [Monarch Initiative](https://monarchinitiative.org/) and [MGI](https://www.informatics.jax.org/). Here, you will learn the different ways HP-MP mappings are generated, and how to obtain them.

There are two major classes of MP-HP mappings: Semantic Entity Mappings (SEM) and Semantic Similarity Mappings (SSM).

_Semantic Entity Mappings (SEM)_: SEMs are correspondences between two entities which are qualified by explicit semantic relations (e.g. `skos:exactMatch`, the most typical, or `skos:broadMatch` etc, or more exotic ones, like `semapv:crossSpeciesExactMatch`).
For example,  HP:0001640 (Cardiomegaly) and MP:0000274 (enlarged heart) map to each other using the `semapv:crossSpeciesExactMatch`.
We typically represent an number of SEMs using a [SSSOM file](https://mapping-commons.github.io/sssom/), for example:

| subject_id	| predicate_id	| object_id	| mapping_justification | subject_label	| object_label |
| --- | --- | --- | --- | --- | --- |
| HP:0009124	| skos:exactMatch	| MP:0000003	| semapv:LexicalMatching	| Abnormal adipose tissue morphology	| abnormal adipose tissue morphology |
| HP:0008551	| skos:exactMatch	| MP:0000018	| semapv:LexicalMatching	| Microtia	| small ears |
| HP:0000411	| skos:exactMatch	| MP:0000021	| semapv:LexicalMatching	| Protruding ear	| prominent ears |

_Semantic Similarity Mappings (SSM)_: SSMs are correspondences that are, rather than qualified by an explicit mapping relation, qualified by a similarity score between 0 and 1. For example HP:0001640 (Cardiomegaly) and MP:0000274 (enlarged heart) have, depending on the semantic similarity algorithm used, a semantic similarity of 1.0 (entirely similar).
We typically represent a number of SSMs as a [Semantic Similarity Profile](https://incatools.github.io/ontology-access-kit/datamodels/similarity/index.html), for example:

| subject_id | subject_label | subject_source | object_id | object_label | object_source | ancestor_id | ancestor_label | ancestor_source | object_information_content | subject_information_content | ancestor_information_content | jaccard_similarity | cosine_similarity | dice_similarity | phenodigm_score |
| ---------- | --------------------------- | -------------- | ---------- | ---------------------------------------------------------- | ------------- | -------------- | -------------- | --------------- | -------------------------- | --------------------------- | ---------------------------- | ------------------ | ----------------- | --------------- | --------------- |
| HP:0100624 | Corpus cavernosum sclerosis | | MP:0009103 | abnormal penile bone morphology | | UPHENO:0003055 | | | | | 2.416 | 0.203 | | | 0.701 |
| HP:0100624 | Corpus cavernosum sclerosis | | MP:0011528 | abnormal placental labyrinth villi branching morphogenesis | | UPHENO:0003055 | | | | | 2.416 | 0.214 | | | 0.720 |
| HP:0100624 | Corpus cavernosum sclerosis | | MP:0003205 | testicular atrophy | | UPHENO:0002682 | | | | | 5.394 | 0.191 | | | 1.015 |
| HP:0100624 | Corpus cavernosum sclerosis | | MP:0009256 | enlarged corpus epididymis | | UPHENO:0002523 | | | | | 3.686 | 0.234 | | | 0.930 |

In the following, we describe what kind of MP-HP mappings exist and where to get them.

!!! warning A Human phenotype is Not a Mammalian phenotype!?!

    It is critical to understand that the community has made the pragmatic decision to not subsume the HPO (which is about human phenotypes) under the MP ontology (which is scoped as Mammalian), despite the fact that humans are clearly Mammals. 
    The rationale is that in the context of [uPheno](https://www.biorxiv.org/content/10.1101/2024.09.18.613276v1), the community sought to avoid any two phenotype ontologies "bleeding into each other". 
    Understanding this is beyond the scope of this article, but in summary, the problem is that manual phenotype classification has always been fairly ideosyncractic (e.g. some groups subsume morphological abnormalities under physiological ones), and the community wanted to avoid the one ontology inheriting the classification philosophy of another.

!!! info What is a "matching" phenotype?

    Before you read on, you should remember that matching phenotypes is in many ways a "dark art".
    What does it mean for two phenotypes to "match"?
    The same quality (weigh, size, amount) is a characteristic of a (a) homologous (anatomical) structure or (b) of a "conserved" cellular pathway / physiology or (c) of a functionally equivalent behaviour (and similar)?
    There are good and bad reasons for each of these, and many use cases where each of these could be relevant.
    The phenotype ontology community is driven heavily by genetics concerns, so for them, it is crucial that a match has a reasonable chance correspond to _shared molecular underpinnings_, i.e. corresponding phenotypes are caused by the same (ortholog) genes.
    Therefore, the most beloved HP-MP matches are (1) and (2), while (3) is a bit of a grey area (_abnormal courting behaviour_ in mice can have a considerably different, even disjoint, genetic profile associated with it compared to _abnormal courting behaviour_ in frogs).

!!! warning If you are looking for shared genetic underpinnings most cross-species mappings are wrong.

    One of the most misunderstood aspects about phenotype matching is that a match magically reveals candidate genes across species.
    _This is generally wrong_.
    A worm tail is not the same as a mouse tail, even if we call it the same, and the genes involved in letting the mouse tail grow longer are likely not quite the same as those letting the tail of the _C. Elegans_ tail grow longer.
    However, it [has been proven](https://pmc.ncbi.nlm.nih.gov/articles/PMC3649640/) that there _is_ indeed a lot of signal, especially between species that are not too distant taxonomically such as mice and humans, and this signal can be used, effectively, for a variety of applications [such as clinical diagnostics](https://pmc.ncbi.nlm.nih.gov/articles/PMC7230372/).
    It is best we understand cross-species phenotype matches as _candidates for shared molecular underpinnings_ - and then expect them, in most cases, to fail as such.

### HP-MP Semantic Entity Mappings

!!! warning "THE" HP-MP mapping does not exist

    There is no _single_ HP-MP mapping out there.
    Several groups have created mappings, and there are some places where those mappings are collected and collated, but it is still important to understand their origin.

There are four approaches that are currently being used to determine MP-HP Semantic Entity Mappings mappings.

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

Lexical mappings are those that are determined by determinstic lexical rules, for example "exact lexical matches" after applying some explicit preprocessing rules (such as whitespace removal or case normalisation).

There are two pipelines currently generating uPheno mappings: a custom pipeline implemented in python (which predates OAK), and an OAK lexmatch pipeline. Both live in the [uPheno pipeline repo](https://github.com/obophenotype/upheno-dev/blob/master/src/ontology/upheno.Makefile), but are probably going to be moved, soon, to the [uPheno repo](https://github.com/obophenotype/upheno/blob/master/src/ontology/upheno.Makefile).

_The Custom lexical matching pipeline_ is essentially [a python function (`generate_mapping_files(..)`) that combines a bunch of preprocessing with a SSSOM export](https://github.com/obophenotype/upheno-dev/blob/c12d11d973d622296c9750903b2423791fa40e1e/src/scripts/lib.py#L2056). There are a lot of custom rules for labels in this script, so it is unclear how much of it is covered by the much more standardised OAK pipeline.

_The OAK lexical matching pipeline_ runs with every uPheno release and simply executes OAK lexmatch (see `$(TMPDIR)/upheno-species-lexical-oak.sssom.tsv` goal in https://github.com/obophenotype/upheno-dev/blob/master/src/ontology/upheno.Makefile).
The matching rules are maintained in a special [rules file](https://github.com/obophenotype/upheno-dev/blob/master/src/ontology/config/upheno-match-rules.yaml).\
OAK lexmatch leverages synonyms and preprocessing to compute candidate mapping across all classes in an ontology in an efficient manner.

<a id="logical"></a>

#### Logical matching

The uPheno release system publishes both up to date logical and lexical matches.
In the past, the reasoner was used to computer logical matches; at the moment, logical matches are determined through a quick structural check.
Both come down to the same thing: 

!!! info When are two phenotypes the considered "logical matches"?

    Two phenotypes P1 and P2 are considered logical matches if their EQ-logical definitions are equivalent under cross-species conflation assumption.
    This means, in practical terms: if the EQ logical definition refers to the same characteristics and the bearer of P1 corresponds to the bearer of P2 either by virtue of being identical (e.g. the same GO biological process) or of being cross-species exact matches (e.g. two species specific anatomical classes are exact matches to the same Uberon class), we consider P1 and P2 a "logical match".

Note that you do not need a reasoner for this task: you can just map all bearer entities to their species-indepdent integration ontologies, and then just match the bearer entities exactly using string equivalence.

<a id="llm"></a>

#### AI-assisted matching

There are no active pipelines that generate production ready mappings using LLMs.
We have plan to use [OntoGPTs MapperGPT](https://monarch-initiative.github.io/ontogpt/functions/#categorize-mappings) and OAKs [validate-mappings](https://incatools.github.io/ontology-access-kit/cli.html#runoak-validate-mappings) command to scale our mapping efforts in the near future (early 2025).

### Mapping availability

| Mapping set | Maintainers | Format | Description |
| ----------- | ----------- | ------ | ----------- |
| [HP-MP (manually curated)](https://github.com/mapping-commons/mh_mapping_initiative/tree/master/mappings) | Monarch Initiative, MGI, IMPC and others. | [SSSOM](https://mapping-commons.github.io/sssom) | Mapping sets connected HP to MP terms curated manually by multiple organisations. |
| [uPheno integration mappings](https://data.monarchinitiative.org/mappings/latest/upheno-species-independent.sssom.tsv) | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) with species-neutral phenotype terms in uPheno. |
| uPheno cross-species mappings | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) to each other based on lexical matching, logical matching and manual curation. |
| uPheno lexical mappings (OAK) | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) to each other based on simple lexical matching using OAK. |
| uPheno lexical mappings (Custom) | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) to each other based on simple lexical matching. |
| uPheno logical mappings | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | This mapping set is generated as part of the uPheno pipeline and links HPO and MP terms (among others) to each other based solely on their EQ logical definition. |
| uPheno Mapper GPT mappings | Monarch Initiative | [SSSOM](https://mapping-commons.github.io/sssom) | TBD. |
| [PhenIO semantic similarity matches](https://data.monarchinitiative.org/semantic-similarity/latest/index.html) | Monarch Initiative | [OAK Semantic Similarity](https://w3id.org/oak/similarity) | These are the semantic similarity matches computed over PhenIO, which contains uPheno. |
