# How to add the uPheno direct relation extension

EQ definitions are powerful tools for reconciling phenotypes across species and driving reasoning. However, they are not all that useful for many "normal" users of our ontologies.

We have developed a little workflow extension to take care of that. 

1. As usual please follow the steps to [install the custom uPheno Makefile extension](custom-upheno-makefile.md) first.
1. Now add a new component to your ont-odk.yaml file (e.g. `src/ontology/mp-odk.yaml`):
```
components:
  products:
    - filename: eq-relations.owl
```
1. We can now choose if we want to add the component to your edit file as well. To do that, follow the [instructions on adding an import](../odk-workflows/RepoManagement.md#Add-new-import) (i.e. adding the component to the edit file and catalog file). The IRI of the component is `http://purl.obolibrary.org/obo/YOURONTOLOGY/components/eq-relations.owl`. For example, for MP, the IRI is `http://purl.obolibrary.org/obo/mp/components/eq-relations.owl`.
1. Now we can generate the component:
```
sh run.sh make components/eq-relations.owl
```
This command will be run automatically during a release (`prepare_release`).
