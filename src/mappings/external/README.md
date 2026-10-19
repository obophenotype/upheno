# External mappings

Mapping sets provided by other groups, used as extra input to the uPheno grouping
pipeline (`update_manual_alignments` in `src/ontology/upheno.Makefile`). One SSSOM TSV per
source; list it in `EXTERNAL_MAPPINGS` and give it a download rule there, refreshed with
`MIR=true`.

Their exact matches are added to the cross-species mappings before groupings are built, and
replace our own purely lexical matches where they conflict. Matches that disagree with
existing uPheno placements are reported in `reports/upheno-harmonisation-opportunities.tsv`
rather than applied; to apply one, add a row to `../upheno-manual-overrides.sssom.tsv`.

| File | Source | Notes |
|---|---|---|
| `mp-hp-mgi-lex.sssom.tsv` | [MGI, mh_mapping_initiative](https://github.com/mapping-commons/mh_mapping_initiative) | Lexical MP-HP matches, regenerated weekly. Only label-to-label exact matches are used (#1013). |
