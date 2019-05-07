#!/bin/bash
#include <math.h>

# $1 = pop size, $2 = frag length, $3 = # reps
# theta = 4*frag_length*Ne*recomb rate
let "theta = 4 * $2 * $1 * 3 / 100000000"

# rho =4*frag_length*Ne *
let "rho = 4 * $2 * $1 * 1 / 100000000"

# number of decimal points
dec=$(echo "l($2)/l(10)" | bc -l)


for (( i = 1; i <= $3; i++ )); do
  # Generate ms data and save it to the temp directory
  # Note that I just use the bare ms command here.  
  # For well known programs like ms it's better to just assume the user has them installed and on their path 
  # rather than put in relative paths within your project.
  # The same goes for psmc

  ms 2 1 -t $theta -r $rho $2 -p $dec > py_temp_ms2psmc/raw_msout.ms

  mscommand="ms 2 1 -t $theta -r $rho $2 -p $dec"

  python ms-PSMC/ms2psmcfa.py py_temp_ms2psmc/raw_msout.ms > py_temp_ms2psmc/psmcfa.psmcfa

  psmc -N25 -t15 -r5 -p 4+25*2+4+6 -o py_results_psmc/Ne_$1_frag_length_$2_rep_$i.psmc py_temp_ms2psmc/psmcfa.psmcfa

  # This is just for debugging
  echo "ms-PSMC/plot_results.py \"$mscommand\" py_results_psmc/Ne_$1_frag_length_$2_rep_$i.psmc"

  # This might depend a bit on your shell.  The special quotes around mscommand are so that it get
  # gets preserved as a single argument when passed to the python script
  #
  python ms-PSMC/plot_results.py "\"$mscommand\"" py_results_psmc/Ne_$1_frag_length_$2_rep_$i.psmc
done

echo $theta
echo $rho
echo $dec
