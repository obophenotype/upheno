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

## Running a full release

A full uPheno release is **two distinct phases**, not one command. The critical
thing to remember: **`sh prepare_release.sh` does not refresh anything** — it runs
with `IMP=false MIR=false PAT=false` and only assembles a release from whatever is
already on disk. Downloading the species-specific phenotype ontologies and
re-matching patterns is a separate, expensive phase (**Phase A**) that you run first.

> There is intentionally **no single one-button target** that chains Phase A → grouping
> regeneration → Phase B, largely because Phase A is run on a big-memory dev server
> (see below), not on a laptop.

### Phase A — Refresh the uPheno layer (heavy: downloads + pattern matching)

Run the `upheno` target, which chains steps 1–3 above:

```sh
cd src/ontology
sh run.sh make upheno -B
```

This downloads **all ~50 source ontologies** listed under `sources:` in
`../curation/upheno-config.yaml` (the species phenotype ontologies mp, hp, zp, xpo,
wbphenotype, fypo, ddpheno, phipo, planp, dpo, apo, mgpo, … plus fillers uberon, cl,
go, pr, chebi, pato, nbo, mpath, …), merges + taxon-restricts them, matches every
DOSDP pattern against every phenotype ontology, and builds the uPheno intermediate
layer (`upheno_layer.owl`) and species profiles.

Then regenerate the cross-species grouping classes (`UPHENO:7*`, the ones with no EQ),
which is **not** part of the `upheno` target:

```sh
sh run.sh make update_manual_alignments -B
```

To also refresh curated pattern overrides before matching, run `full_patterns_pipeline`
instead of relying on step 0's `prepare_patterns_for_matching` alone.

**Resource reality:** this phase pulls CHEBI, PRO, NCBITaxon and Uberon and matches
across all phenotype ontologies. `upheno-config.yaml` sets `-Xmx30G` and a `500m`
per-process timeout — it does not run comfortably on a laptop. In practice Phase A is
run on the **upheno-dev server**, and the resulting `src/curation/` outputs are pulled
back to the working copy with the top-level `sync.sh`. Relevant config knobs:
`overwrite_ontologies`, `overwrite_matches`, `overwrite_upheno_intermediate` (all `True`
= full refresh) and `skip_pattern_download`.

### Phase B — Build and assemble the release

Standard ODK prep first (clean `master`, `git pull`, new `release-YYYY-MM-DD` branch,
`docker pull obolibrary/odkfull`), then refresh imports and assemble:

```sh
cd src/ontology
sh run.sh make refresh-imports     # needed: a stale/missing imports/merged_import.owl breaks the build
sh prepare_release.sh              # NOT `make prepare_release` — that target is deliberately disabled
```

`prepare_release.sh` calls `run.sh make prepare_release_customised …` and produces
`upheno.{owl,obo,json}`, `upheno-base`, `upheno-full`, `upheno-basic`, the
curated / equivalence-model variants, and copies the pattern files into the release
directory at the top level of the repo.

### Phase C — Ship it

Follow the ODK release workflow: eyeball `upheno.owl` in Protégé, commit on the release
branch, open a PR and review `upheno.obo` / `upheno-base.owl` / `upheno-full.owl`, merge
after CI + review, then draft a GitHub release tagged `v<data-version>` (the date from
`upheno.obo`'s `data-version:`).

> ⚠️ The generic `docs/odk-workflows/ReleaseWorkflow.md` is the stock ODK doc and is
> **wrong for this repo**: it tells you to run `sh run.sh make prepare_release`, but that
> target is disabled here with a "DO NOT USE" warning. Always use `sh prepare_release.sh`.
