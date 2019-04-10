#!/bin/bash
#include <math.h>
# Add function to calculate t and r using baseline Ne and fragment length passed as arguments to this script
let "theta = 4 * 0.00000003 * $2 * $1"
#let "rho = 4 * $2 * 0.00000001 * $1"
#let "a = $1 * .1"
echo $theta
# number of decimal points
dec= l($2)/l(10)

# Generate ms data and save it to the temp directory
msdir/ms 2 1 -t $theta -r $rho $2 -p $dec > temp_ms2psmc/raw_msout.ms

# Remove metadata from ms output and generate psmcfa from newly refined data
cat temp_ms2psmc/raw_msout.ms | bash msout_refiner.sh | awk -f ms2psmcfa2.awk > psmcfa_msout.psmcfa

# Use psmcfa file to generate PSMC results and store to file used in plotting in R
psmc/psmc -N1 -t15 -r5 -p 4+25*2+4+6 -o psmc_msout.psmc psmcfa_msout.psmcfa
