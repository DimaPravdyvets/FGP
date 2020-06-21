print("Starting to work now!")
setwd("/scratch/devel/dpravdyvets/gwas_datasets/selected_disorders")
adhd<-read.table(gzfile("adhd/verificalo_antes_no_como_siempre.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
asd<-read.table(gzfile("asd/adj_beta_freq_iPSYCH_PGC_ASD_Nov2017_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
ocd<-read.table(gzfile("ocd/adj_beta_freq_ocd_aug2017_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)
bip<-read.table(gzfile("bip/adj_beta_freq_daner_PGC_BIP32b_mds7a_0416a_parsed.chimp.woMD.txt.gz"),header= TRUE,comment.char = "?",row.names = NULL)

options(scipen=999)
Sys.setenv("DISPLAY"=":0.0")
options(bitmapType='cairo')

pd=list(adhd,asd,ocd,bip)

names=list("adhd","asd","ocd","bip")

setwd("/scratch/devel/dpravdyvets/gwas_datasets/selected_disorders/plots/10em6")

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
good_p<-d$PVAL<0.00001

name=names[i]


print(paste("currently working on:",name))


p1<-ggplot(d[good_p,],aes(x=F_BIN,fill=Ancestral))+geom_bar()+geom_text(stat='count', aes(label=..count..), position ="stack",color="black")+
 labs(title=name,x="DAF",y="Amount of SNPs ")
file_name1=paste(name,"_ancestral_goodP.png",sep="")
ggsave(plot = p1,filename=file_name1)


p2<-ggplot(d[good_p,],aes(x=F_BIN))+geom_bar(fill="darkturquoise")+geom_text(stat='count', aes(label=..count..), position ="stack",color="black") +
 labs(title=name,x="DAF",y="Amount of SNPs ")
file_name2=paste(name,"_total_goodP.png",sep="")
ggsave(plot = p2,filename=file_name2)



p3<-ggplot(d,aes(x=F_BIN,fill=Ancestral))+geom_bar()+geom_text(stat='count', aes(label=..count..), position ="stack",color="black")+
 labs(title=name,x="DAF",y="Amount of SNPs ")
file_name3=paste(name,"_ancestral_global.png",sep="")
ggsave(plot = p3,filename=file_name3)


p4<-ggplot(d,aes(x=F_BIN))+geom_bar(fill="forestgreen")+geom_text(stat='count', aes(label=..count..), position ="stack",color="black") +
 labs(title=name,x="DAF",y="Amount of SNPs ")
file_name4=paste(name,"_total_global.png",sep="")
ggsave(plot = p4,filename=file_name4)


p5<-ggplot(d[good_p,], aes(x=as.factor(F_BIN), y=BETA,fill=Ancestral))+geom_boxplot()+
 labs(title=name,x="DAF",y="BETA")
file_name5=paste(name,"_ancestral_goodP_BETA.png",sep="")
ggsave(plot = p5,filename=file_name5)


p6<-ggplot(d[good_p,], aes(x=as.factor(F_BIN), y=BETA))+geom_boxplot(fill="darkturquoise") +
 labs(title=name,x="DAF",y="BETA")+ylab("BETA")+xlab("DAF")
file_name6=paste(name,"_total_goodP_BETA.png",sep="")
ggsave(plot = p6,filename=file_name6)



p7<-ggplot(d, aes(x=as.factor(F_BIN), y=BETA,fill=Ancestral))+geom_boxplot()+
 labs(title=name,x="DAF",y="BETA")
file_name7=paste(name,"_ancestral_global_BETA.png",sep="")
ggsave(plot = p7,filename=file_name7)


p8<-ggplot(d, aes(x=as.factor(F_BIN), y=BETA))+geom_boxplot(fill="forestgreen") +
 labs(title=name,x="DAF",y="BETA")
file_name8=paste(name,"_total_global_BETA.png",sep="")
ggsave(plot = p8,filename=file_name8)

print("checkpoint 2")
i<-i+1
}
