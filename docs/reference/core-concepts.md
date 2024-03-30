## Traits and phenotypes - the Conceptual model

### Overview

<!-- Add figure with all core components from OBA poster -->

### Table of contents

- [General characteristic](#characteristics)
- [Bearer](#bearer)
- [Biological attributes](#attributes)
- [Measurement](#measurements)
- [Phenotypic change](#change)
- [Disease](#disease)

<a id="characteristics"></a>

### General characteristics

"Characteristics" or "qualities" refer to an inherent or distinguishing characteristic or attribute of something or someone.
It represents a feature that defines the nature of an object, organism, or entity and can be used to describe, compare, and categorize different things.
Characteristics can be either qualitative (such as color, texture, or taste) or quantitative (such as height, weight, or age).

The [Phenotype And Trait Ontology (PATO)](https://www.ebi.ac.uk/ols4/ontologies/pato) is the reference ontology for general characteristics in the OBO world.

Some of the most widely use characteristics can be seen in the following tables

| quality | description | example |
| ------- | ----------- | ------- |
| Length ([PATO:0000122](http://purl.obolibrary.org/obo/PATO_0000122)) | A 1-D extent quality which is equal to the distance between two points. | |
| Mass ([PATO:0000128](http://purl.obolibrary.org/obo/PATO_0000128)) | A physical quality that inheres in a bearer by virtue of the proportion of the bearer's amount of matter. | |
| Amount ([PATO:0000070](http://purl.obolibrary.org/obo/PATO_0000070)) | The number of entities of a type that are part of the whole organism. | |
| Morphology ([PATO:0000051](http://purl.obolibrary.org/obo/PATO_0000051)) | A quality of a single physical entity inhering in the bearer by virtue of the bearer's size or shape or structure. | |

Note from the authors: The descriptions above have been taken from PATO, but they are not very.. user friendly.

<a id="attributes"></a>

### Biological Trait/Characteristics/Attribute

Characteristics such as the one above can be used to describe a variety of entities such as biological, environmental and social.
We are specifically concerned with biological traits, which are characteristics that refer to an inherent characteristic of a biological entity, such as an organ (the heart), a process (cell division), a chemical entity (lysine) in the blood.

The [Ontology of Biological Attributes (OBA)](https://www.ebi.ac.uk/ols4/ontologies/oba) is the reference ontology for biological characteristics in the OBO world.
There are a few other ontologies that describe biological traits, such as the [Vertebrate Phenotype Ontology](https://www.ebi.ac.uk/ols4/ontologies/vt) and the [Ascomycete Phenotype Ontology (APO)](https://www.ebi.ac.uk/ols4/ontologies/apo), but these are more species specific, and, more importantly, are not integrated in the wider [EQ modelling framework](../reference/eq.md).

| Property    | Example term        | Definition                                 |
|-------------|-------------------|--------------------------------------------|
| Length      | OBA:VT0002544     | The length of a digit.                     |
| Mass        | OBA:VT0001259     | The mass of a multicellular organism.      |
| Level       | OBA:2020005       | The amount of lysine in blood.            |
| Morphology  | OBA:VT0005406     | The size of a heart.                       |


<a id="bearer"></a>

### Bearer of Biological Characteristics

In biological contexts, the term **"bearer"** refers to the entity that possesses or carries a particular characteristic or quality.
The bearer can be any biological entity, such as an organism, an organ, a cell, or even a molecular structure, that exhibits a specific trait or feature.
Some examples:

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

<a id="change"></a>

### Phenotypic change

A phenotypic change refers to some deviation from reference morphology, physiology, or behavior.
This is the most widely used, and most complicated category of phenotype terms for data specialists to understand.

Conceptually, a phenotypic abnormality comprises:

- a biological attribute (which includes a biological bearer)
- an "change" modifier
- (optionally) a directional modifier (increased / decreased)
- a comparator

Biological attributes such as `blood lysine amount` (OBA:2020005) have been discussed [earlier in this document](#attributes).
The most widely used change modifier used in practice is `abnormal` (PATO:0000460).
This modifier signifies that the phenotypic change term describes a deviation that is abnormal, such as "Hyperlysinemia" (HP:0002161), which describes and increased concentration of lysine in the blood.
Other modifiers include `normal` (PATO:0000461), which describes a change within in the normal range (sometimes interpreted as "no change").
A directional modifier like `increased` (PATO:0040043) or `decreased` (PATO:0040042). In practice, most of our "characteristic" terms have specialised directional variants such as `decreased amount` (PATO:0001997) which can be used to describe phenotypes.
Comparators are the most confusing aspects of phenotypic change. 
The first question someone has to ask when they see a concept describing is change like `increased blood lysine levels` is "compared to what?". 
Depending on biological context, the assumed comparators vary widely. 
For example, in clinical phenotyping, it is mostly assumed that
a phenotypic feature corresponds to a deviation from the normal range, see [HPO docs](https://obophenotype.github.io/human-phenotype-ontology/documentation/clinicians/).

- Nature of "comparators" in the notion of a phenotypic abnormality.
- In database curation you are effectively de-contextualising the phenotype term, which means you loose the original comparator.
- normal changed wildtype comparator

The [Unified Phenotype Ontology (uPheno)](https://www.ebi.ac.uk/ols4/ontologies/upheno) is the reference ontology for biological abnormalities in the OBO world.
There are a many species-specific ontologies in the OBO world, such as the Mammalian Phenotype Ontology (MP), the Human Phenotype Ontology (HPO) and the Drosophila Phenotype Ontology (DPO), see [here](../reference/components.md).

| Property    | Example term | Definition |
|-------------|-------------------|------------------------------------------------|
| Length      | UPHENO:0072215    | Increased length of the digit.                |
| Mass        | UPHENO:0054299    | Decreased multicellular organism mass.        |
| Level       | UPHENO:0034327    | Decreased level of lysine in blood.           |
| Morphology  | UPHENO:0001471    | Increased size of the heart.                  |


<a id="confused"></a>

### Concepts that are related and often confused with phenotype terms

<a id="disease"></a>

#### Disease



<a id="measurements"></a>

#### Measurements

In biological data curation, it’s essential to differentiate between measurements and traits. Measurements, such as “blood glucose amount,” are quantitative indicators, providing numerical values. In contrast, traits, like “Hyperglycemia,” encompass both qualitative and quantitative characteristics, representing broader phenotypic states. This difference is crucial in ontology modeling, where measurements are directly linked to specific values, while traits reflect more comprehensive biological attributes. For example, “body temperature” is a measurement, whereas “Fever” represents a trait associated with elevated temperatures. Understanding this contrast is fundamental for accurate data representation and interpretation, ensuring nuanced understanding of biological entities and phenotypic variability.
