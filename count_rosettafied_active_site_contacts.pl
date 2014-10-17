#!/usr/bin/perl                                                                # usage is ./polar_polar_active <list of pdb files>                            

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

my $orig_dir = "/home/mlnance/contact/crystal";
my $activesite_dir = "/home/mlnance/contact/crystal/activesite_rosettafied";
my $results_dir = "/home/mlnance/contact/crystal/contact_results";
my $pdb_dir = "/home/mlnance/contact/crystal/rosettafied_structures";
my $cutoff_active_site = 5;
my $usage_string="Hey, I noticed you didn't give me the right files \n   Give me list of pdb files  \n";
ArgCheck::check2(1,$#ARGV+1,$usage_string);

my $pdb_list_ref = ReadList::read ( $ARGV[0] );
chdir($results_dir);
my $comment = "pdbname  rosettafied_pp  rosettafied_pn  rosettafied_np  rosettafied_nn\n";
WriteList::write_s("results_rosettafied.txt",$results_dir,$comment);
chdir($orig_dir);

foreach my $pdb_name_upper (@$pdb_list_ref){
    chomp $pdb_name_upper;
    my $pdb_name = lc($pdb_name_upper);
    my @split_name = split(/_/,$pdb_name);
    chdir($activesite_dir);
    mkdir($split_name[0]);
    chdir($split_name[0]);
    my $working_dir = $orig_dir ."/". $split_name[0];
    print "\nMy current directory is $working_dir \n";
    print RED "\nWorking on $pdb_name \n",RESET;
    print "Extracting the Active Site \n";
    my $active_site_array_ref = ExtractActiveSite::getactivesite_crystal( $pdb_dir,$pdb_name, $cutoff_active_site, $orig_dir );
    my $active_site_length = scalar @$active_site_array_ref;
    WriteList::write( "activesite_rosettafied_$split_name[0]",$activesite_dir,$active_site_array_ref );
    print BLUE "\nThe length of my active site is $active_site_length \n\n\n\n\\n\n",RESET;
    chdir($orig_dir);
    
}


