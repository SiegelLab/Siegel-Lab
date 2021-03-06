__author__ = 'stevebertolani'

#import pandas as pd
from pandas import DataFrame
from pandas import read_csv
from os import path
from re import findall

file = "score.sc"

class ScoreFile(DataFrame):
    def __init__(self, *args, **kwargs):
        DataFrame.__init__(self, *args, **kwargs)

    def check_for_cst_energies(self):
        print 'Checking all the indices for the word "constraint" '
        self.list_of_score_terms = list(self.columns.values)
        self.constraint_terms_found = list()
        for i in self.list_of_score_terms:
            if (findall("constraint",i)):
                if (i.split("_")[0] != "if"):
                    self.constraint_terms_found.append(i)

        print "Found the following terms %s " %self.constraint_terms_found
        print "Creating a new column called total_score_no_csts "

        #start the new column with the total score, then subtract off the cst column values
        self["total_score_no_csts"]=self["total_score"]
        for i in self.constraint_terms_found:
            self["total_score_no_csts"] -= self[i]

def test():
    data = read_csv(file,delim_whitespace=True,header=1)
    sf2 = ScoreFile(data)

    print "Created a scorefile class "

    sf2.check_for_cst_energies()
    print sf2
test()