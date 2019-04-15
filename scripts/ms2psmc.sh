#!/bin/bash
#include <math.h>
# Add function to calculate t and r using baseline Ne and fragment length passed as arguments to this script
# $1 = pop size, $2 = frag length
let "theta = 4 * $2 * $1 * 3 / 100000000"
let "rho = 4 * $2 * $1 * 1 / 100000000"

# number of decimal points
#let "dec= l($2)/l(10)"

# Generate ms data and save it to the temp directory
msdir/ms 2 1 -t $theta -r $rho $2 -p 6 > temp_ms2psmc/raw_msout.ms

# Remove metadata from ms output and generate psmcfa from newly refined data
cat temp_ms2psmc/raw_msout.ms | bash msout_refiner.sh | awk -f ms2psmcfa2.awk > psmcfa_msout.psmcfa

# Use psmcfa file to generate PSMC results and store to file used in plotting in R
psmc/psmc -N1 -t15 -r5 -p 4+25*2+4+6 -o psmc_msout.psmc psmcfa_msout.psmcfa
