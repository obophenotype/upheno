# Pattern merge - replace old workflow

This document is on how to merge new DOSDP design patterns into an ODK ontology and then how to replace the old classes with the new ones.

### 1. You need a table in tsv format with the DOSDP filler data. Download the tsv table to


    $ODK-ONTOLOGY/src/patterns/data/default/


### 2. Add new pattern yaml filename to 


    $ODK-ONTOLOGY/src/patterns/dosdp-patterns/external.txt

### 3. make definitions.owl 

    cd ODK-ONTOLOGY/src/ontology
    sh run.sh make ../patterns/definitions.owl IMP=false


### 4. Remove old classes with the equivalent newly patternised ones

    sh run.sh make remove_patternised_classes

### 5. Announce the pattern migration in an appropriate channel, for example on the phenotype-ontologies Slack channel.

For example:

>
I have migrated the ... table and changed the tab colour to blue.
You can delete the tab if you wish.
