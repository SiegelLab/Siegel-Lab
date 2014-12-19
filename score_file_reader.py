import pandas as pd

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
