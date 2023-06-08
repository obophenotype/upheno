# Phenotype Ontology Editors' Workflow

### Useful links
* [Phenotype Ontology Working Group Meetings agenda and minutes gdoc](https://docs.google.com/document/d/1WrQanAMuccS-oaoAIb9yWQAd4Rvy3R3mU01v9wHbriM/)
* [phenotype-ontologies slack channel](https://phenotype-ontologies.slack.com/archives/CCWEMEJM8/p1685549784709229): to send meeting reminders; ask for agenda items; questions; discussions etc.
* Dead simple owl design pattern (DOS-DP) [Documentation](https://incatools.github.io/dead_simple_owl_design_patterns/)
    * [Getting started with DOSDP templates](https://oboacademy.github.io/obook/tutorial/dosdp-overview/)
    * [Dead Simple Ontology Design Patterns (DOSDP)](https://oboacademy.github.io/obook/tutorial/dosdp-template/)
    * [Using DOSDP templates in ODK Workflows¶](https://oboacademy.github.io/obook/tutorial/dosdp-odk/)
* Validate DOS-DP yaml templates:
    1. [yamllint](https://yamllint.readthedocs.io/en/stable/): yaml syntax validator
        * [Installing yamllint](https://formulae.brew.sh/formula/yamllint): `brew install yamllint`
    2. [DOS-DP validator:](https://incatools.github.io/dead_simple_owl_design_patterns/validator/): DOS-DP format validator
        * [Installing ](https://github.com/INCATools/dead_simple_owl_design_patterns): `pip install dosdp`

Patternisation is the process of ensuring that all entity quality (EQ) descriptions from textual phenotype term definitions have a logical definition pattern. A pattern is a standard format for describing a phenotype that includes a quality and an entity. For example, "increased body size" is a pattern that includes the quality "increased" and the entity "body size." The goal of patternisation is to make the EQ descriptions more uniform and machine-readable, which facilitates downstream analysis.

## 1. Identify a group of related phenotypes from diverse organisms

The first step in the Phenotype Ontology Editors' Workflow is to identify a group of related phenotypes from diverse organisms. This can be done by considering proposals from phenotype editors or by using the pattern suggestion pipeline.
The phenotype editors may propose a group of related phenotypes based on their domain knowledge, while the pattern suggestion pipeline uses semantic similarity and shared [Phenotype And Trait Ontology (PATO)](https://www.ebi.ac.uk/ols4/ontologies/pato) quality terms to identify patterns in phenotype terms from different organism-specific ontologies.

## 2. Propose a phenotype pattern

Once a group of related phenotypes is identified, the editors propose a phenotype pattern. To do this, they create a Github issue to request the phenotype pattern template in the uPheno repository.
Alternatively, a new template can be proposed at a phenotype editors' meeting which can lead to the creation of a new term request as a Github issue.
Ideally, the proposed phenotype pattern should include an appropriate [PATO](https://www.ebi.ac.uk/ols4/ontologies/pato) quality term for logical definition, use cases, term examples, and a textual definition pattern for the phenotype terms.



## 3. Discuss the new phenotype pattern draft at the regular uPheno phenotype editors meeting

The next step is to discuss the new phenotype pattern draft at the regular uPheno phenotype editors meeting. During the meeting, the editors' comments and suggestions for improvements are collected as comments on the DOS-DP `yaml` template in the corresponding Github pull request. Based on the feedback and discussions, a consensus on improvements should be achieved.
The DOS-DP `yaml` template is named should start with a lower case letter, should be informative, and must include the PATO quality term.
A Github pull request is created for the DOS-DP `yaml` template.

* A DOS-DP phenotype pattern template example:


```yaml
---
pattern_name: ??pattern_and_file_name

pattern_iri: http://purl.obolibrary.org/obo/upheno/patterns-dev/??pattern_and_file_name.yaml

description: 'A description that helps people chose this pattern for the appropriate scenario.'

#  examples:
#    - example_IRI-1  # term name
#    - example_IRI-2  # term name
#    - example_IRI-3  # term name
#    - http://purl.obolibrary.org/obo/XXXXXXXXXX  # XXXXXXXX

contributors:
  - https://orcid.org/XXXX-XXXX-XXXX-XXXX  # Yyy Yyyyyyyyy

classes:
  process_quality: PATO:0001236
  abnormal: PATO:0000460
  anatomical_entity: UBERON:0001062

relations:
  characteristic_of: RO:0000052
  has_modifier: RO:0002573
  has_part: BFO:0000051

annotationProperties:
  exact_synonym: oio:hasExactSynonym
  related_synonym: oio:hasRelatedSynonym
  xref: oio:hasDbXref

vars:
  var??: "'anatomical_entity'"  # "'variable_range'"

name:
  text: "trait ?? %s"
  vars:
    - var??

annotations:
  - annotationProperty: exact_synonym
    text: "? of %s"
    vars:
      - var??

  - annotationProperty: related_synonym
    text: "? %s"
    vars:
      - var??

  - annotationProperty: xref
    text: "AUTO:patterns/patterns/chemical_role_attribute"

def:
  text: "A trait that ?? %s."
  vars:
    - var??

equivalentTo:
  text: "'has_part' some (
    'XXXXXXXXXXXXXXXXX' and
    ('characteristic_of' some %s) and
    ('has_modifier' some 'abnormal')
    )"
  vars:
    - var??
...
```

## 4. Review the candidate phenotype pattern

Once a consensus on the improvements for a particular template is achieved, they are incorporated into the DOS-DP `yaml` file. Typically, the improvements are applied to the template some time before a subsequent ontology editor's meeting. There should be enough time for off-line review of the proposed pattern to allow community feedback.
The improved phenotype pattern candidate draft should get approval from the community at one of the regular ontology editors' call or in a Github comment.
The ontology editors who approve the pattern provide their ORCIDs and they are credited as contributors in an appropriate field of the DOS-DP pattern template.

## 5. Add the community-approved phenotype pattern template to uPheno
Once the community-approved phenotype pattern template is created, it is added to the uPheno Github repository.
The approved DOS-DP `yaml` phenotype pattern template should pass quality control (QC) steps.
1. Validate yaml syntax: [yamllint](https://formulae.brew.sh/formula/yamllint)
2. Validate DOS-DP
Use [DOSDP Validator](https://github.com/INCATools/dead_simple_owl_design_patterns/blob/master/docs/validator.md).
* To install:
```sh
pip install dosdp
```
* To validate a template using the command line interface:
```sh
dosdp validate -i <test.yaml or 'test folder'>
```

After QC, the responsible editor merges the approved pull request, and the phenotype pattern becomes part of the uPheno phenotype pattern template collection.
