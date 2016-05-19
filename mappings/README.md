__NOTE: when browsing the TSVs on GitHub, the right hand columns may appear truncated__

## Generated fuzzy matchings between ontologies

Use the following PURLs:

 * http://purl.obolibrary.org/obo/upheno/mappings/hp-to-zp-bestmatches.tsv
 * http://purl.obolibrary.org/obo/upheno/mappings/hp-to-mp-bestmatches.tsv

Columns:

 1. HP Class ID
 2. HP Class Label
 3. Other ontology class ID
 4. Other ontology class Label
 5. Fuzzy equivalence score
 5. Fuzzy SubClass score

Both scores range over 0 to 1.

Currently the fuzzy equivalence score is the Jaccard similarity:

    |Anc(C) /\ Anc(D)|
    ------------------
    |Anc(C) \/ Anc(D)|

The fuzzy SubClass score is a measure of how much the HP class is a subclass of the external class:

    |Anc(C) /\ Anc(D)|
    ------------------
         |Anc(D)|


 
 
