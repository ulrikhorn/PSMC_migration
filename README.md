# PSMC_migration

It is a little messy, but in theory:

you should be able to just run the ms2psmc.sh (ms parameters can be changed inside this script, will work to make them arguments),
and it will create a psmc_msout.psmc with the results. 

This file can then be used to plot the results using r_scripts/plot_msout_psmc.r by specifying the path to the 
file in the first line of this r script.

