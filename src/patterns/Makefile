SCHEMA := util/DOSDP_schema_full.yaml

test: $(SCHEMA)
	python3 util/test_schema.py *.yaml

clean:
	rm $(SCHEMA)

$(SCHEMA):
	wget --no-check-certificate https://raw.githubusercontent.com/dosumis/dead_simple_owl_design_patterns/master/spec/DOSDP_schema_full.yaml -O $@ && touch $@

pattern-files = $(shell ls *.yaml)

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
