# Pattern merge - replace workflow

This document is on how to merge new DOSDP design patterns into an ODK ontology and then how to replace the old classes with the new ones.

### 1. You need the tables in tsv format with the DOSDP filler data. Download the tsv tables to


    $ODK-ONTOLOGY/src/patterns/data/default/

Make sure that the tsv filenames match that of the relevant yaml DOSDP pattern files.

### 2. Add the new matching pattern yaml filename to 


    $ODK-ONTOLOGY/src/patterns/dosdp-patterns/external.txt


### 3. Import the new pattern templates that you have just added to the `external.txt` list from external sources into the current working repository

    cd ODK-ONTOLOGY/src/ontology
    sh run.sh make update_patterns

### 4. make definitions.owl

    cd ODK-ONTOLOGY/src/ontology
    sh run.sh make ../patterns/definitions.owl IMP=false


### 5. Remove old classes and replace them with the equivalent and patternised new classes

    cd ODK-ONTOLOGY/src/ontology
    sh run.sh make remove_patternised_classes

### 6. Announce the pattern migration in an appropriate channel, for example on the phenotype-ontologies Slack channel.

For example:

>
I have migrated the ... table and changed the tab colour to blue.
You can delete the tab if you wish.
