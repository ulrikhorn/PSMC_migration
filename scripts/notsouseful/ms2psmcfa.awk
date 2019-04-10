#!/bin/awk -f
{# does not work if t is increased
  current_position=1
  frag_length=1000000 # make argument
  bin_size=100
  nr_of_bins=frag_length/bin_size
  nr_of_sites=NF

  for(i=1; i<=NF ; i++){
    pos=$i*frag_length
    for (current_position; current_position<=nr_of_bins; i+0) {
      current_position= current_position+1
      if ( pos <= bin_size*current_position ){
        #current_position= current_position+1
        printf("K")
        #printf(current_position)
        break  # This break statment ends the whole script
      }
      else {
        #current_position= current_position+1
        printf("T")
      }
    }
  }
missing= (frag_length-$nr_of_sites*frag_length)/bin_size # Number of missing Ns that should be present after the last K, based on the
  for(i=1; i<=missing; i++){
    if (i <= missing)
    printf("T")
  }
  #printf(missing)
  printf("\n")
  printf(nr_of_sites)
  #printf("\n")
  #printf(missing)
  #printf("\n")
}


# problem is that more than 1 K is being printed if there positions are too close
# a bin kan only be K once
