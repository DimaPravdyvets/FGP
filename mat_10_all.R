####################### percentages


###################################





####################### 10 matrix
new_rows<-c()


matrix_9<-c()
for(row in 1:length(row.names(matrix))){
  for(row2 in row:length(row.names(matrix))){
    if(row.names(matrix)[row]!=row.names(matrix)[row2]){
    #combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    
    #new_rows<-c(new_rows,combo)
    chi<-chisq.test(c(matrix[row,19],matrix[row,20]),c(matrix[row2,19],matrix[row2,20]))
    matrix_9<-c(matrix_9,chi$statistic)
    print(combo)
    print(chi$statistic)
    }
  }
}
matrix_9<-c(matrix_9,0)
mat_10_all$DAF_9<-matrix_9

mat_10_all<-data.frame(new_rows,matrix_0)
#colnames(mat_10_all)<-c("Combos","DAF_0","DAF_1","DAF_2","DAF_3","DAF_4","DAF_5","DAF_6","DAF_1","DAF_10","DAF_1")
write.csv(mat_10_all,"mat_10_all.csv")

###################################

library("gplots")
library("FactoMineR")
library("factoextra")
CA(mat_10_all)
PCA(mat_10_all)

####
install.packages("corrplot")
library(corrplot)

correlations <- cor(mat_10_all[,2:11])
corrplot(correlations, method="circle")

###
library(magrittr)
library(dplyr)
library(ggpubr)

mds <- mat_10_all %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(mat_10_all),
          size = 1,
          repel = TRUE)


# K-means clustering
set.seed(42069)
clust <- kmeans(mds, 4)$cluster %>%
  as.factor()
mds <- mds %>%
  mutate(groups = clust)
# Plot and color by groups
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(mat_10_all),
          color = "groups",
          palette = "jco",
          size = 1, 
          ellipse = TRUE,
          ellipse.type = "convex",
          repel = TRUE)







############################################ porcentajes en vez de #
Disorders<-row.names(matrix)

percentage_data<-data.frame(Disorders)
for(col in seq(2,length(colnames(matrix)),by=2)){
  k<-(paste(colnames(matrix)[col-1],"total",sep="/"))
  p<-(matrix[,col-1]/(matrix[,col-1]+matrix[,col]))
#  print(k)
  percentage_data[[k]]<-p
}

head(percentage_data)
write.csv(percentage_data,"percentage_data")


library("gplots")
library("FactoMineR")
library("factoextra")
CA(percentage_data[1:6,1:8])
PCA(percentage_data[1:6,1:8])

####
install.packages("corrplot")
library(corrplot)

correlations <- cor(percentage_data[,2:11])
corrplot(correlations, method="circle")

###
library(magrittr)
library(dplyr)
library(ggpubr)






mds <- percentage_data %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(percentage_data),
          size = 1,
          repel = TRUE)


# K-means clustering
set.seed(42069)
clust <- kmeans(mds, 3)$cluster %>%
  as.factor()
mds <- mds %>%
  mutate(groups = clust)
# Plot and color by groups
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(percentage_data),
          color = "groups",
          palette = "jco",
          size = 1, 
          ellipse = TRUE,
          ellipse.type = "convex",
          repel = TRUE)

################################
total_per_cent<-matrix(,ncol=20,nrow=7)

for(col in seq(2,length(colnames(matrix)),by=2)){
#  k<-(paste(colnames(matrix)[col-1],"total",sep="/"))
  print(colnames(matrix)[col-1])
  p<-(matrix[col-1,col-1]/(matrix[col-1,col-1]+matrix[col,col]))
  #  print(k)
  print(col-1)
  total_per_cent[col,col]<-p
  total_per_cent[col-1,col-1]<-1-p
}

head(total_per_cent)


########################## second approach to 10 matrices

total_data<-data.frame(Disorders)
for(col in seq(2,length(colnames(matrix)),by=2)){
  k<-(paste(colnames(matrix)[col-1],"total",sep="/"))
  p<-(matrix[,col-1]+matrix[,col])
  #  print(k)
  total_data[[k]]<-p
}
colnames(total_data)<-c("Disorders","DAF_0","DAF_1","DAF_2","DAF_3","DAF_4","DAF_5","DAF_6","DAF_7","DAF_8","DAF_9")



