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

The interested reader should familiarise themselves with some of the following resources.
They are a tiny glimpse into the diverse world of phenotype data, and the purpose of this list
is to convince how prevalent and diverse phenotype data is across the biomedical domain.

| Category | Example datasets | Example phenotype |
|---|---|---|
| Gene to phenotype associations | [Online Mendelian Inheritance in Man (OMIM)](https://www.omim.org/), [Human Phenotype Ontology (HPO) annotations](https://hpo.jax.org/app/), [Gene Ontology (GO)](http://geneontology.org/) | Achondroplasia (associated with FGFR3 gene mutations) |
| Gene to disease associations | [The Cancer Genome Atlas (TCGA)](https://www.cancer.gov/about-nci/organization/ccg/research/structural-genomics/tcga), [Online Mendelian Inheritance in Man (OMIM)](https://www.omim.org/), [GWAS Catalog](https://www.ebi.ac.uk/gwas/) | Breast invasive carcinoma (associated with BRCA1/BRCA2 mutations)                          |
| Phenotype-phenotype semantic similarity | [Human Phenotype Ontology (HPO)](https://hpo.jax.org/app/), [Monarch Initiative](https://monarchinitiative.org/) | Cardiac abnormalities (semantic similarity with congenital heart defects) |
| Quantified trait data (QTL etc) | [NHGRI-EBI GWAS Catalog](https://www.ebi.ac.uk/gwas/), [Genotype-Tissue Expression (GTEx)](https://gtexportal.org/home/), [The Human Protein Atlas](https://www.proteinatlas.org/) | Height (quantified trait associated with SNPs in genomic regions) |
| Electronic health records | [Medical Information Mart for Intensive Care III (MIMIC-III)](https://mimic.physionet.org/), [UK Biobank](https://www.ukbiobank.ac.uk/), [IBM Watson Health](https://www.ibm.com/watson-health) | Acute kidney injury (recorded diagnosis during ICU stay) |
| Epidemiological datasets | [Framingham Heart Study](https://framinghamheartstudy.org/), [National Health and Nutrition Examination Survey (NHANES)](https://www.cdc.gov/nchs/nhanes/index.htm), [Global Burden of Disease Study (GBD)](http://www.healthdata.org/gbd) | Cardiovascular disease (epidemiological study of risk factors and disease incidence) |
| Clinical trial datasets | [ClinicalTrials.gov](https://clinicaltrials.gov/), [European Union Clinical Trials Register (EUCTR)](https://www.clinicaltrialsregister.eu/), [International Clinical Trials Registry Platform (ICTRP)](https://www.who.int/ictrp/en/) | Treatment response (clinical trial data on efficacy and safety outcomes) |
| Environmental exposure datasets | [Environmental Protection Agency Air Quality System (EPA AQS)](https://www.epa.gov/outdoor-air-quality-data), [Global Historical Climatology Network (GHCN)](https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/global-historical-climatology-network-ghcn), [National Centers for Environmental Information Climate Data Online (NCEI CDO)](https://www.ncdc.noaa.gov/cdo-web/) | Respiratory diseases (association with air pollutant exposure) |
| Population surveys e.g., UK Biobank | [UK Biobank](https://www.ukbiobank.ac.uk/), [National Health Interview Survey (NHIS)](https://www.cdc.gov/nchs/nhis/index.htm), [National Health and Nutrition Examination Survey (NHANES)](https://www.cdc.gov/nchs/nhanes/index.htm) | Chronic diseases (population-based study on disease prevalence and risk factors) |
| Behavioral observation datasets | [National Survey on Drug Use and Health (NSDUH)](https://www.samhsa.gov/data/data-we-collect/nsduh-national-survey-drug-use-and-health), [Add Health](https://www.cpc.unc.edu/projects/addhealth), [British Cohort Study (BCS)](http://cls.ucl.ac.uk/cls-studies/) | Substance abuse disorders (survey data on drug consumption and addiction) |

<a id="shape"></a>

### Different shapes of phenotype data

Phenotype data comes in many different shapes and forms. In the following, we will describe some of the most common features of such data:

- [Standardised/non-standardized](#standardized)
- [Quantitative/qualitative](#qual)
- [Pre-coordinated](#precoordinated)
- [Post-coordinated](#postcoordinated)

<a id="standardized"></a>

#### Standardised/non-standardized

Phenotype data can be standardised to varying degrees. It is not uncommon for data to be completely unstandardised.
Unfortunately, only a fraction of the available data is actually annotated using terms from controlled phenotype ontologies.
Here are some of the more "typical" kinds of data on the standardised/non-standardised spectrum:

1. Free text in clinical notes and scientific publications
1. Free text in specific database fields (for example a "height" column in a table about measurements of Giraffes)
1. Controlled but non-standardised vocabulary like enums in a datamodel (for example the keyword "abnormal" in the [ZFIN example above](#charmodbear))
1. Controlled standardised vocabulary (e.g. SNOMED CT)
1. Controlled vocabulary terms with well defined semantics (e.g. ontology terms from HP or MP)

<!-- TODO JMCL: I would suggest we add examples to the list above -->

<a id="qual"></a>

#### Quantitative/qualitative

Qualitative and quantitative phenotype data represent two fundamental ways of describing characteristics or traits in biology, each providing different types of information:

**Qualitative Phenotype Data** describes qualities or characteristics that are observed but not measured with numbers. It often involves categorical or descriptive information.
- Examples: The presence or absence of a specific physical trait (like eye color or wing shape in animals) or types of behavior (aggressive vs. passive).
- Analysis: Qualitative data is analyzed by categorization and identification of patterns or variations. It is more about the 'type' or 'kind' of trait rather than its 'amount'.
- Interpretation: Since it's descriptive, this data relies on subjective interpretation and classification.

**Quantitative Phenotype Data** is numerical and quantifies traits. It involves measurements of characteristics, often allowing for more precise and objective analysis.

- Examples: Height, weight, blood pressure, cholesterol levels, or the number of fruit produced by a plant. Quantitative traits can often be measured on a continuous scale, for example height of 35 cm, weight of 67 KG or blood pressure of 120/80.
- Analysis: It involves statistical analysis, such as calculating mean, median, standard deviation, and applying various statistical tests. It allows for a more objective and replicable assessment.
- Interpretation: Quantitative data provides a more concrete and measurable understanding of traits, making comparisons and statistical testing more straightforward.

Qualitative data is descriptive and categorical, while quantitative data is numerical and measurable. Both types are essential for a comprehensive understanding of phenotypic traits, each offering unique insights into biological variation and complexity.


<a id="precoordinated"></a>

#### Pre-coordinated

Structured pre-coordinated phenotype data is data where the various [aspects of the phenotype term](../reference/core-concepts.md), such as the _bearer_ ("retinal blood vessels") and the _characteristic_ ("Attenuation", or "thinning/narrowing"), and the _modifier_ (in the case of HPO terms, simply _abnormal_), are combined ("coordinated") into a single term, e.g. [`HP:0007843`](https://www.ebi.ac.uk/ols4/ontologies/hp/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FHP_0007843) "Attenuation of retinal blood vessels".

Pre-coordinated phenotype data is popular in the clinical domain, where a lot of observations are taken by a clinician and recorded as "phenotypic abnormalities" with the goal of eventual diagnosis.

[Phenopackets](http://phenopackets.org/) such as the one below are an emerging standard to capture and sharing disease and phenotype information about patients.
Phenotypic features are captured in phenopackets as pre-coordinated HPO terms.

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

Apart from clinical diagnostics, pre-coordinated phenotype terms are used in many other contexts such as model organism research (e.g. [IMPC](https://www.mousephenotype.org/)) or the curation of [Genome Wide Association Studies](https://www.ebi.ac.uk/gwas/).

<a id="postcoordinated"></a>

#### Post-coordinated

Post-coordinated phenotype curation simply means that the different constituents of phenotype (characteristic, bearer, modifier etc) are captured individually.
This has certain advantages.
For example, the phenotype space is _enormous_, as you can measure variations in many observable charactertics from chemical entities present in the blood, the microbiome to a host of morphological and developmental abnormalities. Instead of having individual (controlled vocabulary) terms for `increased level of X`, `decreased level X`, `abnormal level of X`, `increased level of X in blood` for thousands of chemical compounds synthesized by the human body, you just have "increased level", "blood" and all the chemical compounds, and capture them separately.

There are at least three flavours (probably more) of post-coordinated phenotype curation prevalent in the biomedical domain (four if you count quantified phenotypes):

- [Trait + modifier](#traitmodifier)
- [Bearer only](#beareronly)
- [Characteristics + modifier + bearer](#charmodbear)

<a id="traitmodifier"></a>

_Trait + modifier_ pattern is used for example by databases such as the [Saccharomyces Genome Database (SGD)](https://www.yeastgenome.org/observable/APO:0000106). Here are some examples:

| dateAssigned | evidence/publicationId | objectId | phenotypeStatement | phenotypeTermIdentifiers/0/termId | phenotypeTermIdentifiers/1/termId | conditionRelations/0/conditions/0/chemicalOntologyId | conditionRelations/0/conditions/0/conditionClassId |
|---|---|---|---|---|---|---|---|
| 2010-07-08T00:07:00-00:00 | PMID:1406694 | SGD:S000003901 | abnormal RNA accumulation | APO:0000002 | APO:0000224 | | |
| 2006-05-05T00:05:00-00:00 | PMID:785224 | SGD:S000000854 | decreased resistance to chemicals | APO:0000003 | APO:0000087 | CHEBI:78661 | ZECO:0000111 |
| 2010-07-07T00:07:00-00:00 | PMID:10545447 | SGD:S000000969 | decreased cell size | APO:0000003 | APO:0000052 | | |

- [`APO:0000002`](https://www.ebi.ac.uk/ols4/ontologies/apo/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FAPO_0000002) (abnormal) and [`APO:0000003`](https://www.ebi.ac.uk/ols4/ontologies/apo/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FAPO_0000003) (decreased) are modifiers.
- [`APO:0000087`](https://www.ebi.ac.uk/ols4/ontologies/apo/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FAPO_0000087) (resistance to chemicals), [`APO:0000224`](https://www.ebi.ac.uk/ols4/ontologies/apo/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FAPO_0000224) (RNA accumulation), [`APO:0000052`](https://www.ebi.ac.uk/ols4/ontologies/apo/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FAPO_0000052) (cell size) are biological attributes/traits.
- [`CHEBI:78661`](https://www.ebi.ac.uk/ols4/ontologies/chebi/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FCHEBI_78661) (borrelidin) is recorded as an experimental condition, but should probably be interpreted as part of the bearer expression.
- Note: SGD has different kinds of phenotype data, and it should be carefully evaluated which one it is.

!!! info

    Data was obtained [from the Alliance of Genome Resources](https://fms.alliancegenome.org/download/PHENOTYPE_SGD.json.gz) on the 30.03.2023 and simplified for illustration.

<a id="beareronly"></a>

The _bearer-only_ pattern is used by many databases, such as [Flybase](https://flybase.org/reports/FBal0016988).
In the data, we only find references of bearers, such as anatomical entities or biological processes.
Instead of explicitly stating phenotypic modifiers (abnormal, morphology, changed), it is implicit in the definition of the dataset.

| dateAssigned | evidence/crossReference/id | evidence/publicationId | objectId | phenotypeStatement | phenotypeTermIdentifiers/0/termId |
|---|---|---|---|---|---|
| 2024-01-05T11:54:24-05:00 | FB:FBrf0052655 | PMID:2385293 | FB:FBal0016988 | embryonic telson   | FBbt:00000184 |
| 2024-01-05T11:54:24-05:00 | FB:FBrf0058077 | PMID:8223248 | FB:FBal0001571 | larva              | FBbt:00001727 |

- [`FBbt:00000184`](https://www.ebi.ac.uk/ols4/ontologies/fbbt/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FFBbt_00000184) (embryonic telson) and [`FBbt:00001727`](https://www.ebi.ac.uk/ols4/ontologies/fbbt/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FFBbt_00001727) (larva) are bearer terms.
- The modifier is implicit in the data rather than explicitly stated. For example, [Flybase states on their website about the Dmel\torrv66 Allele (FBal0016988)](https://flybase.org/reports/FBal0016988) that the "phenotype manifests in the embryonic telson".
- Note: FlyBase has different kinds of phenotype data (including pre-coordinated), and it should be carefully evaluated which one is which prior to integration.

!!! info

    Data was obtained [from the Alliance of Genome Resources](https://fms.alliancegenome.org/download/PHENOTYPE_FB.json.gz) on the 30.03.2023 and simplified for illustration.

<a id="charmodbear"></a>

The most complex pattern for phenotype descriptions which essentially decomposes the entire phenotype expression into atomic consituents can be found, for example, in the [The Zebrafish Information Network (ZFIN)](https://zfin.org/).

Examples:

| Fish ID | Affected Structure or Process 1 subterm ID | Affected Structure or Process 1 subterm Name | Post-composed Relationship ID | Post-composed Relationship Name | Affected Structure or Process 1 superterm ID | Affected Structure or Process 1 superterm Name | Phenotype Keyword ID | Phenotype Keyword Name | Phenotype Tag | Affected Structure or Process 2 subterm ID | Affected Structure or Process 2 subterm name | Post-composed Relationship (rel) ID | Post-composed Relationship (rel) Name | Affected Structure or Process 2 superterm ID | Affected Structure or Process 2 superterm name | Publication ID |
|-----------------------|--------------------------------------------|----------------------------------------------|-------------------------------|---------------------------------|----------------------------------------------|--------------------------------------------------|----------------------|-------------------------------------|---------------|--------------------------------------------|----------------------------------------------|-------------------------------------|---------------------------------------|----------------------------------------------|--------------------------------------------------|-------------------|
| ZDB-FISH-150901-29105 | ZFA:0009366 | hair cell | BFO:0000050 | part_of | ZFA:0000051 | otic vesicle | PATO:0000374 | increased distance | abnormal | ZFA:0009366 | hair cell | BFO:0000050 | part_of | ZFA:0000051 | otic vesicle | ZDB-PUB-171025-12 |
| ZDB-FISH-150901-29105 | ZFA:0009366 | hair cell | BFO:0000050 | part_of | ZFA:0000051 | otic vesicle | PATO:0000374 | increased distance | abnormal | ZFA:0009366 | hair cell | BFO:0000050 | part_of | ZFA:0000051 | otic vesicle | ZDB-PUB-171025-12 |
| ZDB-FISH-150901-11537 | | | | | ZFA:0000051 | otic vesicle | PATO:0001905 | has normal numbers of parts of type | normal | ZFA:0009366 | hair cell | BFO:0000050 | part_of | ZFA:0000051 | otic vesicle | ZDB-PUB-150318-1 |
| ZDB-FISH-150901-18770 | | | | | ZFA:0000119 | retinal inner nuclear layer | PATO:0002001 | has fewer parts of type | abnormal | ZFA:0009315 | horizontal cell | BFO:0000050 | part_of | ZFA:0000119 | retinal inner nuclear layer | ZDB-PUB-130222-28 |
| ZDB-FISH-190806-7 | BSPO:0000084 | ventral region | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | PATO:0002001 | has fewer parts of type | abnormal | ZFA:0009301 | dopaminergic neuron | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | ZDB-PUB-190216-5 |
| ZDB-FISH-190807-7 | BSPO:0000084 | ventral region | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | PATO:0001905 | has normal numbers of parts of type | normal | ZFA:0009301 | dopaminergic neuron | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | ZDB-PUB-190216-5 |
| ZDB-FISH-190807-8 | BSPO:0000084 | ventral region | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | PATO:0002001 | has fewer parts of type | abnormal | ZFA:0009301 | dopaminergic neuron | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | ZDB-PUB-190216-5 |
| ZDB-FISH-150901-29105 | | | | | ZFA:0000101 | diencephalon | PATO:0001555 | has number of | normal | ZFA:0009301 | dopaminergic neuron | BFO:0000050 | part_of | ZFA:0000101 | diencephalon | ZDB-PUB-161120-7 |
| ZDB-FISH-210421-9 | ZFA:0009290 | glutamatergic neuron | BFO:0000050 | part_of | ZFA:0000008 | brain | PATO:0040043 | increased proportionality to | abnormal | ZFA:0009276 | GABAergic neuron | BFO:0000050 | part_of | ZFA:0000008 | brain | ZDB-PUB-191011-2 |
| ZDB-FISH-210421-9 | ZFA:0009290 | glutamatergic neuron | BFO:0000050 | part_of | ZFA:0000008 | brain | PATO:0040043 | increased proportionality to | abnormal | ZFA:0009276 | GABAergic neuron | BFO:0000050 | part_of | ZFA:0000008 | brain | ZDB-PUB-191011-2 |

Lets break down the second to last row:

- [`ZFA:0009290`](https://www.ebi.ac.uk/ols4/ontologies/zfa/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FZFA_0009290) (glutamatergic neuron): The primary entity whose characteristic is being observed
- [`BFO:0000050`](https://www.ebi.ac.uk/ols4/search?q=BFO%3A0000050) (part of): a relation used to connect the primary entity to the structure it is part of
- [`ZFA:0000008`](https://www.ebi.ac.uk/ols4/ontologies/zfa/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FZFA_0000008) (brain): the location of the primary entity being observed
- [`PATO:0040043`](https://www.ebi.ac.uk/ols4/ontologies/pato/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FPATO_0040043) (increased proportionality to): the modified characteristic being observed
- abnormal: the change modifier (note: not an ontology term)
- [`ZFA:0009276`](https://www.ebi.ac.uk/ols4/ontologies/zfa/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FZFA_0009276) (GABAergic neuron): the secondary entity being observed in relation to which the characteristic is measured
- [`ZFA:0000008`](https://www.ebi.ac.uk/ols4/ontologies/zfa/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FZFA_0000008) (brain): the location of the secondary entity

!!! example "Example: brain increased proportionality to glutamatergic neuron GABAergic neuron brain, abnormal"

    The interested reader may look at an integrated version of that huge post-coordinated expression [here (brain increased proportionality to glutamatergic neuron GABAergic neuron brain, abnormal - ZP:0141834)](https://www.ebi.ac.uk/ols4/ontologies/zp/classes/http%253A%252F%252Fpurl.obolibrary.org%252Fobo%252FZP_0141834).

!!! info

    Data was obtained [from ZFIN](https://zfin.org/downloads) (Phenotype of Zebrafish Genes) on the 30.03.2023 and simplified for illustration.

As one can see in the last example, bearers can be anything from simple atomic entities to arbitrarily complex compositions:

- "lysine" (`lysine`)
- "lysine in the blood" (`lysine` part_of `blood`)
- "lysine in heart muscle cells" (`lysine` part_of `cell` part_of (`muscle` part of `heart`))
- "lysine in the cytoplasm of heart muscle cells" (`lysine` part_of (`cytoplasm` part_of (`cell` part_of (`muscle` part of `heart`))))
- etc, etc
