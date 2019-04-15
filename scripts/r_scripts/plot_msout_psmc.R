


plot_results <- function(number_of_reps){
  library(tidyverse)
  
  for (rep_number in seq(from = 1, to = number_of_reps, by = 1)) {
    
    # Define replicate file names 
    msout_results <- file(sprintf("bioinformatics/PSMC_migration/scripts/results_psmc/Ne_10000_frag_length_1000000_rep_%s.psmc",
                                  rep_number))
    
    # Define psmc.results function
    psmc.result<-function(file,i.iteration=25, mu=1e-8, s=100, g=1)
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

    # Making results table
    msout_results_table <- psmc.result(msout_results, i.iteration = 1)
    
    # Plot results for this iteration of the for loop
    # NOT WORKING not printing a plot every time
    return(ggplot(msout_results_table, mapping = aes(YearsAgo, Ne)) +
      geom_point() +
      labs(title = "test"))
  }
}

plot_results(2)

