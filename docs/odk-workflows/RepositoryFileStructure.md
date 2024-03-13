# Repository structure

The main kinds of files in the repository:

1. Release files
2. Imports
3. [Components](#components)

## Release files
Release file are the file that are considered part of the official ontology release and to be used by the community. A detailed description of the release artefacts can be found [here](https://github.com/INCATools/ontology-development-kit/blob/master/docs/ReleaseArtefacts.md).

## Imports
Imports are subsets of external ontologies that contain terms and axioms you would like to re-use in your ontology. These are considered "external", like dependencies in software development, and are not included in your "base" product, which is the [release artefact](https://github.com/INCATools/ontology-development-kit/blob/master/docs/ReleaseArtefacts.md) which contains only those axioms that you personally maintain.

These are the current imports in UPHENO

| Import | URL | Type |
| ------ | --- | ---- |
| go | https://raw.githubusercontent.com/obophenotype/pro_obo_slim/master/pr_slim.owl | None |
| nbo | http://purl.obolibrary.org/obo/nbo.owl | None |
| uberon | http://purl.obolibrary.org/obo/uberon.owl | None |
| cl | http://purl.obolibrary.org/obo/cl.owl | None |
| pato | http://purl.obolibrary.org/obo/pato.owl | None |
| mpath | http://purl.obolibrary.org/obo/mpath.owl | None |
| ro | http://purl.obolibrary.org/obo/ro.owl | None |
| omo | http://purl.obolibrary.org/obo/omo.owl | None |
| chebi | https://raw.githubusercontent.com/obophenotype/chebi_obo_slim/main/chebi_slim.owl | None |
| oba | http://purl.obolibrary.org/obo/oba.owl | None |
| ncbitaxon | http://purl.obolibrary.org/obo/ncbitaxon/subsets/taxslim.owl | None |
| pr | https://raw.githubusercontent.com/obophenotype/pro_obo_slim/master/pr_slim.owl | None |
| bspo | http://purl.obolibrary.org/obo/bspo.owl | None |
| ncit | http://purl.obolibrary.org/obo/ncit.owl | None |
| fbbt | http://purl.obolibrary.org/obo/fbbt.owl | None |
| fbdv | http://purl.obolibrary.org/obo/fbdv.owl | None |
| hsapdv | http://purl.obolibrary.org/obo/hsapdv.owl | None |
| wbls | http://purl.obolibrary.org/obo/wbls.owl | None |
| wbbt | http://purl.obolibrary.org/obo/wbbt.owl | None |
| plana | http://purl.obolibrary.org/obo/plana.owl | None |
| zfa | http://purl.obolibrary.org/obo/zfa.owl | None |
| xao | http://purl.obolibrary.org/obo/xao.owl | None |
| hsapdv-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-hsapdv.owl | custom |
| zfa-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-zfa.owl | custom |
| zfs-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-zfs.owl | custom |
| xao-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-xao.owl | custom |
| wbbt-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-wbbt.owl | custom |
| wbls-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-wbls.owl | custom |
| fbbt-uberon | http://purl.obolibrary.org/obo/uberon/bridge/uberon-bridge-to-fbbt.owl | custom |
| xao-cl | http://purl.obolibrary.org/obo/uberon/bridge/cl-bridge-to-xao.owl | custom |
| wbbt-cl | http://purl.obolibrary.org/obo/uberon/bridge/cl-bridge-to-wbbt.owl | custom |
| fbbt-cl | http://purl.obolibrary.org/obo/uberon/bridge/cl-bridge-to-fbbt.owl | custom |

## Components
Components, in contrast to imports, are considered full members of the ontology. This means that any axiom in a component is also included in the ontology base - which means it is considered _native_ to the ontology. While this sounds complicated, consider this: conceptually, no component should be part of more than one ontology. If that seems to be the case, we are most likely talking about an import. Components are often not needed for ontologies, but there are some use cases:

1. There is an automated process that generates and re-generates a part of the ontology
2. A part of the ontology is managed in ROBOT templates
3. The expressivity of the component is higher than the format of the edit file. For example, people still choose to manage their ontology in OBO format (they should not) missing out on a lot of owl features. They may choose to manage logic that is beyond OBO in a specific OWL component.

These are the components in UPHENO

| Filename | URL |
| -------- | --- |
| phenotypes_manual.owl | None |
| upheno-mappings.owl | None |
| cross-species-mappings.owl | None |
