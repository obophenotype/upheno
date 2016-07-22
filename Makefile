OBO=http://purl.obolibrary.org/obo
WGET= wget --no-check-certificate
all: all_imports

test: reasoner-test-mammal reasoner-test-vertebrate reasoner-test-metazoa

reasoner-test-%: %.owl
	owltools $< --run-reasoner -r elk -u > $@.out && echo ok || (tail -100 $@.out ; exit 1)
explanations-%.txt: %.owl
	owltools $< --run-reasoner -r elk -u -e > $@.out && echo ok || (tail -100 $@.out ; exit 1)

# local copies, for seeding
mp-edit.owl:
	$(WGET) $(OBO)/mp/mp-edit.owl -O $@
hp-edit.owl:
	$(WGET)  $(OBO)/hp/hp-edit.owl -O $@

# ----------------------------------------
# Module extraction / Imports generation
# ----------------------------------------
#
# We create shared modules for the combined set of phenotype
# ontologies
#
# Uses OWLAPI Module Extraction code
#
# Type 'make imports/X_import.owl' whenever you wish to refresh the import for an ontology X. This is when:
#
#  1. X has changed and we want to include these changes
#  2. We have added onr or more new IRI from X into any of the xp files
#
# You should NOT edit these files directly, changes will be overwritten.
#
# If you want to add something to these, edit the xp obo file and add an axiom with a IRI from X. You don't need to add any information about X.
#
# **Note that imports are shared by all projects**
# this means that any one import will be larger than is strictly required for any one species, but there are advantages to sharing here

# Base URI for local subset imports
UPHENO = $(OBO)/upheno

# Ontology dependencies. TODO - nbo
IMPORTS = pato uberon chebi pr go doid mpath nbo

# Make this target to regenerate ALL
all_imports: all_imports_owl all_imports_obo
all_imports_owl: $(patsubst %, imports/%_import.owl,$(IMPORTS))
all_imports_obo: $(patsubst %, imports/%_import.obo,$(IMPORTS))

KEEPRELS = BFO:0000050 BFO:0000051 RO:0002202 immediate_transformation_of

# Create an import module using the OWLAPI module extraction code via OWLTools.
# We use the standard catalog, but rewrite the import to X to be a local mirror of ALL of X.
# After extraction, we further reduce the ontology by creating a "mingraph" (removes all annotations except label) and by 

#imports/wbbt_import.owl: wbphenotype/wbphenotype-equivalence-axioms-subq-ubr.owl mirror/wbbt.owl
#	owltools  $(USECAT) --map-ontology-iri $(UPHENO)/wbbt_import.owl mirror/wbbt.owl $< --merge-imports-closure mirror/$*.owl --add-imports-from-support  --extract-module -s $(OBO)/$*.owl -c --remove-axiom-annotations --make-subset-by-properties $(KEEPRELS) --set-ontology-id $(UPHENO)/$@ -o $@


IMPORT_REQUESTS = imports/imports_requests.owl

# GENERIC:
imports/%_import.owl: imports/upheno-preimporter.owl $(IMPORT_REQUESTS) mirror/%.owl mp-edit.owl
	owltools  $(USECAT) --map-ontology-iri $(UPHENO)/$*_import.owl mirror/$*.owl $< --merge-imports-closure mirror/$*.owl --add-imports-from-support  --extract-module -s $(OBO)/$*.owl -c --remove-axiom-annotations --make-subset-by-properties -f $(KEEPRELS) -o $@.tmp && owltools $@.tmp --set-ontology-id $(UPHENO)/$@ -o $@

imports/ro_import.owl: imports/upheno-preimporter.owl $(IMPORT_REQUESTS) mirror/ro.owl mp-edit.owl
	owltools  $(USECAT) --map-ontology-iri $(UPHENO)/ro_import.owl mirror/ro.owl $< --merge-imports-closure mirror/ro.owl --add-imports-from-support  --extract-module -s $(OBO)/ro.owl -c  -o ro.tmp && owltools ro.tmp --set-ontology-id $(UPHENO)/$@ -o $@

