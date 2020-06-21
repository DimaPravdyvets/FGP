#!/bin/bash


for file in mdd_rsid.0*; do 
	echo $file;
	Rscript /home/devel/imaceda/get_snp_info.R $file Hg19; 
	cat mdd_rsid.bed >> mdd_rsid_total.txt; 
done 
