## The uPheno reconciliation workflow: Standard Operating Procedures


The reconciliation workflow is devided in the following subproblems:


1. Patternisation: The process of defining patterns for groups of related phenotypes, such as "abnormal morphology of anatomical entity". The goal is to increase
   coverage of EQs that correspond to uPheno patterns.
1. Pattern review: The process of reviewing pattern instances (usually in a spreadsheet) and determine if 
   (a) the pattern used for defining the phenotype is apropriate and
   (b) the fillers used for defining the phenotypes are appropriate
   (c) the inferences facilitated by a pattern are appropriate
   The goal of pattern review is to determine if EQs that correspond to uPheno patterns are appropriate for a given phenotype.
1. Pattern reconciliation: The process of ensuring that two different groups defining an _analogous_ phenotype are using (a) the same pattern and (b) the same or analogous fillers.

In this document, we will describe how each of these are executed in practice (standard operating procedures).


### Patternisation

Patternisation is the process of defining patterns for groups of related phenotypes, ...

There are two separate SOPs, one for new terms, and one for retrofitting defined phenotypes with EQs with a formal pattern.

**SOP: New Terms**:

- When a new term is added, the corresponding EQ logical definition should only be defined if a pattern exist. The curator checks the uPheno pattern library.
  Only if no suitable pattern is found, the curator can proceed to defining a new pattern (see SOP "Add new pattern to uPheno pattern library" below).

**SOP: Create patterns for existing EQs

- Match using a generic pattern
- What to do if EQ differs widely

**SOP: Add new pattern to uPheno pattern library**

- A new pattern is suggested on an issue tracker.
- A pull request is created proposing the new pattern.
- ....

### Pattern review

The process of reviewing pattern instances (usually in a spreadsheet) and determine if 
 (a) the pattern used for defining the phenotype is apropriate and
 (b) the fillers used for defining the phenotypes are appropriate
 (c) the inferences facilitated by a pattern are appropriate (this can be seen as a sub-problem of (b))
 The goal of pattern review is to determine if EQs that correspond to uPheno patterns are appropriate for a given phenotype.

**SOP:**

- Describe the workflow you have been running with MP

### Pattern reconciliation

The process of ensuring that two different groups defining an _analogous_ phenotype are using (a) the same pattern and (b) the same or analogous fillers. 
This includes the case where 1 ontology has an EQ, and the other does not.

**SOP:**

- Describe here all your ideas for this process, and how you currently do it with MP (Sue, Anna) and HP (Leigh).
