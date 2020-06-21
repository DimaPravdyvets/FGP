#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 6
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge
 
module load gcc/7.3.0
module load PYTHON/3.6.3 
python3 add_pval.py euro_freq_adhd.gz adhd_eur_jun2017.txt.gz adj_beta_freq_adhd_eur_jun2017_parsed.chimp.woMD.txt.gz 