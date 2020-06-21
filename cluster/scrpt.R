setwd("/scratch/devel/dpravdyvets/gwas_datasets/selected_disorders")

adhd<-read.table(gzfile("adhd/verificalo_antes_no_como_siempre.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
asd<-read.table(gzfile("asd/adj_beta_freq_iPSYCH_PGC_ASD_Nov2017_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
bip<-read.table(gzfile("bip/adj_beta_freq_daner_PGC_BIP32b_mds7a_0416a_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
ed<-read.table(gzfile("ed/adj_beta_freq_AN2_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
mdd<-read.table(gzfile("mdd/adj_beta_freq_PGC_UKB_depression_genome-wide_parsed_pos_and_chr.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
scz<-read.table(gzfile("scz/adj_beta_freq_daner_natgen_pgc_eur_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
ocd<-read.table(gzfile("ocd/adj_or_freq_ocd_aug2017_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
alch<-read.table(gzfile("sud/adj_BETA_AUDIT_UKB_2018_AJP_allids_allinfo_noXYMT.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
cannabis<-read.table(gzfile("sud/adj_beta_freq_Cannabis_ICC_23andmetop_UKB_het_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)

options(scipen = 999)
pd=list(adhd,asd,bip,ed,mdd,scz,ocd,alch,cannabis)



for(d in pd){
  barplot(d$FREQ)
  title(d)
}




for(d in pd){
  colnames(d)[which(names(d) == "INFO")] <- "FREQ"
  colnames(d)[which(names(d) == "X1")] <- "FREQ"
  colnames(d)[which(names(d) == "P")] <- "PVAL"
}
pd=list(adhd,asd,bip,mdd,scz,ed,ocd,cannabis)

for(d in pd){
  colnames(d)[which(names(d) == "P")] <- "PVAL"
  good_p<-d$PVAL<0.001
  colnames(d)[which(names(d) == "INFO")] <- "FREQ"
  colnames(d)[which(names(d) == "X1")] <- "FREQ"
  
  #bin 0.1
  d$FREQ[d$FREQ==1]<-0.99999
  d$FREQ[d$FREQ==0]<-0.00001
}
  # print(max(d$FREQ))
  # print(min(d$FREQ))
  #for(i in d$FREQ){
  #  if(i==1){
  #   i=0.9999
  # }
  #}
for(d in pd){
  d$F_BIN<-as.double(substr(d$FREQ,0,4))
  barplot(d$F_BIN)
}

# for alch's pvals
good_pt<-alch$p_T<0.0000001
good_pc<-alch$p_C<0.0000001
good_pp<-alch$p_P<0.0000001

colnames(alch)[which(names(alch) == "INFO")] <- "FREQ"

#bin 0.1
alch$FREQ[alch$FREQ==1]<-0.99999
alch$FREQ[alch$FREQ==0]<-0.00001
alch$F_BIN<-as.double(substr(alch$FREQ,0,3))
par(mfrow=c(1,1))

for( val in sort(unique(alch$F_BIN))){
  print(paste(val,sum(alch$F_BIN[good_pc]==val),sep=":"))
  
}
print("------------------")

for( val in sort(unique(alch$F_BIN))){
  print(paste(val,sum(alch$F_BIN[good_pp]==val),sep=":"))
  
  
}
print("------------------")
for( val in sort(unique(alch$F_BIN))){
  #print(paste(val,sum(alch$F_BIN[good_pt]==val),sep=":"))
  png(filename="alch_T.png")
  boxplot(as.factor(alch$F_BIN),alch$beta_T)
  dev.off()  
}
print("------------------")

