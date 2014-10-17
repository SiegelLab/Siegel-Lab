#!/usr/bin/python
# usage is <list of pdb files>

import string
import sys
import os
import fileinput

orig_dir = os.getcwd()
working_dir = "/home/mlnance/Desktop/contact/crystal"
results_dir = os.path.join(working_dir, "contact_results")
cutoff_active_site = 10
comment = "pdbname  pp  pn  np  nn\n"


pdb_list = sys.argv[1]
with open(pdb_list,"r") as f:
    for pdb_name_upper in f:
        pdb_name_upper = pdb_name_upper.splitlines()
#        pdb_name_upper.strip("\n")
        print(pdb_name_upper)
#        pdb_name_lower = string.lower(pdb_name_upper)
#        pdb_name = pdb_name_lower.split(".")
#        print(pdb_name)
#        os.mkdir(pdb_name)
#        os.chdir(pdb_name)






########## stuff that didn't work but is useful ############
#for pdb_list in os.listdir(working_dir):
#    with open(os.path.join(working_dir, "pdb_list"),"r") as f:
#with open("pdb_list", "r") as myfile:
#    list_of_pdbs = myfile.readlines()
    

    
