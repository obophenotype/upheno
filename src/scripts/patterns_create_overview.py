#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 8 14:24:37 2018

@author: Nicolas Matentzoglu
"""

import os, shutil, sys
import yaml
import re
import pandas as pd
import requests
from time import sleep
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry
import urllib.request


### Configuration

pattern_dirs = sys.argv[1]
md_file = sys.argv[2]

#pattern_dir="/ws/upheno/src/patterns/dosdp-dev"
#md_file=pattern_dir+"/README.md"
config_file = "https://raw.githubusercontent.com/obophenotype/upheno-dev/master/src/curation/upheno-config.yaml"
pattern_matches_location = "https://raw.githubusercontent.com/obophenotype/upheno-dev/master/src/curation/pattern-matches"
pattern_matches_location_gh = "https://github.com/obophenotype/upheno-dev/tree/master/src/curation/pattern-matches"
config = yaml.load(urllib.request.urlopen(config_file))

phenotype_ontologies = config.get("species_modules")

THRESHOLD=99999999

lines = []

lines.append("# Pattern directory")
lines.append("This is a listing of all the patterns hosted as part of this directory")
lines.append("")

i = 0

for pattern_dir in pattern_dirs.split("|"):
    lines.append("## Patterns in {}".format(os.path.basename(pattern_dir)))
    files = os.listdir(pattern_dir)
    files.sort()

    for filename in files:
        if filename.endswith(".yaml"):
            f_path = os.path.join(pattern_dir,filename)
            f = open(f_path)
            try:
                y = yaml.load(f, Loader=yaml.FullLoader)
                fn = os.path.basename(filename)
                splitted = " ".join(re.sub('([A-Z][a-z]+)', r' \1', re.sub('([A-Z]+)', r' \1', fn)).split()).replace(".yaml","")
                splitted = splitted.lower().capitalize()
                variables = ""
                classes = ""
                contributors = ""


                for v in y['vars']:
                    vs = re.sub("[^0-9a-zA-Z _]", "", y['vars'][v])
                    vsv = re.sub("[']", "", y['vars'][v])
                    variables = variables+vs+" ("+y['classes'][vsv]+"), "
                
                for v in y['classes']:
                    cid = y['classes'][v]
                    classes = classes+cid+", "
                
                if 'contributors' in y:    
                    for v in y['contributors']:
                        contributors = contributors+"["+re.sub("https[:][/][/]orcid[.]org[/]","",v)+"]("+v+"), "
                
                examples = []
                tsv = fn.replace(".yaml",".tsv")
                for o in phenotype_ontologies:
                    url = "{}/{}/{}".format(pattern_matches_location,o,tsv)
                    ghurl = "{}/{}/{}".format(pattern_matches_location_gh,o,tsv)
                    print(url)
                    if i < THRESHOLD:
                        try:
                            df=pd.read_csv(url,sep="\t")
                            if not df.empty:
                                examples.append('[{}]({})'.format(o,ghurl))
                                i = i +1
                            else:
                                print("No matches!")
                            sleep(0.2)
                        except Exception as e:
                            print("No matches!")
                
                lines.append("### "+splitted)
                lines.append("*" + y['description']+"*")
                lines.append("")
                lines.append("| Attribute | Info |")
                lines.append("|----------|----------|")
                lines.append("| IRI | " + y['pattern_iri'] + " |")
                lines.append("| Name | " + y['pattern_name'] + " |")
                lines.append("| Classes | "+classes+" |")
                lines.append("| Variables | "+variables+" |")
                lines.append("| Contributors | "+contributors+" |")
                lines.append("| Examples | "+' '.join(examples)+" |")
                lines.append("")

            except yaml.YAMLError as exc:
                print(exc)

with open(md_file, 'w') as f:
    for item in lines:
        f.write("%s\n" % item)

