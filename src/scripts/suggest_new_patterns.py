#! /usr/bin/env python3
# -*- coding: utf-8 -*-
""" Return a table with rows from one aggregate table where the key value does not occur in the second aggregate table. Each set of table files must be under a single branch of a directory tree. The expected file format for the data is tab delimited text (tsv). The column with the keys must have a header with the same name in both files. """

__author__ = "Ray Stefancsik"
__version__ = "0.1"

######################################################################
# Import command-line parsing module from the Python standard library.
import argparse

### these are needed to navigate local file system
import os

# Import PETL, a general purpose Python package for extracting, transforming and loading tables of data.
import petl

######################################################################

parser = argparse.ArgumentParser(
    description=" Return a table with rows from one aggregate table where the key value does not occur in the second aggregate table.\nEach set of table files must be under a single branch of a directory tree.\nThe expected file format for the data is tab delimited text (tsv).\tThe column with the keys must have a header with the same name in both files.",
    formatter_class=argparse.RawTextHelpFormatter,
)

# Mandatory positional argument(s).
# parser.add_argument( 'outfile', help='Path to a directory for the results.' )
# parser.add_argument( 'generic_matches', help='Path to the directory of your first set of tsv input files. Default=./generic_matches' )
# parser.add_argument( 'table2', help='Path to the directory of your second set of tsv input files. Default=./upheno_matches' )

### Optional arguments:
parser.add_argument(
    "-o",
    "--outfile",
    help="Path to output tsv file to (over)write.",
    nargs="?",
    default=None,
    const=None,
)  # you need both the default and const for different scenarios (1. no flag and no user input, 2. flag only without any other user input, 3. flag plus user input. see https://docs.python.org/3/library/argparse.html
parser.add_argument(
    "-g",
    "--generic_matches",
    help="Path to the directory of your first set of tsv input files.\nDefault=pattern-matches/generic_matches",
    nargs="?",
    default="pattern-matches/generic_matches",
    const="pattern-matches/generic_matches",
)  # if not specified by the user then it defaults to given value
parser.add_argument(
    "-u",
    "--upheno_matches",
    help="Path to the directory of your second set of tsv input files.\nDefault=pattern-matches/upheno_matches",
    nargs="?",
    default="pattern-matches/upheno_matches",
    const="pattern-matches/upheno_matches",
)  # if not specified by the user then it defaults to given value
parser.add_argument(
    "-k",
    "--keys",
    help='Header of column with the key values, e.g "defined_class".',
    nargs="?",
    default="defined_class",
    const="defined_class",
)  # if not specified by the user then it defaults to given value

# pars user input
args = parser.parse_args()

############################################
### create a generic_matches aggregate table
############################################
g_matches = petl.cat([[]])  # initialise an empty table
# c = 1 # initialise a counter

for root, dirs, files in os.walk(args.generic_matches):
    for f in files:
        if f.endswith(".tsv"):
            path2tsv = "/".join(
                [".", root, f]
            )  # relative path to tsv file relative to the location of this script
            # print(path2tsv) # this is just for testing
            table1 = petl.fromtsv(path2tsv)
            g_matches = petl.cat(g_matches, table1)  # append rows from the current table
        # c = c + 1 # increment counter

g_matches = petl.distinct(g_matches)  # de-duplicate table
###############################################
### create a upheno_matches aggregate table
### the rows come from already defined patterns
###############################################
u_matches = petl.cat([[]])  # initialise an empty table
# u_matches = [[]] # initialise an empty table
# c = 1 # initialise a counter
tsv_list_u = []
for root, dirs, files in os.walk(args.upheno_matches):
    for f in files:
        if f.endswith(".tsv"):
            path2tsv = "/".join(
                [".", root, f]
            )  # relative path to tsv file relative to the location of this script
            # print(path2tsv) # this is just for testing
            table1 = petl.fromtsv(path2tsv).cut(args.keys)
            u_matches = petl.cat(
                u_matches, table1
            )  # append rows from the current table to u_matches
        # c = c + 1

u_matches = petl.distinct(u_matches)  # de-duplicate table

##########################################
#### do the join of tables
# The GOAL is to get a table with
# generic_patterns *minus* upheno_patterns
##########################################
new_patterns = petl.antijoin(
    g_matches, u_matches, key=args.keys
)  # Return rows from the left table where the *key value* does not occur in the right table.
if args.outfile == None:
    print(new_patterns.lookall(style="minimal"))  # style options: grid, simple, minimal
    ### additional information
    print("general_matches:", len(list(petl.data(g_matches))))  # g_matches.tail())
    print("upheno_matches:", len(list(petl.data(u_matches))))  # u_matches.tail())
    print(
        "Found", len(list(petl.data(new_patterns))), "new pattern candidates."
    )  # style options: grid, simple, minimal
else:  # this is the case when an outfile has been specified by the user
    print(new_patterns.teetsv(args.outfile).lookall(style="minimal"))

##################### THE END #####################
