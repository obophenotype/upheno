# uPheno Pipeline Notes

Internal working notes on how the uPheno build pipeline works.

## Key Files

| File | Role |
|------|------|
| `src/ontology/upheno.Makefile` | Custom build targets (extends ODK Makefile) |
| `src/ontology/Makefile` | Main ODK-generated Makefile |
| `src/scripts/upheno_build.py` | Python CLI with subcommands for pipeline steps |
| `src/scripts/upheno_prepare.py` | Downloads sources, matches patterns |
| `src/scripts/upheno_create_profiles.py` | Creates species profiles from pattern matches |
| `src/curation/upheno-config.yaml` | Central pipeline configuration |

## Label Generation for Grouping Classes (UPHENO_7* terms)

These are cross-species grouping classes that don't have an EQ (equivalence axiom).

### Data flow

1. **`upheno.Makefile` target `update_manual_alignments`** (line ~122) calls:
   ```
   python3 upheno_build.py create-upheno-groupings \
     --cross-species-mapping .../upheno-cross-species.sssom.tsv \
     --species-independent-mapping .../upheno-species-independent.sssom.tsv \
     --upheno-subclasses .../upheno-subclasses.csv \
     --start-id 7000000 \
     --non-eq-groupings .../upheno-ssspo-groupings-no-eq.tsv \
     --non-eq-alignments .../upheno-ssspo-alignments-no-eq.tsv \
     --non-eq-species-independent-mapping .../upheno-species-independent-manual.sssom.tsv
   ```

2. **`create_upheno_groupings()`** in `upheno_build.py` (line ~257):
   - Reads cross-species and species-independent SSSOM mappings
   - Builds connected components of phenotype IDs from cross-species mappings
   - For each group without an existing UPHENO ID, generates a new one (UPHENO:7XXXXXX)
   - Calls **`generate_upheno_label()`** (line ~231) to create the label
   - Writes results to `src/templates/upheno-ssspo-groupings-no-eq.tsv`

3. **`generate_upheno_label()`** (line 231-247):
   - Takes source phenotype labels from the group
   - Strips "abnormal " prefix and ", abnormal" suffix
   - Joins unique labels with "; "
   - **Issue #1012**: This stripping produces labels like "axon", "actin cytoskeleton"
     that clash with terms in other ontologies (GO, anatomy, etc.)

4. **`Makefile` target `upheno-manual-curation.owl`** (line ~591):
   ```
   $(ROBOT) template \
     --template phenotypes-without-patterns.tsv \
     --template upheno-ssspo-groupings-no-eq.tsv \
     ...
   ```
   Uses ROBOT template to build the OWL component from the TSV.

5. The OWL component is included in `upheno-edit.owl` via `OTHER_SRC` (Makefile line 61).

### TSV format (`upheno-ssspo-groupings-no-eq.tsv`)

| Column | ROBOT header | Description |
|--------|-------------|-------------|
| upheno_id | ID | UPHENO CURIE (e.g. UPHENO:7000000) |
| upheno_label | LABEL | Human-readable label |
| parent | SC % SPLIT=\| | Parent class(es), pipe-separated |
| comment | A rdfs:comment | Provenance comment |

### Related components

- `upheno-alignments.owl`: Built from `upheno-ssspo-alignments-no-eq.tsv`, contains SubClassOf axioms mapping species-specific phenotypes to UPHENO grouping classes
- `upheno-mappings.owl`: Built from SSSOM mapping files, contains cross-species mapping annotations
- `upheno-bridge.owl`: Derived from species-independent mappings via SPARQL construct
- `upheno-species-neutral.owl`: Built from the pattern-based pipeline output (`upheno_layer.owl`)

## DOSDP Patterns

Patterns live in `src/patterns/dosdp-dev/` (development) and `src/patterns/dosdp-patterns-curated/` (curated overrides).

Pattern names like `abnormalAnatomicalEntity.yaml` define:
- `name.text`: Label template (e.g., "abnormal %s")
- `equivalentTo.text`: OWL class expression
- `classes`: References to PATO qualities, UBERON anatomy, etc.
- `vars`: Filler variables

The pipeline matches these patterns against species phenotype ontologies to find which terms match which patterns, then uses the matches to build the uPheno intermediate layer.

### DOSDP TSV filler data

Filler data lives in `src/patterns/data/default/` (hand-curated) and `src/patterns/data/automatic/` (generated).

Each TSV has a `defined_class` column (the IRI) plus columns for each pattern variable. dosdp-tools supports special override columns to set per-row annotations on the defined class:

| Column | Effect |
|--------|--------|
| `defined_class_name` | Override the pattern-generated label |
| `defined_class_definition` | Override the pattern-generated definition |
| `defined_class_comment` | Add rdfs:comment |
| `defined_class_exact_synonym` | Add exact synonym |
| `defined_class_narrow_synonym` | Add narrow synonym |
| `defined_class_broad_synonym` | Add broad synonym |
| `defined_class_related_synonym` | Add related synonym |
| `defined_class_namespace` | Set OBO namespace |

These are defined in the DOSDP spec (`PrintfAnnotationOBO.overrides` in dosdp-tools source).

### Source of truth for OWL components

All OWL files in `src/ontology/components/` are **generated** — never edit them directly. Sources of truth:

| Component | Source |
|-----------|--------|
| `upheno-top.owl` | `src/templates/phenotype-top-level.tsv` (ROBOT template) |
| `upheno-manual-curation.owl` | `src/templates/upheno-ssspo-groupings-no-eq.tsv` + `phenotypes-without-patterns.tsv` |
| `upheno-alignments.owl` | `src/templates/upheno-ssspo-alignments-no-eq.tsv` + `phenotype-alignments.tsv` + `root-alignments.tsv` |
| `upheno-species-neutral.owl` | DOSDP pipeline output (`upheno_layer.owl`) |
| `upheno-mappings.owl` | SSSOM mapping files in `src/mappings/` |
| `upheno-bridge.owl` | SPARQL construct over species-independent mappings |
| `upheno-deprecated.owl` | `src/templates/obsolete.tsv` |

## Pipeline Phases (from `upheno.Makefile`)

1. **`prepare_patterns_for_matching`**: Copies patterns from `dosdp-dev/` to `curation/patterns-for-matching/`
2. **`upheno_prepare`** (`upheno_prepare.py`): Downloads sources, matches patterns against phenotype ontologies
3. **`upheno_create_profiles`** (`upheno_create_profiles.py`): Creates species profiles and the uPheno layer OWL
4. **`update_manual_alignments`**: Generates grouping classes for phenotypes without EQ matches
5. Component builds: ROBOT template/merge steps to produce final OWL components
6. **`prepare_release`**: Assembles release artifacts
