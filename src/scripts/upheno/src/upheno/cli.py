import logging

import click
import os
import sys
import datetime
from sssom.parsers import parse_sssom_table
from sssom.writers import write_table

from .upheno_utils import preprocess_patterns_for_matching as preprocess_patterns_for_matching_api


info_log = logging.getLogger("info")


@click.group()
@click.option("-v", "--verbose", count=True)
@click.option("-q", "--quiet")
def main(verbose: int, quiet: bool) -> None:
    """main CLI method for upheno

    Args:
        verbose (int): _description_
        quiet (bool): _description_
    """
    if verbose >= 2:
        info_log.setLevel(level=logging.DEBUG)
    elif verbose == 1:
        info_log.setLevel(level=logging.INFO)
    else:
        info_log.setLevel(level=logging.WARNING)
    if quiet:
        info_log.setLevel(level=logging.ERROR)

@click.group()
def upheno_utils():
    pass

@click.command()
@click.option("--upheno-id-map", "-i", metavar="UPHENO_ID_MAP", required=True, help="File describing the current UPHENO-ID assignments.")
@click.option("--upheno-derived-pattern-data-dir", "-d", metavar="UPHENO_DERIVED_PATTERN_DATA_DIR", required=True, help="Directory where derived pattern TSV files are stored.")
@click.option("--upheno-manual-pattern-data-dir", "-x", metavar="UPHENO_MANUAL_PATTERN_DATA_DIR", required=True, help="Directory where manually curated pattern TSV files are stored.")
@click.option("--upheno-template", "-t", metavar="UPHENO_TEMPLATE", required=True, help="The location of the uPheno template which contains the manually constructed phenotype intermediate classes.")
@click.option("--cross-species-mappings", "-s", metavar="CROSS_SPECIES_MAPPINGS", required=True, help="These are the known cross-species mappings which are used to determine grouping classes")
@click.option("--upheno-mappings-manual", "-m", metavar="UPHENO_MANUAL_MAPPINGS", required=True, help="These are the manually curated mappings between species-specific phenotype ontologies and uPheno")
@click.option("--upheno-mappings-lexical", "-l", metavar="UPHENO_LEXICAL_MAPPINGS", required=True, help="These are the manually curated mappings between species-specific phenotype ontologies and uPheno")
@click.option("--upheno-mappings-final", "-f", metavar="UPHENO_MAPPINGS", required=True, help="The location of the final uPheno mappings")
@click.option("--tmpdir", "-tmp", metavar="TMPDIR", required=False, help="Tmp dir")
@click.option("--config", "-c", metavar="CONFIG", required=False, help="Config file")
def prepare_intermediate_layer(upheno_pattern_data_dir, cross_species_mappings, upheno_mappings_manual, upheno_mappings_lexical, upheno_mappings_final, tmpdir, config) -> None:
    """This method generates the uPheno intermediate layer
    """
    pass

@click.command()
@click.option("--input", "-i", metavar="INPUT", required=True, help="The location of the SSSOM mapping which should be flipped.")
@click.option("--output", "-o", metavar="OUTPUT", required=True, help="The location of the SSSOM ")
@click.option("--flip", "-f", metavar="FLIP", required=True, default=False, help="The location of the uPheno template which contains the manually constructed phenotype intermediate classes.")
def sssom_to_two_column(input, output, flip) -> None:
    """Prepare the patterns for matching. This may involve steps like changing the fillers of certain terms to owl:Thing.
    """
    msdf = parse_sssom_table(input)
    mapping_columns = ['subject_id','object_id']
    if flip:
        mapping_columns = ['object_id','subject_id']
    df = msdf.df[mapping_columns]
    df.to_csv(output, sep = "\t")

@click.command()
@click.option("--input", "-i", metavar="INPUT", required=True, help="The location of the SSSOM mapping which should be altered.")
@click.option("--output", "-o", metavar="OUTPUT", required=True, help="The location where the altered SSSOM file should be safed.", type=click.File(mode="w"), default=sys.stdout)
@click.option("--predicate", "-p", metavar="PREDICATE", required=True, help="The predicate to use")
def sssom_change_predicate(input, output, predicate) -> None:
    """Prepare the patterns for matching. This may involve steps like changing the fillers of certain terms to owl:Thing.
    """
    msdf = parse_sssom_table(input)
    msdf.df['predicate_id'] = predicate
    write_table(msdf, output)

@click.command()
@click.option("--pattern-dir", "-d", metavar="PATTERN_DIR", required=True, help="The location of the uPheno template which contains the manually constructed phenotype intermediate classes.")
@click.option("--pattern-dir-preprocessed", "-p", metavar="PATTERN_DIR", required=True, help="The location of the uPheno template which contains the manually constructed phenotype intermediate classes.")
@click.option("--match-owl-entity", "-m", metavar="MATCH_OWL_ENTITY", required=False, default=True, help="The location that summarises the outcome of the matching process.")
@click.option("--report", "-r", metavar="REPORT", required=False, help="The location that summarises the outcome of the matching process.")
def preprocess_patterns_for_matching(pattern_dir, pattern_dir_preprocessed, match_owl_entity, report) -> None:
    """Prepare the patterns for matching. This may involve steps like changing the fillers of certain terms to owl:Thing.
    """
    preprocess_patterns_for_matching_api(pattern_dir, pattern_dir_preprocessed, match_owl_entity)
    report_text = f"All patterns were preprocessed with in {pattern_dir_preprocessed} on the {datetime.date}"
    if report:
        upheno_utils.report(report_text, report)

@click.command()
@click.option("--ontology", "-o", metavar="ONTOLOGY", required=True, help="Ontology to match match against.")
@click.option("--pattern-data-dir", "-d", metavar="PATTERN_DATA_DIR", required=True, help="Directory where matched TSV files are to be stored.")
@click.option("--pattern-dir", "-p", metavar="PATTERN_DIR", required=True, help="The location of the uPheno template which contains the manually constructed phenotype intermediate classes.")
@click.option("--report", "-r", metavar="REPORT", required=True, help="The location that summarises the outcome of the matching process.")
def match_ontology(ontology, pattern_data_dir, pattern_dir, report) -> None:
    """This method generates the uPheno intermediate layer
    """
    
    prepare_for_matching()
    print("### Matching phenotype ontologies against uPheno patterns ###")
    #match_patterns(upheno_config,pattern_files, matches_dir, pattern_dir, upheno_config.is_overwrite_matches())


upheno_utils.add_command(preprocess_patterns_for_matching)
upheno_utils.add_command(prepare_intermediate_layer)
upheno_utils.add_command(sssom_to_two_column)
upheno_utils.add_command(sssom_change_predicate)

if __name__ == "__main__":
    main()
