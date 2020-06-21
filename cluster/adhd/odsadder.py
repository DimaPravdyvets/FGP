import sys
import re
import gzip
from math import *
file_out = open("new.txt","w")
h="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tFREQ\tBETA\tSE\tPVAL\tFORMAT\tCOSA\tAncestral\n"
file_out.write(h)
dic={}
file1=sys.argv[1]
file2=sys.argv[2]
with gzip.open(file1,"rt") as f:
    for line in f:
        if re.search("rs",line):
            dic[line.split()[1]]=line.split()[6]
f.close()

with gzip.open(file2,"rt") as f1:
    for line in f1:
        if re.search("rs",line):
            l=line.split()
            if l[2] in dic:
                if l[13]=="0/0":
                    s=str(l[0]+"\t"+l[1]+"\t"+l[2]+"\t"+l[3]+"\t"+l[4]+"\t"+l[5]+"\t"+l[6]+"\t"+str(log(1.0/float(dic[l[2]])))+"\t"+l[8]+"\t"+l[9]+"\t"+l[10]+"\t"+l[11]+"\t"+l[12]+"\t"+l[13]+"\n")
                    file_out.write(s)
                else:
                    s=str(l[0]+"\t"+l[1]+"\t"+l[2]+"\t"+l[3]+"\t"+l[4]+"\t"+l[5]+"\t"+l[6]+"\t"+str(log(float(dic[l[2]])))+"\t"+l[8]+"\t"+l[9]+"\t"+l[10]+"\t"+l[11]+"\t"+l[12]+"\t"+l[13]+"\n")
                    file_out.write(s)
f1.close()
file_out.close()

