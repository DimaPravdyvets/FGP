#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 4
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge
module load gcc/4.9.3-gold
module load R/3.3.1
R < ocd_bar_box.R --no-save

