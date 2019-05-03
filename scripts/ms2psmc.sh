#!/bin/bash
#include <math.h>\
# removes previous data 
rm results_psmc/*
# $1 = pop size, $2 = frag length, $3 = # reps
# theta = 4*frag_length*Ne*recomb rate
let "theta = 4 * $2 * $1 * 3 / 100000000"

# rho =4*frag_length*Ne *
let "rho = 4 * $2 * $1 * 1 / 100000000"

# number of decimal points
dec=$(echo "l($2)/l(10)" | bc -l)


for (( i = 1; i <= $3; i++ )); do
  # Generate ms data and save it to the temp directory
  msdir/ms 2 1 -t $theta -r $rho $2 -p $dec  > temp_ms2psmc/raw_msout.ms

  # -I 2 1 # pops, # of samples from each pop,
  # -n 1 1.15 = make population 1
  # ema -t time npop x 2 1 x #ass=ymetric migratio from one pop to the other but none in return
  #  -en at t change

  # Remove metadata from ms output and generate psmcfa from newly refined data
  cat temp_ms2psmc/raw_msout.ms | bash msout_refiner.sh | awk -f ms2psmcfa2.awk > temp_ms2psmc/psmcfa_msout.psmcfa

  # Use psmcfa file to generate PSMC results and store to file used in plotting in R
  psmc/psmc -N1 -t15 -r5 -p 4+25*2+4+6 -o results_psmc/Ne_$1_frag_length_$2_rep_$i.psmc temp_ms2psmc/psmcfa_msout.psmcfa

done

echo $theta
echo $rho
echo $dec
