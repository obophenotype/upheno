OBO=http://purl.obolibrary.org/obo
all: mp_hp-align-equiv.owl mp_hp-align-equiv-labeled.obo mp_hp-lexflipped.txt

MP=mp.obo
HP=hp.obo

$(MP):
	wget $(OBO)/$@ -O $@
$(HP):
	wget --no-check-certificate $(OBO)/$@ -O $@

joined.obo: $(MP) $(HP) mp_hp-disjoint_from.obo
	obo-cat.pl $(MP) $(HP) | grep -v xref > $@

old-mp_hp-align.txt: mp_hp-disjoint_from.obo joined.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index -i joined.obo -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_label_reciprocal_best_intermatch(A,B,true),\+((subclassRT(A,AX),disjoint_fromS(AX,BX),subclassRT(B,BX)))" -select A-B  > $@.tmp && sort -u $@.tmp | grep -v UMLS > $@

mp_hp-ptable.tsv: mp_hp-disjoint_from.obo joined.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index -i joined.obo -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_mprobs/6" -no_pred  > $@.tmp && sort -u $@.tmp | grep -v UMLS > $@

mp_hp-ptable.pro: mp_hp-ptable.tsv
	tbl2p -p ptable $< > $@

ambiguous.tsv: mp_hp-ptable.pro
	blip-findall -u metadata_nlp -i $<  -i ignore_word_phenotype.pro -i joined.obo -consult getbest.pro tie/4 -label -no_pred > $@

mp_hp-align.txt: mp_hp-ptable.pro
	blip-findall -u metadata_nlp -i $<  -i ignore_word_phenotype.pro -i joined.obo -consult getbest.pro best/2  > $@

all.owl: joined.obo mp_hp-disjoint_from.obo
	owltools $^ --merge-support-ontologies -o $@

mp_hp-kboom.owl: mp_hp-ptable.tsv all.owl
	kboom --experimental  --splitSize 50 --max 3 -m linked-rpt.md -j linked-rpt.json -n -o $@ -t $^


mp_hp-align-debug.txt: mp_hp-disjoint_from.obo joined.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index -i joined.obo -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_label_reciprocal_best_intermatch(A,B,true),\+((subclassRT(A,AX),disjoint_fromS(AX,BX),subclassRT(B,BX))),entity_pair_label_match(A,B,St,ZA,ZB,Match)" -select "x(A,B,Match)" -label > $@

# write with equivalent_to axioms
mp_hp-align-equiv.obo: mp_hp-align.txt
	cut -f2,3 $<  | sort -u | tbl2obolinks.pl --aa 'source=textmatch' --rel equivalent_to - > $@
mp_hp-align-equiv-labeled.obo: mp_hp-align-equiv.obo
	obo-add-comments.pl -t id -t equivalent_to $(MP) $(HP) $< > $@

%.owl: %.obo
	owltools $< --set-ontology-id $(OBO)/upheno/hp-mp/$@ -o $@

# flips based on lexical matching
mp_hp-lexflipped.txt: mp_hp-align-equiv.obo
	blip-findall -u metadata_nlp -table_pred ontol_db:subclassT/2 -i $(MP) -i $(HP) -i $< "equivalent_class(A,XA),subclassT(A,B),equivalent_class(B,XB),subclassT(XB,XA),entity_pair_label_match(A,XA,_,_,_,LA),entity_pair_label_match(B,XB,_,_,_,LB)" -select "x(A,B,XA,XB,LA,LB)" -label -no_pred -use_tabs | sort -u > $@

%-flipped.txt: %.obo
	blip-findall -i $(MP) -i $(HP) -i $< class_quad_flip/4 -label | sort -u > $@.tmp && mv $@.tmp $@

mismatched-xp.txt: mp_hp-align-equiv.obo
	blip-findall -consult quality_control.pro -i $< -r mammalian_phenotype -r human_phenotype  -r mammalian_phenotype_xp -r human_phenotype_xp -r uberonp xp_mismatch/5 -label -no_pred > $@.tmp && sort -u $@.tmp > $@
