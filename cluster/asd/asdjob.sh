#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 4
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge

bash /project/devel/imaceda/chimpAXTs/add_chimp.sh iPSYCH_PGC_ASD_Nov2017_parsed.vcf 