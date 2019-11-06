PATTERNDIR=                 ../patterns
OBO=http://purl.obolibrary.org/obo
ONT=upheno
BASE=$(OBO)/$(ONT)
SRC=$(ONT)-edit.owl
RELEASEDIR=../..
ROBOT= robot
OWLTOOLS= owltools
USECAT= --use-catalog
SPARQLDIR = ../sparql
DOSDP_SCHEMA=http:// # change to PURL when ready.
PATTERN_TESTER=simple_pattern_tester.py
DOSDPT=dosdp-tools
URIBASE=$(OBO)/$(ONT)
TODAY ?= $(shell date +%Y-%m-%d)

query: $(pattern-files)

.PHONY: .FORCE
.PHONY: query $(pattern-files)

HP = mirror/hp.owl

MP = mirror/mp.owl

PATO = mirror/pato.owl

$(HP): 
	curl -L -O http://purl.obolibrary.org/obo/hp.owl

$(MP): 
	curl -L -O http://purl.obolibrary.org/obo/mp.owl
	

	
$(pattern-files): $(HP) $(MP)
	dosdp-scala query --ontology=$(MP) --reasoner=elk --obo-prefixes=true --template=$@ --outfile=$(basename $@).mp.tsv; dosdp-scala query --ontology=$(HP) --reasoner=elk --obo-prefixes=true --template=$@ --outfile=$(basename $@).hp.tsv

pattern_schema_checks_dev:
	simple_pattern_tester.py $(PATTERNDIR)/dosdp-dev/

pattern_schema_checks_main:
	simple_pattern_tester.py $(PATTERNDIR)/dosdp-patterns/
	
pattern_schema_checks: pattern_schema_checks_main pattern_schema_checks_dev
	
../patterns/pattern-dev.owl: pattern_schema_checks
	$(DOSDPT) prototype --obo-prefixes --template=../patterns/dosdp-dev --outfile=$@

../patterns/pattern-main.owl: pattern_schema_checks
	$(DOSDPT) prototype --obo-prefixes --template=../patterns/dosdp-patterns --outfile=$@
	
../patterns/pattern-merged.owl: ../patterns/pattern-dev.owl ../patterns/pattern-main.owl
	$(ROBOT) merge -i ../patterns/pattern-dev.owl -i ../patterns/pattern-main.owl annotate -V $(BASE)/releases/`date +%Y-%m-%d`/$(ONT)-pattern.owl annotate --ontology-iri $(BASE)/$(ONT)-pattern.owl -o $@

../patterns/imports/seed.txt: ../patterns/pattern-merged.owl
	$(ROBOT) query -f csv -i $< --query ../sparql/terms.sparql $@
	
../patterns/imports/seed_sorted.txt: ../patterns/imports/seed.txt
	cat ../patterns/imports/seed.txt | sort | uniq > $@


	
PATTERN_IMPORTS = pato ro uberon go cl caro uberon-bridge-to-caro
PATTERN_IMPORTS_OWL = ../patterns/pattern-merged.owl $(patsubst %, ../patterns/imports/%_import.owl, $(PATTERN_IMPORTS))
../patterns/imports/%_import.owl: mirror/%.owl ../patterns/imports/seed_sorted.txt
	$(ROBOT) extract -i $< -T ../patterns/imports/seed_sorted.txt --method BOT -O mirror/$*.owl annotate --ontology-iri $(OBO)/$(ONT)/patterns/imports/$*_import.owl -o $@

mirror/%.owl:
	$(ROBOT) convert -I $(OBO)/$*.owl -o $@
.PRECIOUS: mirror/%.owl
	
mirror/uberon-bridge-to-caro.owl:
	$(ROBOT) convert -I http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-caro.owl -o $@
.PRECIOUS: mirror/uberon-bridge-to-caro.owl

../patterns/pattern.owl: #$(PATTERN_IMPORTS_OWL)
	$(ROBOT) merge $(addprefix -i , $(PATTERN_IMPORTS_OWL)) reason -r Hermit reduce -r Hermit annotate --ontology-iri $(OBO)/$(ONT)/patterns/pattern.owl -o $@

pattern_ontology: #../patterns/pattern.owl
	$(ROBOT) merge -i ../patterns/pattern.owl \
	filter --select "<http://purl.obolibrary.org/obo/upheno/patterns*>" --select "self annotations" --signature true --trim true -o ../patterns/pattern-simple.owl
	
../patterns/dosdp-dev/README.md: .FORCE
	python ../scripts/patterns_create_overview.py ../patterns/dosdp-dev $@
	
../patterns/dosdp-patterns/README.md: .FORCE
	python ../scripts/patterns_create_overview.py ../patterns/dosdp-patterns $@

pattern_readmes: ../patterns/dosdp-dev/README.md ../patterns/dosdp-patterns/README.md
	
upheno.obo: upheno.owl
	$(ROBOT) convert --input $< --check false -f obo $(OBO_FORMAT_OPTIONS) -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo > $@ && rm $@.tmp.obo

upheno.owl: ../../metazoa.owl
	$(ROBOT) merge -i $< annotate --ontology-iri $(URIBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY) -o $@

upheno.json: upheno.owl
	$(ROBOT) annotate --input $< --ontology-iri $(URIBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY) \
		convert --check false -f json -o $@.tmp.json && mv $@.tmp.json $@

release: upheno.json upheno.owl upheno.obo
	cp $^ ../../release
	