for(row in 1:length(row.names(total_data))){
  for(row2 in row:length(row.names(total_data))){
    combo<-(paste(row.names(total_data)[row],row.names(total_data)[row2],sep = ":"))
chi<-chisq.test(as.numeric(total_data[row,]),as.numeric(total_data[row2,]))
print(paste(combo,chi$statistic))
  }
}
as.numeric(total_data[1,])
write.csv(total_data,"total_data.csv")

############# eucledian

#matrix<-as.matrix(matrix)
mat_0<-matrix(,nrow=7,ncol=7)

#
#,simulate.p.value = TRUE
for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),1:2])
    print(paste(combo,chi$statistic))
    mat_0[row,row2]<-chi$statistic
  }
}
matrix[c(1,2),1:2]

mat_1<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),3:4])
    print(paste(combo,chi$statistic))
    mat_1[row,row2]<-chi$statistic
  }
}


mat_2<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),5:6])
    print(paste(combo,chi$statistic))
    mat_2[row,row2]<-chi$statistic
  }
}

mat_3<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),7:8])
    print(paste(combo,chi$statistic))
    mat_3[row,row2]<-chi$statistic
  }
}

mat_4<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),9:10])
    print(paste(combo,chi$statistic))
    mat_4[row,row2]<-chi$statistic
  }
}

mat_5<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),11:12])
    print(paste(combo,chi$statistic))
    mat_5[row,row2]<-chi$statistic
  }
}

mat_6<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),13:14])
    print(paste(combo,chi$statistic))
    mat_6[row,row2]<-chi$statistic
  }
}


mat_7<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),15:16])
    print(paste(combo,chi$statistic))
    mat_7[row,row2]<-chi$statistic
  }
}

mat_8<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),17:18],simulate.p.value = TRUE)
    print(paste(combo,chi$statistic))
    mat_8[row,row2]<-chi$statistic
  }
}

mat_9<-matrix(,nrow=7,ncol=7)

for(row in 1:length(row.names(matrix))){
  for(row2 in 1:length(row.names(matrix))){
    combo<-(paste(row.names(matrix)[row],row.names(matrix)[row2],sep = ":"))
    chi<-chisq.test(matrix[c(row,row2),19:20],simulate.p.value = TRUE)
    print(paste(combo,chi$statistic))
    mat_9[row,row2]<-chi$statistic
  }
}

#####

mat_1[is.nan(mat_1)] <- 0
mat_1[is.na(mat_1)] <- 0
mat_2[is.nan(mat_2)] <- 0
mat_2[is.na(mat_2)] <- 0
mat_3[is.nan(mat_3)] <- 0
mat_3[is.na(mat_3)] <- 0
mat_4[is.nan(mat_4)] <- 0
mat_4[is.na(mat_4)] <- 0
mat_5[is.nan(mat_5)] <- 0
mat_5[is.na(mat_5)] <- 0
mat_6[is.nan(mat_6)] <- 0
mat_6[is.na(mat_6)] <- 0
mat_7[is.nan(mat_7)] <- 0
mat_7[is.na(mat_7)] <- 0
mat_8[is.nan(mat_8)] <- 0
mat_8[is.na(mat_8)] <- 0
mat_9[is.nan(mat_9)] <- 0
mat_9[is.na(mat_9)] <- 0

sum_mat_10<-mat_0+mat_1+mat_2+mat_3+mat_4+mat_5+mat_6+mat_7+mat_8+mat_9
sum_mat_10<-as.data.frame(sum_mat_10)
row.names(sum_mat_10)<-rownames(matrix)
colnames(sum_mat_10)<-rownames(matrix)
sum_mat_10
write.csv(sum_mat_10,"chi_square_distances.csv")
#sum_mat_10<-as.data.frame(sum_mat_10[1:6,1:6])

#write.csv(sum_mat_10,"sum_mat_10_chisquare.csv")

cmdscale(sum_mat_10)

kkdeluxe <-cmdscale(sum_mat_10,eig=T,k=(nrow(sum_mat_10)-1),add=T)
oscar_plot<-t(oscar_plot)
kkdeluxe2 <-cmdscale(dist(oscar_plot),eig=T,k=(nrow((oscar_plot))-1),add=T)


100*kkdeluxe$eig[1]/sum(kkdeluxe$eig)
100*kkdeluxe$eig[2]/sum(kkdeluxe$eig)

