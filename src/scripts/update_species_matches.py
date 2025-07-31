"""update_species_matches"""
import os
import sys

import pandas as pd
import yaml

tsv_dir = sys.argv[1]
matches_dir = sys.argv[2]
patterns_dir = sys.argv[3]
obo_prefix = sys.argv[4]

# tsv_dir="/Users/matentzn/ws/human-phenotype-ontology/src/patterns/data/default"
# matches_dir="/Users/matentzn/ws/upheno-dev/src/curation/pattern-matches/hp"
# patterns_dir="/Users/matentzn/ws/upheno-dev/src/curation/patterns-for-matching"
# obo_prefix = "http://purl.obolibrary.org/obo/"


def get_id_columns(pattern_file):
    with open(pattern_file, "r") as stream:
        try:
            pattern_json = yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)
    idcolumns = list(pattern_json["vars"].keys())
    return idcolumns


i = 10

for filename in os.listdir(matches_dir):
    if filename.endswith(".tsv"):
        print("@@@@@@@@@@@@@@@@")
        print(filename)
        f_match_tsv = os.path.join(matches_dir, filename)
        f_existing_tsv = os.path.join(tsv_dir, filename)
        f_pattern = os.path.join(patterns_dir, filename.replace(".tsv", ".yaml"))
        var_columns = get_id_columns(f_pattern)
        var_columns.extend(["defined_class"])
        print(var_columns)
        dfm = pd.read_csv(f_match_tsv, sep="\t")
        print(dfm.head(4))
        for col in var_columns:
            dfm[col] = [str(i).replace(obo_prefix, "") for i in dfm[col]]
            dfm[col] = [str(i).replace("_", ":") for i in dfm[col]]
        dfm = dfm.sort_values("defined_class", ascending=False)
        dfm = dfm.drop_duplicates()
        if os.path.exists(f_existing_tsv):
            dfe = pd.read_csv(f_existing_tsv, sep="\t")
            print(dfe.head(4))
            for col in var_columns:
                dfe[col] = [str(i).replace(obo_prefix, "") for i in dfe[col]]
                dfe[col] = [str(i).replace("_", ":") for i in dfe[col]]
            dfe = dfe.sort_values("defined_class", ascending=False)
            dfe = dfe.drop_duplicates()
            # dfe.to_csv(f_existing_tsv, sep = '\t', index=False)
        else:
            dfe = pd.DataFrame(columns=dfm.columns)
        print(dfm.head(4))
        print(dfe.head(4))
        if not dfe.empty or not dfm.empty:
            df_out = pd.merge(dfe, dfm, how="outer")
            df_out = df_out.drop_duplicates()
            if not df_out.empty and i > 0:
                df_out.to_csv(f_existing_tsv, sep="\t", index=False)
                i = i - 1
