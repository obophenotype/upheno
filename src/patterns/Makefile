SCHEMA := util/DOSDP_schema_full.yaml

test: $(SCHEMA)
	python3 util/test_schema.py *.yaml

clean:
	rm $(SCHEMA)

$(SCHEMA):
	wget --no-check-certificate https://raw.githubusercontent.com/dosumis/dead_simple_owl_design_patterns/master/spec/DOSDP_schema_full.yaml -O $@ && touch $@
