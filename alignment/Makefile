OBO=http://purl.obolibrary.org/obo
all: mp_hp-align-equiv.owl mp_hp-align-equiv-labeled.obo mp_hp-lexflipped.txt



combined-symp-%.obo:
	blip ontol-query -r symp -r $* -n % -to obo > $@
.PRECIOUS: combined-symp-%.obo

combined-symp-%.owl: combined-symp-%.obo
	owltools $^ --merge-support-ontologies -o $@
.PRECIOUS: combined-symp-%.owl

combined-symp-ALL.obo:
	blip ontol-query -r symp -r HP -r MP -r DOID -n % -to obo > $@

# BLIP

symp-%-intermatch.tsv: combined-symp-%.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_label_intermatch(A,B,Match,_,_)" -select "x(A,B,Match)" -label -no_pred -use_tabs > $@.tmp && sort -u $@.tmp > $@
.PRECIOUS: symp-%-intermatch.tsv

symp-%-intermatch.pro: symp-%-intermatch.tsv
	tbl2p -p m $< > $@

symp-%-unmatched.tsv: symp-%-intermatch.pro
	blip-findall -i $< -r symp "class(X),\+m(X,_,_,_,_,_)" -select X -label -use_tabs > $@

# KBOOM

symp-%-ptable.tsv:  combined-symp-%.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index  -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_mprobs/6" -no_pred  > $@.tmp && sort -u $@.tmp | grep -v UMLS > $@

symp-%-ptable-debug.tsv:  combined-symp-%.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index  -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_mprobs/6" -no_pred -label  > $@.tmp && sort -u $@.tmp | grep -v UMLS > $@

symp-%-ptable.pro: symp-%-ptable.tsv
	tbl2p -p ptable $< > $@

symp-%-align.tsv: symp-%-ptable.pro 
	blip-findall -u metadata_nlp -i $<  -i ignore_word_phenotype.pro -i combined-symp-$*.obo -consult getbest.pro best/2 -label -use_tabs -no_pred  > $@

symp-%-kboom.owl: symp-%-ptable.tsv combined-symp-%.owl
	kboom --experimental  --splitSize 50 --max 3 -m linked-rpt.md -j linked-rpt.json -n -o $@ -t $^



# write with equivalent_to axioms
symp-%-align-equiv.obo: symp-%-align.txt
	cut -f2,3 $<  | sort -u | tbl2obolinks.pl --aa 'source=textmatch' --rel equivalent_to - > $@
symp-%-align-equiv-labeled.obo: symp-%-align-equiv.obo
	obo-add-comments.pl -t id -t equivalent_to $(MP) $(HP) $< > $@

%.owl: %.obo
	owltools $< --set-ontology-id $(OBO)/upheno/hp-mp/$@ -o $@

