

print("Starting to work now!")
setwd("/scratch/devel/dpravdyvets/gwas_datasets/selected_disorders")
adhd<-read.table(gzfile("adhd/verificalo_antes_no_como_siempre.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
asd<-read.table(gzfile("asd/adj_beta_freq_iPSYCH_PGC_ASD_Nov2017_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
bip<-read.table(gzfile("bip/adj_beta_freq_daner_PGC_BIP32b_mds7a_0416a_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
mdd<-read.table(gzfile("mdd/adj_beta_freq_PGC_UKB_depression_genome-wide_parsed_pos_and_chr.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
scz<-read.table(gzfile("scz/adj_beta_freq_daner_natgen_pgc_eur_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
ocd<-read.table(gzfile("ocd/adj_beta_freq_ocd_aug2017_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
cannabis<-read.table(gzfile("sud/adj_beta_freq_Cannabis_ICC_23andmetop_UKB_het_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)

options(scipen=999)
Sys.setenv("DISPLAY"=":0.0")
options(bitmapType='cairo')

pd=list(adhd,asd,bip,mdd,scz,cannabis,ocd)

names=list("adhd","asd","bip","mdd","scz","cannabis","ocd")

setwd("/scratch/devel/dpravdyvets/gwas_datasets/selected_disorders/new_plots")

print("datasets loaded")

library(ggplot2)

i<-1
for(d in pd){

print("checkpoint 1")

colnames(d)[which(names(d) == "INFO")] <- "FREQ"
colnames(d)[which(names(d) == "X1")] <- "FREQ"
colnames(d)[which(names(d) == "P")] <- "PVAL"
d$FREQ[d$FREQ==1]<-0.9999999999999
d$FREQ[d$FREQ==0]<-0.0000000000001

d$F_BIN<-as.double(substr(d$FREQ,0,3))
good_p<-d$PVAL<0.0000001

name=names[i]


print(paste("currently working on:",name))

p1<-ggplot(d[good_p,],aes(x=F_BIN,fill=Ancestral))+geom_bar(aes( y=..count../tapply(..count.., ..x.. ,sum)[..x..]), position="stack" ) +
  geom_text(aes( y=..count../tapply(..count.., ..x.. ,sum)[..x..], label=scales::percent(..count../tapply(..count.., ..x.. ,sum)[..x..]) ),
            stat="count", position=position_dodge(0.9), vjust=-0.5)+
  ylab('Percent of Cylinder Group, %') +
  scale_y_continuous(labels = scales::percent)+labs(title=name,x="DAF",y="Amount of SNPs ")
file_name1=paste(name,"_ancestral_goodP_3.png",sep="")
ggsave(plot = p1,filename=file_name1)




p1<-ggplot(d[good_p,],aes(x=F_BIN))+geom_bar(aes(fill=Ancestral, position="fill") +labs(title=name,x="DAF",y="Amount of SNPs ")
file_name1=paste(name,"_ancestral_goodP_4.png",sep="")
ggsave(plot = p1,filename=file_name1)

print("checkpoint 2")
i<-i+1
}
