#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 4
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge

module load gcc/6.3.0 mkl/12.1.6 PYTHON/3.6.0
module load TABIX
python addd_freq.py euro_freq_bip.gz adj_or_freq_daner_PGC_BIP32b_mds7a_0416a_parsed.chimp.woMD.txt.gz



