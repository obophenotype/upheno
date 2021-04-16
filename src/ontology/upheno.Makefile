## Customize Makefile settings for upheno
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile


OBO=http://purl.obolibrary.org/obo
OT_MEMO=160G
OWLTOOLS=OWLTOOLS_MEMORY=$(OT_MEMO) owltools --no-logging

query: $(pattern-files)

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
	$(DOSDPT) prototype --obo-prefixes true --template=../patterns/dosdp-dev --outfile=$@

../patterns/pattern-main.owl: pattern_schema_checks
	$(DOSDPT) prototype --obo-prefixes true --template=../patterns/dosdp-patterns --outfile=$@
	
../patterns/pattern-merged.owl: ../patterns/pattern-dev.owl ../patterns/pattern-main.owl
	$(ROBOT) merge -i ../patterns/pattern-dev.owl -i ../patterns/pattern-main.owl annotate -V $(ONTBASE)/releases/`date +%Y-%m-%d`/$(ONT)-pattern.owl annotate --ontology-iri $(ONTBASE)/$(ONT)-pattern.owl -o $@

../patterns/imports/seed.txt: ../patterns/pattern-merged.owl
	$(ROBOT) query -f csv -i $< --query ../sparql/terms.sparql $@
	
../patterns/imports/seed_sorted.txt: ../patterns/imports/seed.txt
	cat ../patterns/imports/seed.txt | sort | uniq > $@


	
PATTERN_IMPORTS = pato ro uberon go cl caro uberon-bridge-to-caro chebi mpath nbo
PATTERN_IMPORTS_OWL = $(patsubst %, ../patterns/imports/%_import.owl, $(PATTERN_IMPORTS))
../patterns/imports/%_import.owl: mirror/%.owl ../patterns/imports/seed_sorted.txt
	$(ROBOT) extract -i $< -T ../patterns/imports/seed_sorted.txt --method BOT -O mirror/$*.owl annotate --ontology-iri $(OBO)/$(ONT)/patterns/imports/$*_import.owl -o $@

mirror/%.owl:
	$(ROBOT) convert -I $(OBO)/$*.owl -o $@
.PRECIOUS: mirror/%.owl
	
	
mirror/cl.owl:
	$(ROBOT) convert -I $(OBO)/cl/cl-simple.owl -o $@
.PRECIOUS: mirror/cl.owl

mirror/nbo.owl:
	$(ROBOT) convert -I $(OBO)/nbo/nbo-base.owl -o $@
.PRECIOUS: mirror/nbo.owl
	
mirror/chebi.owl:
	$(ROBOT) convert -I $(OBO)/chebi.owl.gz -o $@
.PRECIOUS: mirror/chebi.owl

	
mirror/uberon-bridge-to-caro.owl:
	$(ROBOT) convert -I http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-caro.owl -o $@
.PRECIOUS: mirror/uberon-bridge-to-caro.owl

../patterns/pattern-with-imports.owl: ../patterns/pattern-merged.owl $(PATTERN_IMPORTS_OWL)
	$(ROBOT) merge $(addprefix -i , $^) unmerge -i components/pattern-ontology-remove-axioms.owl -o $@

../patterns/pattern.owl: ../patterns/pattern-with-imports.owl
	$(ROBOT) merge -i ../patterns/pattern-with-imports.owl remove --term http://www.w3.org/2002/07/owl#Nothing reason -r Hermit reduce -r Hermit annotate --ontology-iri $(OBO)/$(ONT)/patterns/pattern.owl -o $@

pattern_ontology: ../patterns/pattern.owl
	$(ROBOT) merge -i ../patterns/pattern.owl \
	filter --select "<http://purl.obolibrary.org/obo/upheno/patterns*>" --select "self annotations" --signature true --trim true -o ../patterns/pattern-simple.owl
	

../patterns/dosdp-patterns/README.md: .FORCE
	python ../scripts/patterns_create_overview.py "../patterns/dosdp-patterns|../patterns/dosdp-dev" $@

pattern_readmes: ../patterns/dosdp-patterns/README.md
	
upheno.obo: upheno.owl
	$(ROBOT) convert --input $< --check false -f obo $(OBO_FORMAT_OPTIONS) -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo > $@ && rm $@.tmp.obo

upheno.owl: ../../metazoa.owl
	$(ROBOT) merge -i $< annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY) -o $@

upheno.json: upheno.owl
	$(ROBOT) annotate --input $< --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY) \
		convert --check false -f json -o $@.tmp.json && mv $@.tmp.json $@

release: upheno.json upheno.owl upheno.obo
	cp $^ ../../release


##################################################
####### Similarity tables ########################
##################################################



hp_mp_phenodigm_2_5.tsv: mp_hp.owl
	$(OWLTOOLS) $< --sim-save-phenodigm-class-scores -m 2.5 -x HP,MP -a $@
	

####################################################

PATTERN_IN=https://docs.google.com/spreadsheets/d/e/2PACX-1vRb36ExWkOYjM9Mc-IpbEev5o9nlkOUf9xQbdaSB-oD5l4K6CkSLZv3-xLlaPJWCQKhlW0R4tXVifqv/pub?gid=510110305&single=true&output=tsv
PATTERN_TEMPLATE=../patterns/dosdp-dev/fracturedAnatomicalEntity.yaml

#PATTERN_IN=https://docs.google.com/spreadsheets/d/e/2PACX-1vSj7QlW6Skmw4g9cy4kNWFx4634TTchAHCbd7MKL_Hpf9Dba2l8fv16f7H_4lLfuOpV1davS-oZ_uzl/pub?gid=657591629&single=true&output=tsv
#PATTERN_TEMPLATE=../patterns/dosdp-dev/abnormalProportionOfCellTypeInLocation.yaml
	
generated_pattern.tsv:
	wget "$(PATTERN_IN)" -O $@

generated_pattern.owl: generated_pattern.tsv
	$(DOSDPT) generate --infile=$< --template=$(PATTERN_TEMPLATE) --ontology=../patterns/pattern.owl --obo-prefixes=true --outfile=$@

gp: generated_pattern.owl