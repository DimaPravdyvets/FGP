import pandas as pd
import matplotlib
pd_alc = pd.read_csv("adj_or_freq_adhd_eur_jun2017_parsed.chimp.woMD.txt.gz", sep= "\t")

pd_alc['FREQ'].value_counts().plot(kind='bar',
                                    figsize=(20,12),
                                    title="MAF plot")
