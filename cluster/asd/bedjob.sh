#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 4
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge
module load BEDTools
module load TABIX

bedtools intersect -a /project/devel/imaceda/1kgen/ALL.1kg.phase3_snps_biallelic_poly.vcf.gz -b adj_or_freq_iPSYCH_PGC_ASD_Nov2017_parsed.chimp.woMD.txt.gz -wa | cut -f 1,2,3,8 | bgzip > freq_asd.gz

