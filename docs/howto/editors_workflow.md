# Phenotype Ontology Editors' Workflow

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
