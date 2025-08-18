## How to run a uPheno release

1. `cd src/ontology`
2. `sh prepare_release.sh`
3. `make public_release GHVERSION=v2025-07-21` (update the date to the current date) 

## uPheno 2 editors workflows

### Prepare patterns for matching

This is the first step in the uPheno 2 release process. It prepares the patterns for matching by copying them to a specific directory.

```bash
cd src/ontology
make prepare_patterns_for_matching
```

### Prepare changed patterns

Prepares the changed patterns by copying them to a specific directory. This process takes the original uPheno patterns curated by the uPheno team and prepares them for generating the final ontology. For example, this step ensures that pattern labels are updated and definitions as well.

```bash
cd src/ontology
make prepare_changed_patterns
```

