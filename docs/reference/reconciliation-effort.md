# The Phenotype Ontologies Reconciliation Effort

Phenotype ontologies have emerged in the last decade as a means to curate, organise and query phenotypic content. Representing ontologies in a common language, [OWL](https://www.w3.org/TR/owl2-syntax/), facilitated the integration of those ontologies into various tool-chains, such as terminological services ([OLS](https://www.ebi.ac.uk/ols/), [OntoBee](http://www.ontobee.org/)), search engines and more recently sophisticated diagnostic and analytic tools such as [Exomiser](https://github.com/exomiser/Exomiser). The phenotype ontology community has made much progress to date standardising their development practices, in particular by committing to OBO principles.  [OBO principles](http://www.obofoundry.org/principles/fp-000-summary.html) encourage, for example, standard practices for representing identifiers, well-documented and open development practices and some shared standard vocabularies such as the [Relation Ontology](http://www.obofoundry.org/ontology/ro.html) that facilitate integration. 

Despite the wealth of shared practices and a well-developed shared ecosystem of tools such as [Protege](https://protege.stanford.edu/), [Robot](http://robot.obolibrary.org/), [owltools](https://github.com/owlcollab/owltools), and the [OWL API](https://github.com/owlcs/owlapi), phenotype ontologies (and their cousins, disease ontologies) are often not very deeply integrated and interoperable. Entity-quality (EQ) patterns co-evolved with large phenotype ontologies such as the Human Phenotype Ontology (HP), Mammalian Phenotype Ontology (MP) and Zebrafish Phenotype Ontology (ZP) as a means to integrate ontologies without having to manually maintain links between them. EQ patterns allow ontologies to logically define phenotypes in terms of an entity (E, also called the 'bearer'), often an anatomical entity or a biological process, and a (modified) phenotypic quality (Q), such as 'abnormal morphology': For example, 'Abnormal eye morphology' could be defined as an 'abnormal morphology' that inheres in the 'eye'. By using standard vocabularies such as GO or UBERON for representing the entities and PATO for representing the phenotypic qualities, ontologies could now be combined and classified together. 

While EQ patterns are now widespread in the phenotype community, their development was, up until now, mostly disconnected across the different species. Despite frequent manual efforts to align definitions, large proportions of existing ontologies continued to contain logically incompatible definitions, which precludes smooth integration for cross-species queries and inference. The _**Phenotype Ontologies Reconciliation Effort**_ is a community effort that attempts to reconcile logical definition across a number of important phenotype ontologies. The effort was formed as part of the [POTATO](http://icbo2018.cgrb.oregonstate.edu/node/29) (Phenotype Ontologies Traversing All The Organisms) Workshop, co-located with [ICBO](http://icbo2018.cgrb.oregonstate.edu/) 2018. The workshop went into its second iteration in April 2019, co-located with biocuration2019 in Cambridge, UK.

Our [whitepaper (and workshop report)](https://zenodo.org/record/2382757) outlines our objectives and rationale in more detail. 

## Current members

| Ontology | People | Involved Groups | Status |
|----------|--------|-----------------|-----------------|
| [Ascomycete Phenotype Ontology](https://github.com/obophenotype/ascomycete-phenotype-ontology) (APO) | Stacia Engel | Alliance of Genome Resources, Saccharomyces Genome Database | IN | 
| [C. elegans Phenotype Ontology](https://github.com/obophenotype/c-elegans-phenotype-ontology) (WBPheno) |  Chris Grove | Alliance of Genome Resources, WormBase | IN | 
| [Cellular Microscopy Phenotype Ontology](https://github.com/EBISPOT/CMPO) (CMPO) | Simon Jupp | Samples, Phenotypes and Ontologies, EMBL-EBI | IN | 
| [Dictyostelium discoideum phenotype ontology](https://github.com/dictyBase/migration-data/tree/master/ontologies) (DDPHENO) | Petra Fey | dictyBase | IN |
| [Drosophila Phenotype Ontology](https://github.com/FlyBase/flybase-controlled-vocabulary) (DPO) | David Osumi-Sutherland, Clare Pilgrim | FlyBase | IN | 
| [Fission Yeast Phenotype Ontology](https://github.com/pombase/fypo) (FYPO) | Midori A. Harris, Valerie Wood | PomBase | IN | 
| [Human Phenotype Ontology](https://github.com/obophenotype/human-phenotype-ontology) (HP) |  Peter Robinson, Sebastian Koehler, Leigh Carmody, Nicole Vasilevsky | Monarch Initiative | IN | 
| [Mammalian Phenotype Ontology](https://github.com/obophenotype/mammalian-phenotype-ontology) (MP) |  Sue Bello, Anna Anagnostopoulos | Alliance of Genome Resources, MGI | IN | 
| [Phenoscape Knowledge Base](https://github.com/phenoscape) | Jim Balhoff, W. Dahdul | Phenoscape | IN | 
| [PHI-base Phenotype Ontology](https://github.com/PHI-base/phipo) (PHIPO) | Alayne Cuzick | PHI-base | IN | 
| [Planarian Phenotype Ontology](https://github.com/obophenotype/planarian-phenotype-ontology) (PLANP) | Sofia Robb | Stowers Institute for Medical Research | IN | 
| [Plant Trait Ontology](https://github.com/Planteome/plant-trait-ontology) (TO) | Laurel Cooper*, Marie-Angélique Laporte, Pankaj Jaiswal | Planteome, Bioversity | IN | 
| [FuTRES Ontology of Vertebrate Traits](https://github.com/futres/fovt) | Meghan Balk, Ramona Walls | FuTRES | IN |
| [Xenopus Phenotype Ontology](https://github.com/obophenotype/xenopus-phenotype-ontology) (XPO) |  Erik Segerdell | XenBase | IN | 
| [Zebrafish Phenotype Ontology](https://github.com/obophenotype/zebrafish-phenotype-ontology) (ZP) |  Yvonne Bradford |Alliance of Genome Resources, ZFIN | IN |


# Joining

If you are interested in joining the phenotype ontology community, or need help with setting up your own phenotype ontology development environment, please send an email to the [phenotype ontology editors mailing list](mailto:phenotype-ontologies-editors@googlegroups.com). Members of the effort communicate in a bi-weekly teleconference and coordinates most aspects of the reconciliation process through a slack space and GitHub issues.
