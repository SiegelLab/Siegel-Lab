#!/usr/bin/python

# program takes in one argument - a list of the pdb names in which the user wants to dock a ligand too
# python structural_alignment.py <pdb_list>

import sys
import os
import csv
direct=os.getcwd()
sys.path.append("%s/analysis" %direct)
sys.path.append("%s/ligand" %direct)
from tmalign import TmAlign
from ligand import LigandSetup
pdb_list = sys.argv[1]

#def test_tmalign():
#movable= "test/bgl_mut.pdb" #model, not ligand in it
#target= "test/bgl.pdb"   # template with ligand
#tm=TmAlign()
#tm.run(movable,target)    
#tm.read_fa_results_movable(movable)
#print "\n".join(tm.rotated_to_target)

def overlay_get_ligand( movable, target ):
    #    movable= "test/bgl_mut.pdb"
    #    target= "test/bgl.pdb"
    ligset=LigandSetup.LigandSetup(movable,target)
    ligset.superimpose()
    ligset.write_model_lig_out("test_out_rot_wlig")
def main():
    f = open(pdb_list)
    lines = f.readlines()
    for name in lines:
# get into the models directory of each pdb in the list
        os.chdir(direct + "/models/" + name)
        name_dir=os.getcwd()

# make a docking directory in each models directory and then save the path as a variable
        if os.path.isdir("docking"):
            os.chdir("docking")
            docking=os.getcwd()
            os.chdir(name_dir)
        else:
            os.mkdir("docking")
            os.chdir("docking")
            docking=os.getcwd()
            os.chdir(name_dir)

# change into model directory in order to find the lowest score file
        os.chdir("model")
        model_dir = os.getcwd()

# search through score file in order to find lowest energy model
import pandas as pd
import os

def remove_sequence_from_scorefile(scorefile_with_path):
    import re
    with open(scorefile_with_path,'r') as fh:
        lines = fh.read().splitlines()
        if (re.search(r'SEQUENCE',lines[0])  ):
            print "First line starts with sequence, removing..."
            df = pd.read_csv(scorefile_with_path,delim_whitespace=True,header=1)
        
        else:
            print "Doesn't start with \"SEQUENCE\" " 
            df = pd.read_csv(scorefile_with_path,delim_whitespace=True,header=0)
    return df

def get_lowE_tag_from_scorefile():
    dir=os.getcwd()
    df = remove_sequence_from_scorefile("%s/score.sc" %dir)
    adj_score = pd.DataFrame(df['total_score'] -  df['atom_pair_constraint'])
    df['adj_score'] = adj_score
    df = df.sort(columns='adj_score')
    lowE = df['description'].head(1).values
    return lowE 
        

lowE = model_dir + '/' + "S_0012.pdb"
        
# clean up the pdb name so that we can open the original pdb file
        split_name = name.split('_', 1)
        template = model_dir + '/' + split_name[0]+'_'+split_name[0]+'.pdb'

# change into docking directory in order to run the ligand function
#        os.chdir(docking)
#        overlay_get_ligand( lowE, template )
        os.chdir(direct)
            
#test_tmalign()                                                                                                                   
#test_tag_parse() 

main()
