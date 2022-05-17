#################################################
### Phenotype Ontology Makefile extension #######
#################################################

## This Makfile is intended for use in phenotype
## Ontologies.

MAKEFILE_URL=https://raw.githubusercontent.com/obophenotype/upheno/master/src/ontology/config/pheno.Makefile

.PHONY: update_pheno_makefile
update_pheno_makefile: pheno.Makefile
	echo "Update completed. Please make sure you use make update_pheno_makefile -B to ensure you use the latest version."

pheno.Makefile:
	wget $(MAKEFILE_URL) -O $@

$(SCRIPTSDIR):
	mkdir -p $@

#################################################
### Code for EQ direct relation component #######
#################################################

UPHENO_JAR="https://github.com/obophenotype/upheno-dev/raw/master/src/scripts/upheno-relationship-augmentation.jar"
UPHENO_RELATIONS="https://raw.githubusercontent.com/obophenotype/upheno-dev/master/src/ontology/components/upheno-relations.owl"

$(SCRIPTSDIR)/upheno-relationship-augmentation.jar: | $(SCRIPTSDIR)
	wget $(UPHENO_JAR) -O $@

$(TMPDIR)/phenotype_classes.txt: $(SRC) | $(TMPDIR)
	$(ROBOT) query -i $< --query ../sparql/mp_terms.sparql $@

$(TMPDIR)/$(ONT)-merged-reasoned.owl: $(SRC)
	$(ROBOT) merge -i $< reason -o $@

$(TMPDIR)/upheno_has_phenotype_affecting.owl: ../scripts/upheno-relationship-augmentation.jar $(TMPDIR)/$(ONT)-merged-reasoned.owl $(TMPDIR) tmp/phenotype_classes.txt
	java -jar $^

$(TMPDIR)/upheno-relations.owl: | $(TMPDIR)
	wget $(UPHENO_RELATIONS) -O $@

$(COMPONENTSDIR)/eq-relations.owl: $(TMPDIR)/upheno_has_phenotype_affecting.owl $(TMPDIR)/upheno-relations.owl
	$(ROBOT) merge $(patsubst %, -i %, $^) annotate --ontology-iri $(ONTBASE)/$@ -o $@
