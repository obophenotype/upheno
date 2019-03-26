PATTERNDIR=                 ../patterns

query: $(pattern-files)

.PHONY: query $(pattern-files)

HP = hp.owl

MP = mp.owl

$(HP): 
	curl -L -O http://purl.obolibrary.org/obo/hp.owl

$(MP): 
	curl -L -O http://purl.obolibrary.org/obo/mp.owl

$(pattern-files): $(HP) $(MP)
	dosdp-scala query --ontology=$(MP) --reasoner=elk --obo-prefixes=true --template=$@ --outfile=$(basename $@).mp.tsv; dosdp-scala query --ontology=$(HP) --reasoner=elk --obo-prefixes=true --template=$@ --outfile=$(basename $@).hp.tsv


pattern_schema_checks:
	simple_pattern_tester.py $(PATTERNDIR)/dosdp-patterns/ && simple_pattern_tester.py $(PATTERNDIR)/dosdp-dev/