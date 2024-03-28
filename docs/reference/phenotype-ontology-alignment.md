# Aliging species specific phenotype ontologies

Phenotype ontologies use different reference ontologies for their EQs. Everything in uPheno is integrated towards a common set of reference ontologies, in particular Uberon and CL. In order to integrate species-independent anatomy ontologies we employ the following workflow for phenotype ontologies:

1. Create a base-plus module from the ontology
2. Rename all Uberon-aligned entities using ROBOT rename. This replaces basically species specific anatomy references with Uberon anatomy references
3. Delete all species specific references from uPheno (FBBT, XAO, ZFA, etc). This also deletes all EQs which have non-Uberon references.
4. For all remaining species-specific anatomy terms, we retain only the link to the nearest Uberon term.



## Rules for phenotype ontologies to be integrated

1. Every phenotype ontology must export a base module at the proper PURL location
2. Every phenotype ontology must export a upheno export module at the proper PURL location


When two classes are merged in uPheno based on a cross-species mapping, we assert the most general common ancestor as parent.