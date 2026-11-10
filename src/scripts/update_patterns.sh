ws=/Users/matentzn/ws/
matches_dir=/Users/matentzn/ws/upheno-dev/src/curation/pattern-matches/
patterns_dir=/Users/matentzn/ws/upheno-dev/src/curation/patterns-for-matching
obo_prefix=http://purl.obolibrary.org/obo/

#python3 update_species_matches.py ${ws}human-phenotype-ontology/src/patterns/data/default ${matches_dir}hp ${patterns_dir} ${obo_prefix}
python3 update_species_matches.py ${ws}mammalian-phenotype-ontology/src/patterns/data/default ${matches_dir}mp ${patterns_dir} ${obo_prefix}
python3 update_species_matches.py ${ws}c-elegans-phenotype-ontology/src/patterns/data/default ${matches_dir}wbphenotype ${patterns_dir} ${obo_prefix}
