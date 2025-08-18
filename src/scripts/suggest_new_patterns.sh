#!/usr/bin/env bash

set -e

DEFAULTVALUE="$HOME/upheno"
LOCAL_UPHENO_DIR="${1:-$DEFAULTVALUE}"

MATCHES_DIR="../scripts/pattern-matches"


mkdir -p $MATCHES_DIR

# Copy the up to date patterns from your upheno repository
echo "Copying patterns from local upheno repo"
mkdir -p $MATCHES_DIR/upheno_patterns
cp $LOCAL_UPHENO_DIR/src/patterns/dosdp-dev/*.yaml $MATCHES_DIR/upheno_patterns
cp $LOCAL_UPHENO_DIR/src/patterns/dosdp-patterns/*.yaml $MATCHES_DIR/upheno_patterns

echo "Matching generic patterns"
sh pattern_match.sh generic_patterns generic_matches

echo "Matching uPheno patterns"
sh pattern_match.sh upheno_patterns upheno_matches

echo "TODO: write python script that reads all the tables in the generic_matches and upheno_matches directories and outputs recommendations for new patterns."
#sh run.sh python3 suggest_new_patterns.py 

echo "Suggest new patterns successful."
