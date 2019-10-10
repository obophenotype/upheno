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

### Configuration

pattern_dir = sys.argv[1]
md_file = sys.argv[2]

#pattern_dir="/ws/upheno/src/patterns/dosdp-dev"
#md_file=pattern_dir+"/README.md"

lines = []

lines.append("# Pattern directory")
lines.append("This is a listing of all the patterns hosted as part of this directory")
lines.append("")
lines.append("## Patterns")

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
            contributors = ""


            for v in y['vars']:
                vs = re.sub("[^0-9a-zA-Z _]", "", y['vars'][v])
                vsv = re.sub("[']", "", y['vars'][v])
                variables = variables+vs+" ("+y['classes'][vsv]+"), "
            
            if 'contributors' in y:    
                for v in y['contributors']:
                    contributors = contributors+"["+re.sub("https[:][/][/]orcid[.]org[/]","",v)+"]("+v+"), "

            lines.append("### "+splitted)
            lines.append("*" + y['description']+"*")
            lines.append("")
            lines.append("| Attribute | Info |")
            lines.append("|----------|----------|")
            lines.append("| IRI | " + y['pattern_iri'] + " |")
            lines.append("| Name | " + y['pattern_name'] + " |")
            lines.append("| Variables | "+variables+" |")
            lines.append("| Contributors | "+contributors+" |")
            lines.append("")

        except yaml.YAMLError as exc:
            print(exc)

with open(md_file, 'w') as f:
    for item in lines:
        f.write("%s\n" % item)

