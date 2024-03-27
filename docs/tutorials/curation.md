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
- Measurement
- Phenotypic abnormality
- Disease

### (Phenotypic) Characteristic

"Characteristics" or "qualities" refer to an inherent or distinguishing characteristic or attribute of something or someone.
It represents a feature that defines the nature of an object, organism, or entity and can be used to describe, compare, and categorize different things.
Characteristics can be either qualitative (such as color, texture, or taste) or quantitative (such as height, weight, or age).

The [Phenotype And Trait Ontology (PATO)](https://www.ebi.ac.uk/ols4/ontologies/pato).


Some of the most widely use qualities can be seen in the following tables

| quality | description | example |
| ------- | ----------- | ------- |
| Length ([PATO:0000122](http://purl.obolibrary.org/obo/PATO_0000122)) | A 1-D extent quality which is equal to the distance between two points. | |
| Mass ([PATO:0000128](http://purl.obolibrary.org/obo/PATO_0000128)) | A physical quality that inheres in a bearer by virtue of the proportion of the bearer's amount of matter. | |
| Amount ([PATO:0000070](http://purl.obolibrary.org/obo/PATO_0000070)) | The number of entities of a type that are part of the whole organism. | |
| Morphology ([PATO:0000051](http://purl.obolibrary.org/obo/PATO_0000051)) | A quality of a single physical entity inhering in the bearer by virtue of the bearer's size or shape or structure. | |

Note from the authors: The descriptions above have been taken from PATO, but they are not very.. user friendly.

### Biological Trait/Characteristics

Characteristics such as the one above can be used to describe a variety of entities such as biological, environmental and social.
We are specifically concerned with biological traits, which

### Bearer of Biological Characteristics

In biological contexts, the term **"bearer"** refers to the entity that possesses or carries a particular characteristic or quality. 
The bearer can be any biological entity, such as an organism, an organ, a cell, or even a molecular structure, that exhibits a specific trait or feature.

## Examples

1. **Organism as a Bearer:** 
   - **Example:** A specific tree (such as an oak tree) is the bearer of the characteristic 'height'.
   - **Explanation:** The tree as an organism carries or has the property of height, making it the bearer of this characteristic.
1. **Organ as a Bearer:** 
   - **Example:** The heart of a mammal can be the bearer of the characteristic 'heart size'.
   - **Explanation:** Here, the heart is the organ that possesses the 'heart size' charactertistic. The characteristic ('heart size') is a quality of the heart itself.
1. **Cell as a Bearer:** 
   - **Example:** A red blood cell is the bearer of the characteristic 'cell diameter'.
   - **Explanation:** The diameter is a property of the individual cell. Thus, each red blood cell is the bearer of its diameter measurement.
1. **Molecular Structure as a Bearer:** 
   - **Example:** A DNA molecule can be the bearer of the characteristic 'sequence length'.
   - **Explanation:** The length of the DNA sequence is a property of the DNA molecule itself, making the molecule the bearer of this characteristic.
1. **Genetic Trait as a Bearer:**
   - **Example:** A fruit fly (Drosophila melanogaster) can be the bearer of a genetic trait like eye color.
   - **Explanation:** The organism (fruit fly) carries the genetic information that determines eye color, making it the bearer of this specific trait.

In each example, the **"bearer"** is the entity that has, carries, or exhibits a particular biological characteristic. This concept is fundamental in biology and bioinformatics for linking specific traits, qualities, or features to the entities that possess them, thereby enabling a clearer understanding and categorization of biological diversity and functions.


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