imports/fma_import.owl:
	echo "This is manually curated"

# clone remote ontology locally, perfoming some excision of relations and annotations
mirror/%.owl:
	owltools $(OBO)/$*.owl --remove-annotation-assertions -l --remove-dangling-annotations  --make-subset-by-properties -f $(KEEPRELS) --extract-mingraph --set-ontology-id $(OBO)/$*.owl -o $@
# uberon-ext is actually uberon+cl
mirror/uberon-ext.owl: 
	owltools $(OBO)/uberon/ext.owl --merge-imports-closure -o $@
#mirror/fma-orig.owl: 
#	$(WGET) $(OBO)/fma.owl -O $@

## ANNOYING: this needs built periodically to avoid stale imports
mirror/fma.owl:
	owltools mirror/composite-fma.owl --extract-mingraph --set-ontology-id $(OBO)/fma.owl -o $@
mirror/ro.owl:
	$(WGET) $(OBO)/ro.owl -O $@

# See https://github.com/obophenotype/upheno/issues/159
mirror/nbo.obo:
	$(WGET) $(OBO)/nbo.obo -O $@.tmp && egrep -v '^(import|property_value)' $@.tmp > $@
mirror/nbo.owl: mirror/nbo.obo
	owltools $<  --remove-annotation-assertions -l --remove-dangling-annotations  --make-subset-by-properties -f $(KEEPRELS) --extract-mingraph --set-ontology-id $(OBO)/nbo.owl -o $@.tmp && perl -npe 's@obo/nbo.owl/@obo/@' $@.tmp > $@

mirror/wbbt.owl:
	owltools $(OBO)/uberon/basic.owl $(OBO)/cl.owl $(OBO)/wbls.owl $(OBO)/wbbt.owl $(OBO)/uberon/bridge/uberon-bridge-to-wbbt.owl $(OBO)/uberon/bridge/cl-bridge-to-wbbt.owl $(OBO)/ncbitaxon/subsets/taxslim.owl --merge-support-ontologies --remove-annotation-assertions -l --remove-dangling-annotations --make-subset-by-properties $(KEEPRELS)  --set-ontology-id $(OBO)/wbbt.owl -o $@
###	owltools $(OBO)/uberon/ext.owl --remove-annotation-assertions -l --remove-dangling-annotations --make-subset-by-properties $(KEEPRELS) --set-ontology-id $(OBO)/uberon.owl -o $@
###	owltools  $(OBO)/wbls.owl $(OBO)/wbbt.owl --merge-support-ontologies --remove-annotation-assertions -l --remove-dangling-annotations --make-subset-by-properties $(KEEPRELS)  --set-ontology-id $(OBO)/wbbt.owl -o $@
mirror/go.owl: 
	owltools $(OBO)/go/extensions/go-plus.owl $(OBO)/go/extensions/x-metazoan-anatomy.owl    --merge-imports-closure --merge-support-ontologies --remove-annotation-assertions -l --remove-dangling-annotations  --make-subset-by-properties -f $(KEEPRELS) --extract-mingraph --set-ontology-id $(OBO)/go.owl -o $@
mirror/pr.obo:
	$(WGET) $(OBO)/pr.obo -O $@.tmp && obo-grep.pl -r 'id: PR:' $@.tmp > $@
mirror/pr.owl: mirror/pr.obo
	owltools $< --remove-dangling --set-ontology-id $(OBO)/pr.owl -o $@
.PRECIOUS: mirror/%.owl

#imports/ro_import.owl: mirror/ro.owl imports/upheno-preimporter.owl
#	owltools  $(USECAT) --map-ontology-iri $(UPHENO)/ro_import.owl mirror/ro.owl imports/upheno-preimporter.owl --merge-imports-closure mirror/ro.owl  --add-imports-from-supports  --extract-module -s $(OBO)/ro.owl -c --extract-mingraph --set-ontology-id $(UPHENO)/$@ -o $@

