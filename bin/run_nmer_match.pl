use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use lib "$FindBin::Bin/../local_lib/lib/perl5"; # install dependencies here
use Getopt::Long qw(GetOptions);
use NmerMatch qw(read_fasta build_catalog get_catalog_info read_query_file query_vs_catalog output_matching_peptides);
use Data::Dumper;

# actions:
#  1. run a search
#  2. build a catalog
# 
# run a search
# input: 
#   catalog name
#   nmer list
#
# build a catalog
# input:
#   catalog name
#   catalog fasta
#   peptide length

my $action;              # build or search
my $nmer_length;         # peptide length for the catalog
my $catalog_fasta;       # input fasta file to build the catalog
my $catalog_name;        # name of the catalog to build/use
                         # for now, this is a file, but it could be a reference
                         # to a schema in a database
my $query_input;         # fasta/list of peptides to search against the databse
my $max_mismatches;      # the maximum mismatches for a search
my $output_file;         # short version of output file with 1 row summarizing all
                         # matches for a given peptide
my $long_output_file;    # a longer version of the output, with 1 row per match

GetOptions ("action|a=s"         => \$action,
	        "nmer-length|l=i"    => \$nmer_length,
            "catalog-fasta|s=s"  => \$catalog_fasta,
            "catalog-name|c=s"   => \$catalog_name,
            "nmer-query|q=s"     => \$query_input,
            "max_mismatches|m=i" => \$max_mismatches,
            "output-file|o=s"    => \$output_file,
            "long-output-file|v=s" => \$long_output_file,
            );

if ($action eq 'build') {

	# read in the db fasta file
	print "Reading fasta: $catalog_fasta\n";
	my $catalog_seq_ref = read_fasta($catalog_fasta);

	# catalog the input sequences by unique nmer
	print "Cataloging sequences\n";
	build_catalog($nmer_length, $catalog_name);

}
elsif ($action eq 'search') {

	# read in the catalog info only
	# NOTE: this sets the 'CATALOG_NAME' global in the package, so no need to pass this
	# later on
	my $catalog_info = get_catalog_info($catalog_name);

	# read in the nmer query file (list format)
	# NOTE: this sets the 'QUERY_PEPTIDES' in the package, so no need to pass it
	#       to the next function call
	my $query_peptides_ref = read_query_file($query_input);

	# compare & output
	query_vs_catalog($max_mismatches);
	output_matching_peptides($output_file, $long_output_file);

}
else {
	die "Unknown action: $action";
}
