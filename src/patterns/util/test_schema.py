# adapted from https://github.com/dosumis/dead_simple_owl_design_patterns/blob/master/spec/test_schema.py by cjm
import yaml
from jsonschema import Draft4Validator
import warnings
import argparse
import logging
import sys

def main():
    """
    Wrapper for schema testing
    """
    logging.basicConfig(level=logging.INFO)
    logging.info("Welcome!")
    parser = argparse.ArgumentParser(description='Tests yaml DP syntax and structure'
                                                 """
                                                 foo
                                                 """,
                                     formatter_class=argparse.RawTextHelpFormatter)

    parser.add_argument('files',nargs='*')
    args = parser.parse_args()
    
    dosdp_full_file = open("./util/DOSDP_schema_full.yaml", "r")
    dosdp = yaml.load(dosdp_full_file.read())
    V = Draft4Validator(dosdp)
    stat = True
    for file in args.files:
        print('PARSING: '+file)
        if not test_jschema(V, file):
            print("FAILED to validate: "+file)
            stat = False
        else:
            print("SUCCESS ON: "+file)
    if not stat:
        print("FAILURES ENCOUNTERED")        
        sys.exit(1)
    else:
        print("ALL PASS")
        sys.exit(0)

def test_jschema(validator, file_path):
    test_file = open(file_path, "r")
    test_pattern = yaml.load(test_file.read())

    if not validator.is_valid(test_pattern):
        es = validator.iter_errors(test_pattern)
        for e in es:
            warnings.warn(str(e))
            return False
    else:
        return True

if __name__ == "__main__":
    main()