imports/so_import.owl:
	owltools  $(USECAT) $< $(UPHENO)/data/human-genes.owl $(OBO)/so.owl --add-imports-from-supports --extract-module -s $(OBO)/so.owl -c --extract-mingraph --remove-annotation-assertions -l -d -s --make-subset-by-properties -f // --set-ontology-id $(UPHENO)/$@ -o $@

imports/%_import.obo: imports/%_import.owl
	owltools $< -o -f obo $@

imports/%_phenotype.obo: imports/%_phenotype.owl
	owltools $< --assert-inferred-subclass-axioms --removeRedundant --allowEquivalencies  -o -f obo $@

external/uberon/%.owl:
	echo $@

external/mirror/%.owl:
	$(WGET) $(OBO)/$*.owl -O $@





# ----------------------------------------
# GROUPINGS
# ----------------------------------------
util/blacklist.js:
	owljs -i tools/make-blacklist.js

#imports/%_phenotype.owl: imports/%_import.owl ./tools/blacklist.js 
#	owljs -i tools/make-grouping-classes.js

imports/%_import.tsv: imports/%_import.owl
	owltools $< --export-table $@.tmp && cut -f1,2 $@.tmp > $@

imports/%_entities.tsv: imports/%_import.tsv
	 ./tools/make-entity-table.pl $< imports/entity_blacklist.tsv  > $@.tmp && mv $@.tmp $@

imports/%_phenotype.omn: imports/%_entities.tsv
	apply-pattern.py -p patterns/grouping_phenotype.yaml -i $< > $@.tmp && mv $@.tmp $@
imports/%_phenotype.owl: imports/%_phenotype.omn
	owltools $< --set-ontology-id $(UPHENO)/$@ -o $@

##

zp.owl:
	wget $(OBO)/upheno/zp.owl -O $@
zp.obo:
	owltools $(OBO)/upheno/zp.owl --add-ontology-annotation http://www.geneontology.org/formats/oboInOwl#logical-definition-view-relation has_part --add-obo-shorthand-to-properties -o -f obo --no-check $@

## ----------------------------------------
## MERGES
## ----------------------------------------
%-r.owl: %.owl
	owltools  --use-catalog $< --merge-imports-closure --reasoner elk  --assert-inferred-subclass-axioms --allowEquivalencies --remove-redundant-inferred-super-classes -o $@
#	https://github.com/obophenotype/upheno/issues/162
#	robot merge -c true -i $< reason -r elk  reduce -o $@
.PRECIOUS: %-r.owl

mp-hp-view.owl: mp-hp-r.owl
	owltools $(USECAT) $< --make-subset-by-properties -f // --reasoner-query -r elk MP_0000001  --make-ontology-from-results $(OBO)/upheno/$@ -o $@
mp-hp-view.obo: mp-hp-view.owl
	owltools $< -o -f obo $@.tmp && grep -v ^owl-axioms $@.tmp > $@

## ----------------------------------------
## MAPPINGS
## ----------------------------------------

%-compute.obo: %.owl
	owltools $(USECAT) $< --merge-imports-closure --remove-axiom-annotations --remove-disjoints --remove-abox --remove-annotation-assertions -l --assert-inferred-subclass-axioms --always-assert-super-classes --removeRedundant --allowEquivalencies --make-subset-by-properties -f // -o -f obo --no-check $@
.PRECIOUS: %-compute.obo

all_mappings: mappings/zp-to-hp-match.tbl mappings/hp-to-zp-match.tbl mappings/hp-to-mp-match.tbl
mappings/%-match.tbl: vertebrate-compute.obo
	owltools $(USECAT) $< --make-default-abox --fsim-compare-atts -p mappings/$*-sim.properties -o $@.tmp && mv $@.tmp $@

mappings/hp-to-wbphenotype-match.tbl: metazoa-compute.obo
	owltools $(USECAT) $< --make-default-abox --fsim-compare-atts -p mappings/hp-to-wbphenotype-sim.properties -o $@.tmp && mv $@.tmp $@


mappings/%-bestmatches.tsv: mappings/%-match.tbl
	./tools/extract-bestmatches.pl $< > $@.tmp && mv $@.tmp $@
