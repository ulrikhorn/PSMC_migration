#!/bin/awk -f
function join(array, start, end, sep,    result, i)
{
    if (sep == "")
       sep = " "
    else if (sep == SUBSEP) # magic value
       sep = ""
    result = array[start]
    for (i = start + 1; i <= end; i++)
        result = result sep array[i]
    return result
}
{
printf(">1")
printf("\n")
nr_of_sites= NF
frag_length=1000000
bin_size=100
nr_of_bins=frag_length/bin_size

for(i=0; i<=nr_of_bins; i++){
  psmcfa_vector[i]="T"
}

for(k=0; k<=NF; k++){
  #printf($k*frag_length/100)
  #printf(" ")
  k_pos= int($k*frag_length/bin_size)+1
  #printf(k_pos)
  #k_pos= awk {"%.0f", k_pos}
  #k_pos= printf("%.0", k_pos)
  psmcfa_vector[k_pos] = "K"
}


print(join(psmcfa_vector, 1, length(psmcfa_vector), SUBSEP))
#for (i in psmcfa_vector){ print psmcfa_vector[i]}
#printf(NF)
}
