#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 8 14:24:37 2018

@author: Nicolas Matentzoglu
"""
import os
import shutil
import sys

from lib import (
    cdir,
    prepare_species_specific_phenotype_ontologies,
    match_patterns,
    prepare_all_imports_merged,
    prepare_upheno_ontology_no_taxon_restictions,
    prepare_phenotype_ontologies_for_matching,
    download_sources,
    uPhenoConfig,
)

# Configuration
# warnings.simplefilter("ignore", ruamel.yaml.error.UnsafeLoaderWarning)

upheno_config_file = sys.argv[1]
# upheno_config_file = os.path.join("/ws/upheno-dev/src/curation/upheno-config.yaml")
upheno_config = uPhenoConfig(upheno_config_file)
os.environ["ROBOT_JAVA_ARGS"] = upheno_config.get_robot_java_args()
os.environ["JAVA_OPTS"] = upheno_config.get_java_opts()

timeout = str(upheno_config.get_external_timeout())
ws = upheno_config.get_working_directory()
robot_opts = upheno_config.get_robot_opts()

pattern_dir = os.path.join(ws, "curation/patterns-for-matching/")
ontology_for_matching_dir = os.path.join(ws, "curation/ontologies-for-matching/")
matches_dir = os.path.join(ws, "curation/pattern-matches/")
stats_dir = os.path.join(ws, "curation/upheno-stats/")
module_dir = os.path.join(ws, "curation/tmp/")

cdir(pattern_dir)
cdir(matches_dir)
cdir(module_dir)
cdir(ontology_for_matching_dir)
cdir(stats_dir)

sparql_dir = os.path.join(ws, "sparql/")
xref_pattern = os.path.join(ws, "patterns/dosdp-patterns/xrefToSubClass.yaml")
sparql_terms = os.path.join(sparql_dir, "terms.sparql")

java_taxon = os.path.join(ws, "scripts/upheno-taxon-restriction.jar")

if upheno_config.is_clean_dir():
    print("Cleanup..")
    shutil.rmtree(matches_dir)
    os.makedirs(matches_dir)
    shutil.rmtree(ontology_for_matching_dir)
    os.makedirs(ontology_for_matching_dir)
    shutil.rmtree(module_dir)
    os.makedirs(module_dir)
    shutil.rmtree(stats_dir)
    os.makedirs(stats_dir)
    #shutil.rmtree(pattern_dir)
    #os.makedirs(pattern_dir)

print("### Download sources ###")
print("ROBOT args: " + os.environ["ROBOT_JAVA_ARGS"])
download_sources(module_dir=module_dir,
                 upheno_config=upheno_config,
                 xref_pattern=xref_pattern,
                 robot_opts=robot_opts,
                 timeout=timeout,
                 sparql_dir=sparql_dir,
                 overwrite=True
                 )

print("### Preparing phenotype ontologies for matching ###")
prepare_phenotype_ontologies_for_matching(
    module_dir=module_dir,
    ontology_for_matching_dir=ontology_for_matching_dir,
    robot_opts=robot_opts,
    sparql_dir=sparql_dir,
    sparql_terms=sparql_terms,
    stats_dir=stats_dir,
    timeout=timeout,
    upheno_config=upheno_config,
    overwrite=upheno_config.is_overwrite_ontologies())

print("### Matching phenotype ontologies against uPheno patterns ###")
match_patterns(
    upheno_config=upheno_config,
    matches_dir=matches_dir,
    pattern_dir=pattern_dir,
    ontology_for_matching_dir=ontology_for_matching_dir,
    timeout=timeout,
    overwrite=upheno_config.is_overwrite_matches()
)

print("### Prepare phenotype ontology components for integration in uPheno ###")
prepare_species_specific_phenotype_ontologies(upheno_config=upheno_config,
                                              module_dir=module_dir,
                                              matches_dir=matches_dir,
                                              timeout=timeout,
                                              java_taxon=java_taxon,
                                              robot_opts=robot_opts)

print("### Prepare master import file with all imports merged ###")
prepare_all_imports_merged(config=upheno_config,
                           module_dir=module_dir,
                           timeout=timeout,
                           robot_opts=robot_opts)

print("### Prepare master uPheno with no taxon restrictions for relation computation ###")
prepare_upheno_ontology_no_taxon_restictions(config=upheno_config,
                                             ontology_for_matching_dir=ontology_for_matching_dir,
                                             module_dir=module_dir,
                                             upheno_config=upheno_config,
                                             timeout=timeout,
                                             robot_opts=robot_opts)
