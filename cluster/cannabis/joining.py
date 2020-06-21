import sys
import re
file_out = open("merged_rsid.txt","w+")
h="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tCOSA\n"
file_out.write(h)
dic={}
file1=sys.argv[1]
file2=sys.argv[2]
with open(file1) as f:
    for line in f:
        if re.search("rs",line):
            dic[line.split()[2]]=(line.split()[0],line.split()[1])
f.close()
with open(file2) as f1:
    for line in f1:
        l=line.split()
        if l[1] in dic:
            s=str(dic[l[1]][0]+"\t"+dic[l[1]][1]+"\t"+l[1]+"\t"+l[2]+"\t"+l[3]+"\t"+l[4]+"\t"+l[5]+"\t"+l[6]+"\t"+l[7]+"\t"+l[8]+"\n")
            file_out.write(s)
f1.close()
file_out.close()
