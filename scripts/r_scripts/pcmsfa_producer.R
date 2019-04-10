script <- function(pos_vector, frag_length){

binsize <- 100
nr_of_bins <- seq(from = 1, to = frag_length/100)
N_vector <- vector()

  for (pos in seq(from = 1,to = length(pos_vector))) {
    for (bin_nr in seq(from = 1+length(N_vector), to = frag_length/100)) {
      if((pos_vector[pos]*frag_length) <= bin_nr*binsize){
        N_vector[bin_nr] <- "K"
        break # If a K is produced then the for loop has to end and start on the next pos
      } else {
        N_vector[bin_nr] <- "N"
        # If a N is produced then the for loop continiues with is pos < 200 etc
      }
    }

  }
  print(N_vector)
}
