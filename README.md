# PSMC_migration
This is a pipe for simulating genomes with ms and estimating their historical demographic history using PSMC.

ms simulated genomes and their corresponding PSMC results are generated using the ms2psmc2.sh script.

ms2psmc2.sh
  - arg1 Baseline effective population size
  - arg2 DNA fragment length
  - arg3 number of replicates
  - arg4 migration parameter


This will create 3 sets of directories with:
  - PSMC results files
  - .csv results files
  - python generated preliminary results
  
The .csv files can then be plotted in Rstudio using the py_r_plot_results.R by specifying the migration parameters used when generating the results.
