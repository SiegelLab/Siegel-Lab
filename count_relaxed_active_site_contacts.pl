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


my $orig_dir = "/home/mlnance/contact/crystal/relax_main_chain";
my $activesite_dir = "/home/mlnance/contact/crystal/activesite_relaxed";
my $results_dir = "/home/mlnance/contact/crystal/contact_results";
my $orig_pdb_dir = "/home/mlnance/contact/crystal/relax_main_chain/output_relax";
my $cutoff_active_site = 5;
my $type_of_pdb = "relaxed";
my $usage_string="Hey, I noticed you didn't give me the right files \n   Give me list of pdb files  \n";
ArgCheck::check2(1,$#ARGV+1,$usage_string);

# Write contact_results text file and num_lig results text file (data added to it from ContactCounter
my $pdb_list_ref = ReadList::read ( $ARGV[0] );

chdir($results_dir);
my $backbone_results_name = "results_backbone_relaxed.txt";
my $bb_comment = ("pdbname pp pn np nn\n");
WriteList::write_s($backbone_results_name,$results_dir,$bb_comment);
my $sidechain_results_name = "results_sidechain_relaxed.txt";
my $sc_comment = ("pdbname pp pn np nn\n");
WriteList::write_s($sidechain_results_name,$results_dir,$sc_comment);
my $results_name = "results_relaxed.txt";
my $comment = "pdbname pp pn np nn\n";
WriteList::write_s($results_name,$results_dir,$comment);
my $num_lig_file = "results_num_lig_relaxed.txt";
my $lig_comment = "pdbname  num_lig_atms\n";
WriteList::write_s($num_lig_file,$results_dir,$lig_comment);
my $backbone_results_norm_name = "results_backbone_normalized_relaxed.txt";
my $bb_norm_comment = ("pdbname pp pn np nn\n");
WriteList::write_s( $backbone_results_norm_name, $results_dir, $bb_norm_comment );
my $sidechain_results_norm_name = "results_sidechain_normalized_relaxed.txt";
my $sc_norm_comment = ("pdbname pp pn np nn\n");
WriteList::write_s( $sidechain_results_norm_name, $results_dir, $sc_norm_comment );

chdir($orig_dir);

foreach my $pdb_name (@$pdb_list_ref){
    chomp $pdb_name;
    my @split_name = split(/\_/,$pdb_name);
    chdir($activesite_dir);
    mkdir($split_name[0]);
    chdir($split_name[0]);
    my $working_dir = $activesite_dir ."/". $split_name[0];
    my $pdb_dir = $orig_pdb_dir . "/" . $split_name[0];
    my $activesite_dir = $working_dir . "/activesites_relax";
    print "\nMy current directory is $working_dir \n";
    print RED "\nWorking on $pdb_name \n",RESET;
    print "Extracting the Active Site \n";
    my $active_site_array_ref = ExtractActiveSite::getactivesite_crystal( $pdb_dir, $pdb_name, $cutoff_active_site, $orig_dir, $type_of_pdb, $num_lig_file );
    my $active_site_length = scalar @$active_site_array_ref;
    WriteList::write( "activesite_relaxed_$split_name[0]",$working_dir,$active_site_array_ref );
    print BLUE "\nThe length of my active site is $active_site_length \n\n\n\n\n\n",RESET;
    chdir($orig_dir);
    
}
