# PSMC_migration

It is a little messy, but in theory:

you should be able to just run the ms2psmc.sh with arguments:
- Ne
- frag_length
- number of replicates

This will create psmc files in the results_psmc/ directory


These files can then be used to plot the results using r_scripts/plot_msout_psmc.r by specifying the path to the
file in the first line of this r script.
  - need to make some way of plotting all recplicate files at once, atm each file has to be specified.
