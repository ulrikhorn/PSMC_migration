#!/bin/bash
#include <math.h>

# $1 = pop size, $2 = frag length, $3 = # reps
# theta =
let "theta = 4 * $2 * $1 * 3 / 100000000"

# rho =
let "rho = 4 * $2 * $1 * 1 / 100000000"

# number of decimal points
dec=$(echo "l($2)/l(10)" | bc -l)


for (( i = 1; i <= $3; i++ )); do
  # Generate ms data and save it to the temp directory
  msdir/ms 2 1 -t $theta -r $rho $2 -p $dec > temp_ms2psmc/raw_msout.ms

  # Remove metadata from ms output and generate psmcfa from newly refined data
  cat temp_ms2psmc/raw_msout.ms | bash msout_refiner.sh | awk -f ms2psmcfa2.awk > temp_ms2psmc/psmcfa_msout.psmcfa

  # Use psmcfa file to generate PSMC results and store to file used in plotting in R
  psmc/psmc -N1 -t15 -r5 -p 4+25*2+4+6 -o results_psmc/Ne_$1_frag_legnth_$2_rep_$i.psmc temp_ms2psmc/psmcfa_msout.psmcfa

done
