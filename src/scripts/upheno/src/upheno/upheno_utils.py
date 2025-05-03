import ruamel.yaml
import os
import re
import pandas as pd
from subprocess import check_call
import logging

def preprocess_patterns_for_matching(original_pattern_dir, output_dir, match_owl_thing=True):
    for file in os.listdir(original_pattern_dir):
        if file.endswith(".yaml"):
            logging.info("Processing "+file)
            file_path = os.path.join(output_dir, file)
            try:
                x = open(file_path).read()
                y = ruamel.yaml.round_trip_load(x, preserve_quotes=True)
                print(file_path)
                if match_owl_thing:
                    for v in y['vars']:
                        vsv = re.sub("[']", "", y['vars'][v])
                        y['classes'][vsv] = "owl:Thing"

                with open(file_path, 'w') as outfile:
                    ruamel.yaml.round_trip_dump(y, outfile, explicit_start=True, width=5000)

            except Exception as exc:
                print(exc)