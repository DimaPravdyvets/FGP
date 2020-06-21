#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 4
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge

module load gcc/6.3.0 mkl/12.1.6 PYTHON/3.6.0

python add_allinfo.py AUDIT_UKB_2018_AJP_allids.txt.gz AUDIT_UKB_2018_AJP.txt.gz
gzip merged_allINFO.txt

