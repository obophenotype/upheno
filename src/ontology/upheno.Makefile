## Customize Makefile settings for upheno
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile


OBO=http://purl.obolibrary.org/obo
OT_MEMO=160G
OWLTOOLS=OWLTOOLS_MEMORY=$(OT_MEMO) owltools --no-logging

$(TMPDIR)/pattern_schema_checks_dev: $(ALL_PATTERN_FILES) | $(TMPDIR)
	$(PATTERN_TESTER) $(PATTERNDIR)/dosdp-dev/ && touch $@

$(TMPDIR)/pattern_schema_checks_main: $(ALL_PATTERN_FILES) | $(TMPDIR)
	$(PATTERN_TESTER) $(PATTERNDIR)/dosdp-patterns/ && touch $@

../patterns/pattern-dev.owl: $(TMPDIR)/pattern_schema_checks_dev
	$(DOSDPT) prototype --obo-prefixes true --template=../patterns/dosdp-dev --outfile=$@

../patterns/pattern-main.owl: $(TMPDIR)/pattern_schema_checks_main
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
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then $(ROBOT) extract -i $< -T ../patterns/imports/seed_sorted.txt --method BOT -O mirror/$*.owl annotate --ontology-iri $(OBO)/$(ONT)/patterns/imports/$*_import.owl -o $@; fi

mirror/uberon-bridge-to-caro.owl:
	if [ $(MIR) = true ] && [ $(IMP) = true ]; then $(ROBOT) convert -I http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-caro.owl -o $@.tmp.owl && mv $@.tmp.owl $@; fi
.PRECIOUS: mirror/uberon-bridge-to-caro.owl

../patterns/pattern-with-imports.owl: ../patterns/pattern-merged.owl $(PATTERN_IMPORTS_OWL)
	$(ROBOT) merge $(addprefix -i , $^) unmerge -i components/pattern-ontology-remove-axioms.owl -o $@

../patterns/pattern.owl: ../patterns/pattern-with-imports.owl
	$(ROBOT) merge -i ../patterns/pattern-with-imports.owl remove --term http://www.w3.org/2002/07/owl#Nothing reason reduce annotate --ontology-iri $(OBO)/$(ONT)/patterns/pattern.owl -o $@

../patterns/pattern-simple.owl: ../patterns/pattern.owl
	$(ROBOT) merge -i ../patterns/pattern.owl \
	filter --select "<http://purl.obolibrary.org/obo/upheno/patterns*>" --select "self annotations" --signature true --trim true -o ../patterns/pattern-simple.owl

../patterns/dosdp-patterns/README.md: .FORCE
	python ../scripts/patterns_create_overview.py "../patterns/dosdp-patterns|../patterns/dosdp-dev" $@

.PHONY: pattern_ontology
pattern_ontology: ../patterns/pattern-simple.owl

.PHONY: pattern_readmes
pattern_readmes: ../patterns/dosdp-patterns/README.md

.PHONY: upheno_test
upheno_test: $(TMPDIR)/pattern_schema_checks_main $(TMPDIR)/pattern_schema_checks_dev ../patterns/pattern-simple.owl


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