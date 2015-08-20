all: mp_hp-align-equiv.owl mp_hp-align-equiv-labeled.obo mp_hp-flipped.txt

joined.obo: ../mp.obo ../hp.obo mp_hp-disjoint_from.obo
	obo-cat.pl ../mp.obo ../hp.obo | grep -v xref > $@
mp_hp-align.txt: mp_hp-disjoint_from.obo joined.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index -i joined.obo -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_label_reciprocal_best_intermatch(A,B,true),\+((subclassRT(A,AX),disjoint_fromS(AX,BX),subclassRT(B,BX)))" -select A-B  > $@.tmp && sort -u $@.tmp | grep -v UMLS > $@


mp_hp-align-debug.txt: mp_hp-disjoint_from.obo joined.obo ignore_word_phenotype.pro
	blip-findall -table_pred ontol_db:subclassT/2 -i $< -u metadata_nlp -debug index -i joined.obo -i ignore_word_phenotype.pro -index "metadata_nlp:entity_nlabel_scope_stemmed(1,1,0,0)" "entity_pair_label_reciprocal_best_intermatch(A,B,true),\+((subclassRT(A,AX),disjoint_fromS(AX,BX),subclassRT(B,BX))),entity_pair_label_match(A,B,St,ZA,ZB,Match)" -select "x(A,B,Match)" -label > $@

# write with equivalent_to axioms
mp_hp-align-equiv.obo: mp_hp-align.txt
	cut -f2,3 $<  | sort -u | tbl2obolinks.pl --aa 'source=textmatch' --rel equivalent_to - > $@
mp_hp-align-equiv-labeled.obo: mp_hp-align-equiv.obo
	obo-add-comments.pl -t id -t equivalent_to ../mp.obo ../hp.obo $< > $@

%.owl: %.obo
	obolib-obo2owl --allow-dangling --default-ontology $*  $< -o $@

# flips based on lexical matching
mp_hp-lexflipped.txt: mp_hp-align-equiv.obo
	blip-findall -u metadata_nlp -table_pred ontol_db:subclassT/2 -i ../mp.obo -i ../hp.obo -i $< "equivalent_class(A,XA),subclassT(A,B),equivalent_class(B,XB),subclassT(XB,XA),entity_pair_label_match(A,XA,_,_,_,LA),entity_pair_label_match(B,XB,_,_,_,LB)" -select "x(A,B,XA,XB,LA,LB)" -label -no_pred -use_tabs | sort -u > $@

%-flipped.txt: %.obo
	blip-findall -i ../mp.obo -i ../hp.obo -i $< class_quad_flip/4 -label | sort -u > $@.tmp && mv $@.tmp $@

mismatched-xp.txt: mp_hp-align-equiv.obo
	blip-findall -consult quality_control.pro -i $< -r mammalian_phenotype -r human_phenotype  -r mammalian_phenotype_xp -r human_phenotype_xp -r uberonp xp_mismatch/5 -label -no_pred > $@.tmp && sort -u $@.tmp > $@
