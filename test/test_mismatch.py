#!/usr/bin/env python3

import unittest
import os

import pandas as pd
import pandas.testing as pdt

from pepmatch import Preprocessor, Matcher
  
class TestMismatch(unittest.TestCase):
  def test_mismatch(self):

    # paths
    test_script_dir = os.path.dirname(os.path.realpath(__file__))
    proteome_fasta = os.path.join(test_script_dir, '../benchmarking/proteomes/human.fasta')
    query_fasta = os.path.join(test_script_dir, '../benchmarking/queries/neoepitopes_test.fasta')
    expected_csv = os.path.join(test_script_dir, '../benchmarking/expected/neoepitopes_expected.csv')

    # preprocess human proteome
    Preprocessor(proteome_fasta).pickle_proteome(3)

    # match neoepitopes to human proteome
    df = Matcher(
      query=query_fasta,
      proteome_file=proteome_fasta,
      max_mismatches=3,
      k=3,
      output_format='dataframe').match()

    # remove preprocessed files
    os.remove('human_3mers.pickle')
    os.remove('human_metadata.pickle')

    # load the expected data
    expected_df = pd.read_csv(expected_csv)

    # select only the necessary columns to test for
    df = df[['Query Sequence', 'Matched Sequence', 'Protein ID', 'Index start']]
    expected_df = expected_df[['Query Sequence', 'Matched Sequence', 'Protein ID', 'Index start']]

    # sort dataframes by Query Sequence and Protein ID
    df = df.sort_values(by=['Query Sequence', 'Protein ID']).reset_index(drop=True)
    expected_df = expected_df.sort_values(by=['Query Sequence', 'Protein ID']).reset_index(drop=True)

    # assert dataframes are equal
    pdt.assert_frame_equal(df, expected_df, check_dtype=False, check_exact=True)

if __name__ == '__main__':
  unittest.main()