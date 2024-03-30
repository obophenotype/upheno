## Phenotype Data in practice

### Overview

The goals of this document are:

- Give a sense of the contexts in which phenotype data is produced (research and clinical)
- Give a sense of the shape of different styles of phenotype data

### Table of contents

- [Some examples of phenotype data](#examples)
- [Different shapes of phenotype data](#shape)
    - [Pre-coordinated](#precoordinated)
    - [Post-coordinated](#postcoordinated)
    - [Standardised/non-standardized](#standardized)
    - [Quantitative/qualitative](#qual)

<a id="examples"></a>

### Some examples of phenotype data

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

<a id="shape"></a>

### Different shapes of phenotype data

<a id="precoordinated"></a>

Pre-coordinated phenotype data is popular in the clinical domain, where a lot of observations are taken by a clinician and recorded as "phenotypic abnormalities" with the goal of eventual diagnosis.

[Phenopackets](http://phenopackets.org/) such as the one below are an emerging standard to capture and sharing disease and phenotype information. Phenotypic features in particular are captured as so called "pre-coordinated phenotype terms" such as "Attenuation of retinal blood vessels" (HP:0007843). "Pre-coordinated" in this context means that the various [aspects of the phenotype term](../reference/core-concepts.md), such as the _bearer_ ("retinal blood vessels") and the _characteristic_ ("Attenuation", or "thinning/narrowing"), and the _modifier_ (in the case of HPO terms, simply _abnormal_), are combined ("coordinated") into a single term.

??? Phenopacket example

    ```
    {
    "id": "PMID:23559858-Ajmal-2013-BBS1-IV-5/family_A",
    "subject": {
        "id": "IV-5/family A",
        "timeAtLastEncounter": {
        "age": {
            "iso8601duration": "P26Y"
        }
        },
        "sex": "MALE",
        "taxonomy": {
        "id": "NCBITaxon:9606",
        "label": "Homo sapiens"
        }
    },
    "phenotypicFeatures": [
        {
        "type": {
            "id": "HP:0007843",
            "label": "Attenuation of retinal blood vessels"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        },
        {
        "type": {
            "id": "HP:0001513",
            "label": "Obesity"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        },
        {
        "type": {
            "id": "HP:0000608",
            "label": "Macular degeneration"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        },
        {
        "type": {
            "id": "HP:0000486",
            "label": "Strabismus"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        },
        {
        "type": {
            "id": "HP:0001328",
            "label": "Specific learning disability"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        },
        {
        "type": {
            "id": "HP:0000510",
            "label": "Rod-cone dystrophy"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        },
        {
        "type": {
            "id": "HP:0001263",
            "label": "Global developmental delay"
        },
        "evidence": [
            {
            "evidenceCode": {
                "id": "ECO:0000033",
                "label": "author statement supported by traceable reference"
            },
            "reference": {
                "id": "PMID:23559858",
                "description": "A family was reported in which two affected members had a splicing variant in BBS1, c.47+1G>T."
            }
            }
        ]
        }
    ],
    "interpretations": [
        {
        "id": "PMID:23559858-Ajmal-2013-BBS1-IV-5/family_A",
        "progressStatus": "SOLVED",
        "diagnosis": {
            "disease": {
            "id": "OMIM:209900",
            "label": "BARDET-BIEDL SYNDROME 1; BBS1"
            },
            "genomicInterpretations": [
            {
                "subjectOrBiosampleId": "IV-5/family A",
                "interpretationStatus": "CAUSATIVE",
                "variantInterpretation": {
                "variationDescriptor": {
                    "id": "clinvar:1324292",
                    "geneContext": {
                    "valueId": "ENSG00000174483",
                    "symbol": "BBS1",
                    "alternateIds": [
                        "HGNC:966",
                        "entrez:582",
                        "ensembl:ENSG00000174483",
                        "symbol:BBS1"
                    ]
                    },
                    "vcfRecord": {
                    "genomeAssembly": "GRCh37",
                    "chrom": "11",
                    "pos": "66278178",
                    "ref": "G",
                    "alt": "T"
                    },
                    "allelicState": {
                    "id": "GENO:0000136",
                    "label": "homozygous"
                    }
                }
                }
            }
            ]
        }
        }
    ],
    "metaData": {
        "created": "1970-01-01T00:00:00Z",
        "submittedBy": "HPO:probinson",
        "resources": [
        {
            "id": "hp",
            "name": "human phenotype ontology",
            "url": "http://purl.obolibrary.org/obo/hp.owl",
            "version": "2018-03-08",
            "namespacePrefix": "HP",
            "iriPrefix": "http://purl.obolibrary.org/obo/HP_"
        },
        {
            "id": "pato",
            "name": "Phenotype And Trait Ontology",
            "url": "http://purl.obolibrary.org/obo/pato.owl",
            "version": "2018-03-28",
            "namespacePrefix": "PATO",
            "iriPrefix": "http://purl.obolibrary.org/obo/PATO_"
        },
        {
            "id": "geno",
            "name": "Genotype Ontology",
            "url": "http://purl.obolibrary.org/obo/geno.owl",
            "version": "19-03-2018",
            "namespacePrefix": "GENO",
            "iriPrefix": "http://purl.obolibrary.org/obo/GENO_"
        },
        {
            "id": "ncbitaxon",
            "name": "NCBI organismal classification",
            "url": "http://purl.obolibrary.org/obo/ncbitaxon.owl",
            "version": "2018-03-02",
            "namespacePrefix": "NCBITaxon",
            "iriPrefix": "http://purl.obolibrary.org/obo/NCBITaxon_"
        },
        {
            "id": "eco",
            "name": "Evidence and Conclusion Ontology",
            "url": "http://purl.obolibrary.org/obo/eco.owl",
            "version": "2018-11-10",
            "namespacePrefix": "ECO",
            "iriPrefix": "http://purl.obolibrary.org/obo/ECO_"
        },
        {
            "id": "omim",
            "name": "Online Mendelian Inheritance in Man",
            "url": "https://www.omim.org",
            "version": "2018-03-08",
            "namespacePrefix": "OMIM",
            "iriPrefix": "https://omim.org/entry/"
        },
        {
            "id": "clinvar",
            "name": "Clinical Variation",
            "url": "https://www.ncbi.nlm.nih.gov/clinvar/",
            "version": "2023-04-06",
            "namespacePrefix": "clinvar",
            "iriPrefix": "https://www.ncbi.nlm.nih.gov/clinvar/variation/"
        }
        ],
        "phenopacketSchemaVersion": "2.0.0"
    }
    }
    ```

#### Pre-coordinated

- HPO during clinical phenotyping
- Mouse phenotypes

<a id="postcoordinated"></a>

#### Post-coordinated

- Trait + modifier
- Bearer only
- Characteristics + modifier + bearer
- Complex bearers

<a id="standardized"></a>

#### Standardised/non-standardized

<a id="qual"></a>

#### Quantitative/qualitative
