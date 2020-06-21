import sys
import re
import gzip
#no beta first, original second
file_out = open("merged_allINFO.txt","w")
h="#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tCOSA\tbeta_T\tse_T\tp_T\tbeta_C\tse_C\tp_C\tbeta_P\tse_P\tp_P\n"
file_out.write(h)
dic={}
file1=sys.argv[1]
file2=sys.argv[2]



with gzip.open(file2,"rt") as f:
    for line in f:
        if re.search("rs",line):
            l1=line.split()
            dic[l1[1]]=l1[5:14]

f.close()
with gzip.open(file1,"rt") as f1:
    for line in f1:
        l2=line.split()
        if l2[2] in dic.keys():
            for i in dic[l2[2]]:
                l2.append(i)
            for word in l2:
                file_out.write(word + '\t')
        file_out.write('\n')
		#line_topr=line.rstrip()
            #line_topr=str(line.rstrip() + "\t" + str(dic[l2[1]]))
            #file_out.write(line_topr)
            #file_out.write("\n")
f1.close()
file_out.close()

