## Using OBA and uPheno in data curation

Authors:

- [James McLaughlin](https://orcid.org/0000-0002-8361-2795)
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

## Pre-requisites

- [Familiarise yourself with the core concepts](../reference/core_concepts.md)

## Examples of phenotype data

| Category                                  | Example datasets                                                                                        | Example phenotype                                           |
|-------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| Gene to phenotype associations            | [Online Mendelian Inheritance in Man (OMIM)](https://www.omim.org/), [Human Phenotype Ontology (HPO)](https://hpo.jax.org/app/), [Gene Ontology (GO)](http://geneontology.org/)                  | Achondroplasia (associated with FGFR3 gene mutations)                                   |
| Gene to disease associations              | [The Cancer Genome Atlas (TCGA)](https://www.cancer.gov/about-nci/organization/ccg/research/structural-genomics/tcga), [Online Mendelian Inheritance in Man (OMIM)](https://www.omim.org/), [GWAS Catalog](https://www.ebi.ac.uk/gwas/) | Breast invasive carcinoma (associated with BRCA1/BRCA2 mutations)                          |
| Phenotype-phenotype semantic similarity   | [Human Phenotype Ontology (HPO)](https://hpo.jax.org/app/), [Unified Medical Language System (UMLS)](https://www.nlm.nih.gov/research/umls/index.html), [Disease Ontology (DO)](http://disease-ontology.org/) | Cardiac abnormalities (semantic similarity with congenital heart defects)                            |
| Quantified trait data (QTL etc)           | [NHGRI-EBI GWAS Catalog](https://www.ebi.ac.uk/gwas/), [Genotype-Tissue Expression (GTEx)](https://gtexportal.org/home/), [The Human Protein Atlas](https://www.proteinatlas.org/) | Height (quantified trait associated with SNPs in genomic regions)                                                |
| Electronic health records                 | [Medical Information Mart for Intensive Care III (MIMIC-III)](https://mimic.physionet.org/), [UK Biobank](https://www.ukbiobank.ac.uk/), [IBM Watson Health](https://www.ibm.com/watson-health) | Acute kidney injury (recorded diagnosis during ICU stay)                                             |
| Epidemiological datasets                  | [Framingham Heart Study](https://framinghamheartstudy.org/), [National Health and Nutrition Examination Survey (NHANES)](https://www.cdc.gov/nchs/nhanes/index.htm), [Global Burden of Disease Study (GBD)](http://www.healthdata.org/gbd) | Cardiovascular disease (epidemiological study of risk factors and disease incidence)                       |
| Clinical trial datasets                   | [ClinicalTrials.gov](https://clinicaltrials.gov/), [European Union Clinical Trials Register (EUCTR)](https://www.clinicaltrialsregister.eu/), [International Clinical Trials Registry Platform (ICTRP)](https://www.who.int/ictrp/en/) | Treatment response (clinical trial data on efficacy and safety outcomes)                                      |
| Environmental exposure datasets           | [Environmental Protection Agency Air Quality System (EPA AQS)](https://www.epa.gov/outdoor-air-quality-data), [Global Historical Climatology Network (GHCN)](https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/global-historical-climatology-network-ghcn), [National Centers for Environmental Information Climate Data Online (NCEI CDO)](https://www.ncdc.noaa.gov/cdo-web/) | Respiratory diseases (association with air pollutant exposure)                                               |
| Population surveys e.g., UK Biobank      | [UK Biobank](https://www.ukbiobank.ac.uk/), [National Health Interview Survey (NHIS)](https://www.cdc.gov/nchs/nhis/index.htm), [National Health and Nutrition Examination Survey (NHANES)](https://www.cdc.gov/nchs/nhanes/index.htm) | Chronic diseases (population-based study on disease prevalence and risk factors)                                |
| Behavioral observation datasets           | [National Survey on Drug Use and Health (NSDUH)](https://www.samhsa.gov/data/data-we-collect/nsduh-national-survey-drug-use-and-health), [Add Health](https://www.cpc.unc.edu/projects/addhealth), [British Cohort Study (BCS)](http://cls.ucl.ac.uk/cls-studies/) | Substance abuse disorders (survey data on drug consumption and addiction)                                    |



## Important relationships wrt to phenotype data

- inheres in / characteristic of
- bearer of


## Types of phenotype data

- Precoordinated phenotype
- Post-coordinated phenotype
- Attribute-measurement

