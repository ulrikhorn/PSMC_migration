library(tidyverse)

msout_results <- file("bioinformatics/psmc_project/scripts/psmc_msout.psmc")

psmc.result<-function(file,i.iteration=25,mu=1e-8,s=100,g=1)
{
  X<-scan(file=file,what="",sep="\n",quiet=TRUE)
  
  START<-grep("^RD",X)
  END<-grep("^//",X)
  
  X<-X[START[i.iteration+1]:END[i.iteration+1]]
  
  TR<-grep("^TR",X,value=TRUE)
  RS<-grep("^RS",X,value=TRUE)
  
  write(TR,"temp.psmc.result")
  theta0<-as.numeric(read.table("temp.psmc.result")[1,2])
  N0<-theta0/4/mu/s
  
  write(RS,"temp.psmc.result")
  a<-read.table("temp.psmc.result")
  Generation<-as.numeric(2*N0*a[,3])
  Ne<-as.numeric(N0*a[,4])
  
  file.remove("temp.psmc.result")
  
  n.points<-length(Ne)
  YearsAgo<-c(as.numeric(rbind(Generation[-n.points],Generation[-1])),
              Generation[n.points])*g
  Ne<-c(as.numeric(rbind(Ne[-n.points],Ne[-n.points])),
        Ne[n.points])
  
  data.frame(YearsAgo,Ne)
}

msout_results_table <- psmc.result(msout_results, i.iteration = 1)

ggplot(msout_results_table, mapping = aes(YearsAgo, Ne)) +
  geom_point() 


#theta <- function(Ne, mut_rate=0.00000003, frag_length){
#4*(mut_rate*frag_length)*Ne
#}

#theta(10000, frag_length = 1000000)

#rho <- function(Ne, recomb=0.00000001, frag_length){
#  4*Ne*(frag_length*recomb)
#}

#rho(10000, frag_length = 1000000)
