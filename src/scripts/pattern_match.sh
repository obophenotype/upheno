#!/bin/bash
set -e

patterndir=$1
matchesdir=$2

ONTDIR=../scripts/pattern-matches/ontologies/
TEMPLATEDIR=../scripts/pattern-matches/$patterndir/
TSVDIR=../scripts/pattern-matches/$matchesdir/

#ONTS="mp hp xpo wbphenotype"
ONTS="mp hp xpo wbphenotype zfa"
#: "${DOWNLOAD:=false}"

DOWNLOAD=true

PATTERNS=""

mkdir -p $ONTDIR $TSVDIR

for f in ${TEMPLATEDIR}*.yaml
do
	PATTERNS="${PATTERNS} $(basename "$f" .yaml)"
done
PATTERNS="$(echo "${PATTERNS}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

echo "|$PATTERNS|"

if $DOWNLOAD; then
	for o in $ONTS
	do
		wget http://purl.obolibrary.org/obo/${o}.owl -O ${ONTDIR}${o}.owl
	done
fi

######################
# fold in bridge files
## so that patterns use
## e.g. UBERON classes
## instead of their own
## anatomy terms
######################
# fold in XPO bridge files
sh run.sh robot merge -i ../scripts/pattern-matches/ontologies/xpo.owl -I https://raw.githubusercontent.com/obophenotype/uberon/master/src/ontology/bridge/cl-bridge-to-xao.owl -I https://raw.githubusercontent.com/obophenotype/uberon/master/src/ontology/bridge/uberon-bridge-to-xao.owl -o ../scripts/pattern-matches/ontologies/xpo.owl # test it in isolation
# fold in ZFA bridge files
sh run.sh robot merge -i ../scripts/pattern-matches/ontologies/zfa.owl -I https://raw.githubusercontent.com/obophenotype/uberon/master/src/ontology/bridge/cl-bridge-to-zfa.owl -I https://raw.githubusercontent.com/obophenotype/uberon/master/src/ontology/bridge/uberon-bridge-to-zfa.owl -o ../scripts/pattern-matches/ontologies/zfa.owl # test it in isolation

echo "\ndownloading: $TEMPLATEDIR, $PATTERNS"

for o in ${ONTDIR}*.owl
do
	ONT=${o}
	TSVONT="${TSVDIR}/$(basename "$o" .owl)"
    mkdir -p $TSVONT
	sh run.sh dosdp-tools query --ontology=$ONT --reasoner=elk --obo-prefixes=true --template=$TEMPLATEDIR --batch-patterns="${PATTERNS}" --outfile=$TSVONT
done
