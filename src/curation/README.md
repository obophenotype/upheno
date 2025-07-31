# uPheno 2.0 Pipeline

The uPheno 2 pipeline does the following:

1. Matches all existing uPheno patterns against all species-specific phenotype ontologies
2. Computing intermediate classes for all matches and exports dosdp instance TSV files
3. Assigns uPheno IDs to all classes generated above. Previously generated UPHENO ids are preserved

The pipeline can be run like this:

```
cd src/scripts
sh upheno_pipeline.sh
``` 

Detailed documentation can be found in `upheno_pipeline.sh`.
There are a few java dependencies of the uPheno 2 pipeline which can be found [here](https://github.com/monarch-ebi-dev/phenotype.utils).


## Important design choices

1. All species-specific phenotype ontologies (SSPOs) get augmented with taxon constraints on EQs and get their taxon attached to every label. A taxon restriction is formulated as and equivalent class axiom with Uberon + a taxon restriction.
1. phenotypic orthology is determined by logical equivalence under absence of taxon constraints
1. To avoid cross-phenotype ontology logical axiom contamination, 
   1. no SSPO subsumes another. This is particularly relevant for MP and HP.
   2. Non-upheno conformant EQs are removed from upheno. This does not affect SSPO internal classification, which happens independently at an earlier step, and will not affect the "has_phenotype_affecting" relationship. 
1. For any given profile, only relevant UPHENO classes are added
1. For every profile, uPheno is offered in two flavours: the pure and the augmented. Pure contains:
   1. The uPheno layer of species independent phenotype classes
   1. The species-specific phenotype layer including all phenotype classes plus axiomatisation from SSPOs 
   1. The ontological dependencies (the sum of all axioms from all ontologies the species-phenotype layer depents on)
   1. In addition, 'augmented' contains some easy to traverse relationships:
      1. `has phenotype affecting` links a phenotype directly to its bearer. This is derived from the original EQ, not just uPheno conformant ones (assuming that curators took reasonable care in picking those.)
      1. `has phenotypic orthologue` links a phenotype directly to a phenotypic orthologue
1. The intermediate uPheno layer is constructed as follows:
   1. All uPheno patterns are matched against all SSPOs
   1. For each profile, uPheno intermediate classes are determined by merging all DOSDP tsv files into one, and injecting all classes between the pattern filler and all instances. UPHENO ids are being assigned in a stable manner.
   1. The resulting TSV files are transformed into OWL using DOSDP generate
   1. This means, in particular, that a uPheno term is created even if there is only a single species term nestled underneath it.
	 
	 
## How to add a new ontology

1. Add entry in upheno-config.yaml
1. Make sure all dependencies are listed
1. Add src/sparql/ont_terms.sparql

## Obsoletion of ZFIN terms
Some 
1. Move entries from df_obsoletion_candidates.txt to obsolete.tsv (scr/templates)
2. Remove all ZP rows from id_map_zfin.tsv