100*kkdeluxe2$eig[1]/sum(kkdeluxe2$eig)
100*kkdeluxe2$eig[2]/sum(kkdeluxe2$eig)


res_ca<-as_tibble(cmdscale(sum_mat_10))
colnames(res_ca) <- c("Dim.1", "Dim.2")

ggscatter(res_ca, x = "Dim.1", y = "Dim.2", 
          label = rownames(sum_mat_10),
          size = 1,
          repel = TRUE,
          title = "MDS of chi-square distances")

sum(res_ca$Dim.2**2)



?mds
mds <- sum_mat_10 %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(sum_mat_10),
          size = 1,
          repel = TRUE)


plot(mds)


kkdeluxe<-dist(percentage_data[1:6,])
dim(kkdeluxe)
md<-cmdscale(kkdeluxe,eig=T)
md<-as_tibble(md$points)
colnames(md) <- c("Dim.1", "Dim.2")

ggscatter(md, x = "Dim.1", y = "Dim.2", 
          label = rownames(sum_mat_10)[1:6],
          size = 1,
          repel = TRUE,title = "MDS of Risk-Ancestral % without OCD")


ggsave("mds_perentage_no_OCD.png")



install.packages("IsoplotR")
library(IsoplotR)

# K-means clustering
set.seed(42069)
clust <- kmeans(mds, 3)$cluster %>%
  as.factor()
mds <- mds %>%
  mutate(groups = clust)
# Plot and color by groups
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(percentage_data),
          color = "groups",
          palette = "jco",
          size = 1, 
          ellipse = TRUE,
          ellipse.type = "convex",
          repel = TRUE)



####


sum(mat_0,mat_1,mat_2,mat_3,mat_4,mat_5,mat_6,mat_7,mat_8,mat_9)

sum_mat_10<-mat_0+mat_1+mat_2+mat_3+mat_4+mat_5+mat_6+mat_7+mat_8+mat_9
sum_mat_10<-as.data.frame(sum_mat_10)
row.names(sum_mat_10)<-rownames(total_data)
colnames(sum_mat_10)<-rownames(total_data)

PCA(sum_mat_10)
ca<-CA(sum_mat_10)
fviz_ca_row(ca)

mds <- sum_mat_10 %>%
  cmdscale(add=T,eig=T) %>%
  as_tibble(mds$points)
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(sum_mat_10),
          size = 1,
          repel = TRUE)
res.mds<-cmdscale(sum_mat_10,eig=T)
mds<-as_tibble(res.mds$points)
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(sum_mat_10),
          size = 1,
          repel = TRUE,title = "MDS of squared-chi computed distances")

ggsave("mds_chi_sqaured.png")



# K-means clustering
#set.seed(111)
clust <- kmeans(mds, 4)$cluster %>%
  as.factor()
mds <- mds %>%
  mutate(groups = clust)
# Plot and color by groups
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(percentage_data),
          color = "groups",
          palette = "jco",
          size = 2, 
          ellipse = TRUE,
          ellipse.type = "convex",
          repel = TRUE)



write.csv(sum_mat_10,"sum_10_matrices_eucledian_dist.csv")

###################


install.packages("philentropy")
library(philentropy)
round(distance(rbind(total_data[5,], total_data[7,]), method = "squared_chi"),3)
print(rownames(matrix)[7])
rownames(matrix)

PCA(eucledian_dist_total)
CA(eucledian_dist_total)
library(magrittr)
library(dplyr)
library(ggpubr)

mds <- eucledian_dist_total %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(eucledian_dist_total),
          size = 1,
          repel = TRUE)


# K-means clustering
#set.seed(111)
clust <- kmeans(mds, 3)$cluster %>%
  as.factor()
mds <- mds %>%
  mutate(groups = clust)
# Plot and color by groups
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(percentage_data),
          color = "groups",
          palette = "jco",
          size = 2, 
          ellipse = TRUE,
          ellipse.type = "convex",
          repel = TRUE)
######################
oscar_plot<-t(oscar_plot)
mds<-as_tibble(cmdscale(dist(oscar_plot)))

mds <- oscar_plot %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")
# Plot MDS
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(oscar_plot),
          size = 1,
          repel = TRUE, title = "MDS of the Risk-Derived/Risk-Ancestral ratio")
ggsave("mds_ratio.png")

