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

$(pattern-files): $(HP) $(MP)
	dosdp-scala --ontology=$(MP) --reasoner=elk --template=$@ >$(basename $@).mp.tsv; $dosdp --ontology=$(HP) --reasoner=elk --template=$@ >$(basename $@).hp.tsv

HP = hp.owl

MP = mp.owl

$(HP): 
	curl -L -O http://purl.obolibrary.org/obo/hp.owl
	
$(MP): 
	curl -L -O http://purl.obolibrary.org/obo/mp.owl
