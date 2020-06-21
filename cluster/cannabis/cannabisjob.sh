#!/bin/bash

# @ error = %j.err
# @ output = %j.out
# @ total_tasks = 1
# @ cpus_per_task = 4
# @ wall_clock_limit = 24:00:00
# @ class = normal

module purge

bash /project/devel/imaceda/chimpAXTs/add_chimp.sh Cannabis_ICC_23andmetop_UKB_het_parsed_noNA.vcf.gz

cat header_line_alch > adjustedBETA_Cannabis_ICC_23andmetop_UKB_het_parsed.chimp.woMD.txt
zcat Cannabis_ICC_23andmetop_UKB_het_parsed.chimp.woMD.vcf.gz | tr "_" "\t" | awk '{
if($14 == "0/0") print ($1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"(-1*$9)"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14);
else print $0;
}' >> adjustedBETA_Cannabis_ICC_23andmetop_UKB_het_parsed.chimp.woMD.txt && gzip adjustedBETA_Cannabis_ICC_23andmetop_UKB_het_parsed.chimp.woMD.txt
