#################################################
### Phenotype Ontology Makefile extension #######
#################################################

## This Makfile is intended for use in phenotype
## Ontologies.

MAKEFILE_URL=https://raw.githubusercontent.com/obophenotype/upheno/master/src/ontology/config/pheno.Makefile

.PHONY: update_pheno_makefile
update_pheno_makefile: pheno.Makefile

pheno.Makefile:
	wget $(MAKEFILE_URL) -O $@

#################################################
### Code for EQ direct relation component #######
#################################################

UPHENO_JAR="https://github.com/obophenotype/upheno-dev/raw/master/src/scripts/upheno-relationship-augmentation.jar"
UPHENO_RELATIONS="https://raw.githubusercontent.com/obophenotype/upheno-dev/master/src/ontology/components/upheno-relations.owl"

$(SCRIPTSDIR)/upheno-relationship-augmentation.jar:
	wget $(UPHENO_JAR) -O $@

$(TMPDIR)/phenotype_classes.txt: $(SRC)
	$(ROBOT) query -i $< --query ../sparql/mp_terms.sparql $@

$(TMPDIR)/upheno-has-phenotype-affecting.owl: ../scripts/upheno-relationship-augmentation.jar $(ONT).owl $(TMPDIR) tmp/phenotype_classes.txt
	java -jar $^

$(TMPDIR)/upheno-relations.owl:
	wget $(UPHENO_RELATIONS) -O $@

components/eq-relations.owl: $(TMPDIR)/upheno-has-phenotype-affecting.owl $(TMPDIR)/upheno-relations.owl
	$(ROBOT) merge $(patsubst %, -i %, $^) annotate --ontology-iri $(ONTBASE)/$@ -o $@
