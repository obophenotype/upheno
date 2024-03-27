# Using OBA and uPheno in data curation

Authors:

- [James McLaughlin]()
- [Nicolas Matentzoglu](https://orcid.org/0000-0002-7356-1779)

Last update: 27.03.2024.

## Overview

Phenotyping is, in essence, the process of recording the observable characteristics, or phenotypic profile, of an organism. 
There are many use cases for doing this task: clinicians have to record a patient's phenotypic profile to facilitate more accurate diagnosis. 
Researchers have to record phenotypic profiles of model organisms to characterise them to assess interventions (genetic or drug or otherwise). 
Curators that seek to build a knowledge base which contains associations between phenotypes and other data types need to extract information about phenotypes from often unstructured data sources. 

All of these are different processes, but the essence is the same: a set of observable characteristics has to be recorded using terms from a controlled vocabulary.

There are different schools about how to record phenotypes in a structured manner. 
Quantified phenotypes can be recorded using either a trait in combination with a measurement datum (“head circumference”, “35 cm”) or a qualified term expressing “phenotypic change” (“increased head circumference”). 
Furthermore, we can express phenotype terms as “pre-coordinated” terms, like “increased head circumference” or a “post-coordinated expression”, like “head”, “circumference”, “increased”). In the following, we will describe the different concepts and categories around phenotype data, and provide an introduction on how to best use them.

## Core concepts

<!-- Add figure with all core components from OBA poster -->

- Phenotypic characteristic
- Bearer
- Biological attribute
- Phenotypic abnormality
- Disease

### (Phenotypic) Characteristic

"Characteristics" or "qualities" refer to an inherent or distinguishing characteristic or attribute of something or someone.
It represents a feature that defines the nature of an object, organism, or entity and can be used to describe, compare, and categorize different things.
Characteristics can be either qualitative (such as color, texture, or taste) or quantitative (such as height, weight, or age).

Some of the most widely use qualities can be seen in the following tables

| quality | description | example |
| ------- | ----------- | ------- |
| Length ([PATO:0000051](http://purl.obolibrary.org/obo/PATO_0000051)) | A physical quality that inheres in a bearer by virtue of the proportion of the bearer's amount of matter. | |
| Mass ([PATO:0000128](http://purl.obolibrary.org/obo/PATO_0000128)) | A physical quality that inheres in a bearer by virtue of the proportion of the bearer's amount of matter. | |
| Level ([PATO:0000128](http://purl.obolibrary.org/obo/PATO_0000128)) | A physical quality that inheres in a bearer by virtue of the proportion of the bearer's amount of matter. | |
| Morphology ([PATO:0000051](http://purl.obolibrary.org/obo/PATO_0000051)) | A quality of a single physical entity inhering in the bearer by virtue of the bearer's size or shape or structure. | |



### Biological Trait

### Phenotypic abnormality

- Nature of "comparators" in the notion of a phenotypic abnormality.
- In database curation you are effectively de-contextualising the phenotype term, which means you loose the original comparator.
- normal changed wildtype comparator

### Disease

## Important relationships wrt to phenotype data

- inheres in / characteristic of
- bearer of

## Examples of phenotype data

1. gene to phenotype associations
1. gene to disease assocations
1. phenotype - phenotype semantic similarity
1. Quantified trait data (QTL etc)

## Types of phenotype data

- Precoordinated phenotype
- Post-coordinated phenotype
- Attribute-measurement

