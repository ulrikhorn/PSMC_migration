library(tidyverse)

msout_results <- file("bioinformatics/psmc_project/scripts/psmc_msout.psmc")

msout_results_table <- psmc.result(msout_results, i.iteration = 1)

#[10:127, c(1,2)]

ggplot(msout_results_table, mapping = aes(YearsAgo, Ne)) +
  geom_point() 


theta <- function(Ne, mut_rate=0.00000003, frag_length){
4*(mut_rate*frag_length)*Ne
}

theta(10000, frag_length = 1000000)

rho <- function(Ne, recomb=0.00000001, frag_length){
  4*Ne*(frag_length*recomb)
}

rho(10000, frag_length = 1000000)
