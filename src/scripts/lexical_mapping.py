#!/usr/bin/env python
# coding: utf-8

# In[264]:


import os
import sys

import pandas as pd

# In[265]:


stopwords = ["abnormally", "abnormal", "aberrant", "variant"]
outdir = "../curation/data"
uphenorelease_dir = "../curation/upheno-release/{}/".format(sys.argv[1])

## IN
upheno_mapping_logical = os.path.join(uphenorelease_dir, "upheno_mapping_logical.csv")
upheno_species_lexical_file = os.path.join(uphenorelease_dir, "upheno_species_lexical.csv")

## OUT
upheno_mapping_all = os.path.join(uphenorelease_dir, "upheno_mapping_all.csv")
upheno_mapping_lexical = os.path.join(uphenorelease_dir, "upheno_mapping_lexical.csv")
upheno_mapping_lexical_template = os.path.join(
    uphenorelease_dir, "upheno_mapping_lexical_template.csv"
)
upheno_mapping_problematic = os.path.join(uphenorelease_dir, "upheno_mapping_problematic.csv")

## Load lexical data
df = pd.read_csv(upheno_species_lexical_file)
df.columns = ["iri", "p", "label"]

## Load logical mappings
dfl1 = pd.read_csv(upheno_mapping_logical)[["p1", "p2"]]
dfl2 = dfl1.copy()
dfl2.columns = ["p2", "p1"]
dfl = pd.concat([dfl1, dfl2], ignore_index=True, sort=False)
dfl = dfl.drop_duplicates()
dfl["cat"] = "logical"

## Prepare dataframe for labels
df_label = df[df["p"] == "http://www.w3.org/2000/01/rdf-schema#label"][["iri", "label"]]
df_label.columns = ["iri", "label"]


# In[266]:


df.head()


# In[267]:


dfl.head()


# In[268]:


df_label.head()


# In[269]:


# Preprocess labels. The most important aspect to this the stopword removal. this is done by matching a stopword
# that means 'abnormal', removing it and then adding the actual prefix 'abnormal'. For example, "cell morphology, aberrant"
# will become 'abnormal cell morphology'. Other than that, most special characters other than space and the ' tick-mark
# Are removed


def apply_stopword(x, stopword):
    if x:
        if stopword in x:
            x = "abnormal " + x.replace(stopword, "")
    return x


def preprocess_labels(df, stopwords):
    df["label"] = df["label"].astype(str)
    df["label_pp"] = df["label"].str.replace(r"[(][A-Z]+[)]", "")
    df["label_pp"] = df["label_pp"].str.lower()
    df["label_pp"] = df["label_pp"].str.replace(r"[^0-9a-z' ]", "")

    for stopword in stopwords:
        df["label_pp"] = df["label_pp"].apply(lambda x: apply_stopword(x, stopword))

    df["label_pp"] = df["label_pp"].str.strip()
    df["label_pp"] = df["label_pp"].str.replace(r"[ ]+", " ")
    df = df[~df["iri"].astype(str).str.startswith("http://purl.obolibrary.org/obo/UPHENO_")]
    df = df[df["label_pp"] != ""]
    d = df[["iri", "label_pp"]]
    d.columns = ["iri", "label"]
    d = d.drop_duplicates()
    return d


d = preprocess_labels(df, stopwords)
l = df_label[~df_label["iri"].astype(str).str.startswith("http://purl.obolibrary.org/obo/UPHENO_")]
print(len(d))


# In[270]:


dd = d.groupby("label")["iri"].apply(list).to_dict()


# In[271]:


# This step is a complicated hack that tries to get rid of them of the false exact synonyms.
# The idea is this: if there is an exact synonym between two terms within an ontology, we get rid of the link.
# Sometimes, however, a synonym is shared between more than one term within and ontology and across:
# These cases need to be

import re


def get_dupes(a):
    seen = {}
    dupes = []

    for x in a:
        if x not in seen:
            seen[x] = 1
        else:
            if seen[x] == 1:
                dupes.append(x)
            seen[x] += 1
    return dupes


cases = dict()
cases_internal = dict()
i = 0

exclude_synonyms = dict()

for label in dd:
    iris = dd.get(label)
    onts = [
        re.sub("[_][0-9]+", "", iri.replace("http://purl.obolibrary.org/obo/", "")) for iri in iris
    ]
    if len(onts) > 1:
        if len(onts) != len(set(onts)):
            if len(set(onts)) > 1:
                cases[label] = iris
                print("-----------------------")
                print(label)
                print(iris)
                dupes = get_dupes(onts)
                for dupe in dupes:
                    for iri in iris:
                        if dupe in iri:
                            if label not in exclude_synonyms:
                                exclude_synonyms[label] = []
                            exclude_synonyms[label].append(iri)
            else:
                cases_internal[label] = iris
                for iri in iris:
                    if label not in exclude_synonyms:
                        exclude_synonyms[label] = []
                    exclude_synonyms[label].append(iri)


print(len(cases_internal))
print(len(cases))
print(len(dd))


# In[272]:


x = d


# In[273]:


