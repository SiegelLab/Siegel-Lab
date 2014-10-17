#!/usr/bin/perl
# usage is ./polar_polar_active <list of pdb files>

use strict;
use warnings;    #always include these 3 use lines !!!
use Cwd;
use lib '/home/mlnance/github/perl_lib';
use Rosetta::UTIL::ArgCheck;
use List::MoreUtils qw/ uniq /;
use Rosetta::DATA::ParseXYZ;
use Rosetta::META::ReadList;
use Rosetta::META::CalcDistance;
use Rosetta::META::PDBClean;
use Term::ANSIColor qw(:constants);
use Rosetta::META::ExtractActiveSite;
use Rosetta::META::WriteList; #modgy-modg!!


my $orig_dir = getcwd;
my $cutoff_active_site = 10;
my $usage_string="Hey, I noticed you didn't give me the right files \n   Give me list of pdb files  \n";
ArgCheck::check2(1,$#ARGV+1,$usage_string);

my $pdb_list_ref = ReadList::read ( $ARGV[0] );
my $results_dir = "../contact_results";
#my $results_dir = $orig_dir . "/contact_results";
chdir($results_dir);
my $comment = "pdbname  relaxed_pp  relaxed_pn  relaxed_np  relaxed_nn\n";
#my $comment = "pdbname  pp  pn  np  nn\n";
my $results_name = "results_" . $ARGV[0]  . ".txt";
WriteList::write_s($results_name,$results_dir,$comment);
chdir($orig_dir);

foreach my $pdb_name_upper (@$pdb_list_ref){
    chomp $pdb_name_upper;
    my $pdb_name = $pdb_name_upper;
#    my $pdb_name = lc($pdb_name_upper);
    my @split_name = split(/\_/,$pdb_name);
#    my @split_name = split(/\./,$pdb_name);
    mkdir($split_name[0]);
    chdir($split_name[0]);
    my $working_dir = $orig_dir ."/". $split_name[0];
## for relaxed structures
    my $all_pdb_dir = $orig_dir ."/output_relax";
    my $pdb_dir = $all_pdb_dir . "/" . $split_name[0];
    my $activesite_dir = $working_dir . "/activesites_relax";
## original method
#    my $pdb_dir = $orig_dir ."/output_relax";    
#    my $pdb_dir = $orig_dir ."/main_chain_pdbs";
    print "\nMy current directory is $working_dir \n";
    print RED "\nWorking on $pdb_name \n",RESET;
    print "Extracting the Active Site \n";
    my $active_site_array_ref = ExtractActiveSite::getactivesite_crystal( $pdb_dir, $pdb_name, $cutoff_active_site, $orig_dir );
    my $active_site_length = scalar @$active_site_array_ref;
    WriteList::write( "activesite_$split_name[0]",$working_dir,$active_site_array_ref );
#    WriteList::write( "activesite_$pdb_name",$working_dir,$active_site_array_ref );
    print BLUE "\nThe length of my active site is $active_site_length \n\n\n\n\n\n",RESET;
    chdir($orig_dir);
    
}
