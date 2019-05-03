
library(tidyverse)

psmc_result<-function(file,i.iteration=25, mu=1e-8, s=100, g=1)
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


read_psmc <- function(filename){
  rep <- str_match(filename,"([0-9]+).psmc")[,2]
  psmc_result(filename,i.iteration = 1, mu=3e-8) %>% 
    add_column(replicate=rep) 

}


#dd <- psmc_result("scripts/results_psmc/Ne_10000_frag_length_10000000_rep_1.psmc",2)

  all_psmc <- do.call(rbind,lapply(list.files("scripts/results_psmc/", full.names = TRUE), read_psmc))
   
  ggplot(all_psmc, mapping = aes(YearsAgo, Ne)) +
  geom_step(aes(color=replicate)) +
  labs(title = "5 reps, 10 mill frag length, 20k Ne, 1 iter") + ylim(50000,120000) + xlim(300, 2000000) 
  #scale_x_log10()

  
list.files("scripts/results_psmc/") 
  