# Remove all those IRIs that contained duplicates determined in the previous step
d = x
print(len(d))
for label in exclude_synonyms:
    for iri in exclude_synonyms[label]:
        d = d[~((d["iri"] == iri) & (d["label"] == label))]
print(len(d))
d = pd.merge(d, l, on=["iri", "label"], how="outer")
print(len(d))


# In[274]:


dd = d.groupby("label")["iri"].apply(list).to_dict()


# In[275]:


#
def pairwise(t):
    it = iter(t)
    return zip(it, it)


def invert_dol_nonunique(d):
    newdict = {}
    for k in d:
        for v in d[k]:
            newdict.setdefault(v, []).append(k)
    return newdict


def merge_label_equivalent_cliques(dd_rv):
    merge_labels = dict()
    for iri in dd_rv:
        labels_to_merge = dd_rv.get(iri)
        if len(labels_to_merge) > 1:
            for lab in labels_to_merge:
                if lab not in merge_labels:
                    merge_labels[lab] = []
                merge_labels[lab] = list(set(merge_labels[lab] + labels_to_merge))
    return merge_labels


dd_rv = invert_dol_nonunique(dd)
merge_labels = merge_label_equivalent_cliques(dd_rv)


# In[279]:


l[l["iri"] == "http://purl.obolibrary.org/obo/HP_0011138"]


# In[282]:


def compute_mappings(dd, l):
    data = []
    done = set()
    for label in dd:
        if label in done:
            continue
        done.add(label)
        iris = dd.get(label)
        if label in merge_labels:
            for lab in merge_labels[label]:
                iris.extend(dd.get(lab))
                done.add(lab)
        iris = list(set(iris))
        if len(iris) > 1:
            # print(iris)
            pairs = pairwise(iris)
            for pair in pairs:
                data.append([pair[0], pair[1]])
                data.append([pair[1], pair[0]])
    df_mappings = pd.DataFrame.from_records(data)
    df_mappings = df_mappings.drop_duplicates()
    df_mappings["cat"] = "lexical"
    df_mappings.columns = ["p1", "p2", "cat"]
    df_maps = pd.merge(df_mappings, l, how="left", left_on=["p1"], right_on=["iri"])
    df_maps = df_maps.drop("iri", axis=1)
    df_maps = pd.merge(df_maps, l, how="left", left_on=["p2"], right_on=["iri"])
    df_maps = df_maps.drop("iri", axis=1)
    df_maps["o1"] = [
        re.sub("[_][0-9]+", "", iri.replace("http://purl.obolibrary.org/obo/", ""))
        for iri in df_maps["p1"].values
    ]
    df_maps["o2"] = [
        re.sub("[_][0-9]+", "", iri.replace("http://purl.obolibrary.org/obo/", ""))
        for iri in df_maps["p2"].values
    ]
    return df_maps


df_mapping = compute_mappings(dd, l)
print(len(df_mapping))
df_mapping.head()


# In[289]:


## Step to investigate why there are mappings of terms within the same ontology..
## Since exact synonyms and labels were used, no such mapping should exist
## We drop them

w = df_mapping[df_mapping["o1"] == df_mapping["o2"]]
df_maps = df_mapping[df_mapping["o1"] != df_mapping["o2"]]
print(len(w))
w.to_csv(upheno_mapping_problematic, index=False)
# df_maps
# print(df_mapping[df_mapping['p1']=="http://purl.obolibrary.org/obo/ZP_0006897"])
df_mapping_template = df_mapping[["p1", "p2"]].copy()
df_mapping_template.columns = ["Ontology ID", "EquivalentClasses"]

df_mapping_template.loc[-1] = ["ID", "AI obo:UPHENO_0000002"]  # adding a row
df_mapping_template.index = df_mapping_template.index + 1  # shifting index
df_mapping_template.sort_index(inplace=True)

df_mapping.to_csv(upheno_mapping_lexical, index=False)
df_mapping_template.to_csv(upheno_mapping_lexical_template, index=False)

# In[291]:


# Merging the logical mappings with the lexical ones for comparison
print(df_maps.head())
df_m = pd.merge(df_maps[["p1", "p2", "cat"]], dfl, how="outer", on=["p1", "p2"])
df_m = pd.merge(df_m, l, how="left", left_on=["p1"], right_on=["iri"])
df_m = df_m.drop("iri", axis=1)
df_m = pd.merge(df_m, l, how="left", left_on=["p2"], right_on=["iri"])
df_m = df_m.drop("iri", axis=1)
df_m["cat"] = df_m["cat_x"].astype(str) + "-" + df_m["cat_y"].astype(str)
df_m["cat"] = df_m["cat"].str.replace("-nan", "")
df_m["cat"] = df_m["cat"].str.replace("nan-", "")
df_m = df_m.drop("cat_x", axis=1)
df_m = df_m.drop("cat_y", axis=1)

print(df_m["cat"].value_counts(normalize=True))
print(df_m["cat"].value_counts())

df_m.to_csv(upheno_mapping_all, index=False)

df_m.head(5)


# In[ ]:
