#!/bin/sh

set -e

# Author: Nicolas Matentzoglu, European Bioinformatics Institute (EMBL-EBI)
# Monarch Initiative, https://monarchinitiative.org

############################################################
############### uPheno 2.0 pipeline ########################
############################################################

####### Step 1: download sources and match patterns ########

# In this first part of the pipeline, the following steps are executed 
# (comprehensive configuration of the pipeline can be found in ../curation/upheno-config.yaml)

# 1. Download all patterns from a set of specified repositories (see config file 'pattern_repos'.)
#    Optionally, pattern fillers can be replaced by owl:Thing, so that logical definitions with unaligned fillers but 
#    otherwise matching patterns are considered positive matches
# 2. Download all source ontologies (see config file: 'sources')
#    Ontologies are merged and converted two OWL using ROBOT.
#    For bridge ontologies, a special mode 'xref', allows to try and exploit xrefs directly to construct 
#    a subclass-of alignment; these should be replaced by proper alignments over time.
# 3. Prepare phenotype ontologies for matching.
#    Phenotype ontologies with all their imports (a special imports module) are merged. Taxon restrictions
#    are introduced and labels rewritten.
# 4. Match patterns: All patterns as downloaded in step 1.1 are matched agains all phenotype ontologies.
#    This results in one tsv file with matches per phenotype ontology and pattern.
# TODO: Remember that it is possible to manually add patterns to the pattern directory;

#sh run.sh python3 upheno_prepare.py ../curation/upheno-config.yaml

####### Step 2: Generate uPheno 2 Core ########
# The second step is to generate all manually curated intermediate uPheno classes that are common to all profiles.
# These are generated using the normal ODK pipelines (patterns).
# DEPRECATED STEP! NOW PART OF THE PROFILE GENERATION!

####### Step 3: uPheno intermediate layer and species-profiles ########

# The third major step of the uPheno pipeline is all about preparing the species independent
# intermediate layer of uPheno 2. It is subdivided into the following tasks:

# 1. Extract uPheno fillers from pattern matches (step 1.4). The primary bearer is filled up, 
#    i.e. every class between the pattern filler and a particular species specific filler class is instantiated
#    (minus a blacklist)
# 2. For every profile (config 'upheno_combinations'), create a new directory, then compile all patterns 
#    from the previous step using dosdp. Add taxon restrictions 

sh run.sh python3 upheno_create_profiles.py ../curation/upheno-config.yaml

sh run.sh python3 upheno-stats.py ../curation/upheno-config.yaml


#RUN_SSSOM="python3 create_sssom.py --upheno_id_map ../curation/upheno_id_map.txt --patterns_dir ../curation/patterns-for-matching --matches_dir ../curation/pattern-matches --output ../../mappings/upheno-species-independent.sssom.tsv"
#docker run -v $PWD/../../:/work -w /work/src/scripts --rm -ti obolibrary/odkfull:v1.5 $RUN_SSSOM

cd ../ontology/
sh run.sh make o reports

echo "Release successfully completed, ready to deploy."
