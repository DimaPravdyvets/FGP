import sys
import re
import gzip
from math import *
file_out = open("verificalo_antes_no_como_siempre.txt","w")
h="#CHROM\tPOS\tID\tREF\tALT\tFREQ\tBETA\tSE\tPVAL\tAncestral\n"
file_out.write(h)

dic_freq={}
file1=sys.argv[1] #freq
file2=sys.argv[2] #or,pval,se
file3=sys.argv[3] #outfile
with gzip.open(file1,"rt") as f:
    for line in f:
        if re.search("rs",line):
            dic_freq[line.split()[0]]=[line.split()[1]]
f.close()


with gzip.open(file2,"rt") as f0:
    for line in f0:
        if re.search("rs",line):
            l=line.split()
            if l[1] in dic_freq:
                dic_freq[l[1]].append(l[6])
                dic_freq[l[1]].append(l[7])
                dic_freq[l[1]].append(l[8])
f0.close()


with gzip.open(file3,"rt") as f1:
    for line in f1:
        if re.search("rs",line):
            l=line.split()
            if l[2] in dic_freq:
               	if l[13]=="0/0":
                    s=str(l[0]+"\t"+l[1]+"\t"+l[2]+"\t"+l[3]+"\t"+l[4]+"\t"+str(dic_freq[l[2]][0])+"\t"+str(log(1.0/float(dic_freq[l[2]][1])))+"\t"+str(dic_freq[l[2]][2])+"\t"+str(dic_freq[l[2]][3])+"\t"+l[13]+"\n")
                    file_out.write(s)
                else:
                    s=str(l[0]+"\t"+l[1]+"\t"+l[2]+"\t"+l[3]+"\t"+l[4]+"\t"+str(dic_freq[l[2]][0])+"\t"+str(log(float(dic_freq[l[2]][1])))+"\t"+str(dic_freq[l[2]][2])+"\t"+str(dic_freq[l[2]][3])+"\t"+l[13]+"\n")
                    file_out.write(s)


f1.close()
file_out.close()

