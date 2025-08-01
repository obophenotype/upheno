#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 8 14:24:37 2018

@author: Nicolas Matentzoglu
"""

import os
import sys

import yaml

from lib import (
    cdir,
    export_merged_tsvs_for_combination,
    robot_merge,
    create_upheno_core_manual_phenotypes,
    robot_prepare_ontology_for_dosdp,
    uPhenoConfig,
    compute_upheno_fillers,
)

# Configuration
yaml.warnings({"YAMLLoadWarning": False})
upheno_config_file = sys.argv[1]
upheno_config = uPhenoConfig(config_file=upheno_config_file)
os.environ["ROBOT_JAVA_ARGS"] = upheno_config.get_robot_java_args()

timeout = upheno_config.get_external_timeout()
ws = upheno_config.get_working_directory()
robot_opts = upheno_config.get_robot_opts()

overwrite_dosdp_upheno = upheno_config.is_overwrite_upheno_intermediate()

# Data directories
original_pattern_dir = os.path.join(ws, "curation/patterns-for-matching/")
upheno_fillers_dir = os.path.join(ws, "curation/upheno-fillers/")
upheno_preprocessed_patterns_dir = os.path.join(ws, "curation/changed-patterns/")
sspo_matches_dir = os.path.join(ws, "curation/pattern-matches/")
raw_ontologies_dir = os.path.join(ws, "curation/tmp/")
upheno_prepare_dir = os.path.join(ws, "curation/upheno-release-prepare/")

cdir(upheno_fillers_dir)
cdir(original_pattern_dir)
cdir(upheno_preprocessed_patterns_dir)
cdir(sspo_matches_dir)
cdir(raw_ontologies_dir)
cdir(upheno_prepare_dir)

# Files
allimports_dosdp = os.path.join(raw_ontologies_dir, "upheno-allimports-dosdp.owl")

### This step is now done indedently my "make prepare_changed_patterns"
#print("### Rewrite abnormal patterns to 'phenotype' patters")
#upheno_patterns_main_dir = os.path.join(ws, "patterns/dosdp-patterns/")
#generate_rewritten_patterns(patterns_directory=upheno_patterns_main_dir,
#                            pattern_dir=original_pattern_dir,
#                            upheno_patterns_dir=upheno_preprocessed_patterns_dir)

print("### Preparing a dictionary for DOSDP extraction from the all imports merged ontology.")
sparql_terms = os.path.join(ws, "sparql/terms.sparql")

# Used to loop up labels in the pattern generation process, so maybe I don't need anything other than rdfs:label?
allimports_merged = os.path.join(raw_ontologies_dir, "upheno-allimports-merged.owl")
if upheno_config.is_overwrite_ontologies() or not os.path.exists(allimports_dosdp):
    robot_prepare_ontology_for_dosdp(
        o=allimports_merged,
        ontology_merged_path=allimports_dosdp,
        sparql_terms_class_hierarchy=sparql_terms,
        timeout=timeout,
        robot_opts=robot_opts
    )

print("### Compute the uPheno filler classes.")
java_fill = os.path.join(ws, "scripts/upheno-filler-pipeline.jar")
ontology_for_matching_dir = os.path.join(ws, "curation/ontologies-for-matching/")
cdir(ontology_for_matching_dir)
compute_upheno_fillers(upheno_config=upheno_config,
                       raw_ontologies_dir=raw_ontologies_dir,
                       upheno_fillers_dir=upheno_fillers_dir,
                       java_fill=java_fill,
                       ontology_for_matching_dir=ontology_for_matching_dir,
                       sspo_matches_dir=sspo_matches_dir,
                       original_pattern_dir=original_pattern_dir)

print("### Generating uPheno core.")
upheno_patterns_data_manual_dir = os.path.join(ws, "patterns/data/default/")

# Extra axioms, upheno relations, the manually curated intermediate phenotypes part of the upheno repo
upheno_core_manual_phenotypes = create_upheno_core_manual_phenotypes(
    manual_tsv_files=[],
    allimports_dosdp=allimports_dosdp,
    timeout=timeout,
    overwrite_dosdp_upheno=overwrite_dosdp_upheno,
    upheno_patterns_dir=upheno_preprocessed_patterns_dir,
    upheno_prepare_dir=upheno_prepare_dir,
    upheno_patterns_data_manual_dir=upheno_patterns_data_manual_dir,
)

upheno_ontology_dir = os.path.join(ws, "ontology/")
upheno_components_dir = os.path.join(upheno_ontology_dir, "components/")
upheno_relations_ontology = os.path.join(upheno_components_dir, "upheno-relations.owl")
upheno_extra_axioms_ontology = os.path.join(upheno_components_dir, "upheno-extra.owl")
upheno_core_parts = [upheno_extra_axioms_ontology, upheno_relations_ontology]
upheno_core_parts.extend(upheno_core_manual_phenotypes)

upheno_core_ontology = os.path.join(upheno_prepare_dir, "upheno-core.owl")
if overwrite_dosdp_upheno or not os.path.exists(upheno_core_ontology):
    robot_merge(ontology_list=upheno_core_parts,
                ontology_merged_path=upheno_core_ontology,
                timeout=timeout,
                robot_opts=robot_opts)

print("### Generating uPheno base..")
oids = upheno_config.get_upheno_profile_components("all")
profile_dir = os.path.join(ws, "patterns/data/automatic")
cdir(profile_dir)
export_merged_tsvs_for_combination(merged_tsv_dir=profile_dir,
                                   oids=oids,
                                   pattern_dir=original_pattern_dir,
                                   upheno_fillers_dir=upheno_fillers_dir,
                                   legal_fillers=upheno_config.get_legal_fillers(),
                                   upheno_id_map=upheno_config.get_upheno_id_map())
