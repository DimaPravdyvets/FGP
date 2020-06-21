import sys
import re
import gzip
file_out = open("N_adjus_OR_freq_daner_natgen_pgc_eur_parsed.chimp.woMD.txt","w")
h="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tFREQ\tOR\tSE\tPVAL\tFORMAT\tCOSA\tAncestral\n"
file_out.write(h)
dic={}
file1=sys.argv[1]
file2=sys.argv[2]
with gzip.open(file1,"rt") as f:
    for line in f:
        if re.search("rs",line):
            dic[line.split()[0]]=line.split()[1]
f.close()

with gzip.open(file2,"rt") as f1:
    for line in f1:
        if re.search("rs",line):
            l=line.split()
            if l[2] in dic:
                s=str(l[0]+"\t"+l[1]+"\t"+l[2]+"\t"+l[3]+"\t"+l[4]+"\t"+l[5]+"\t"+l[6]+"\t"+dic[l[2]]+"\t"+l[7]+"\t"+l[8]+"\t"+l[9]+"\t"+l[10]+"\t"+l[11]+"\t"+l[12]+"\t"+l[13]+"\n")
                file_out.write(s)
f1.close()
file_out.close()

