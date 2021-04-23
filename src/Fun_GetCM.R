#  _____                 _   _
# |  ___|   _ _ __   ___| |_(_) ___  _ __  ___
# | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/ 
# Extra functions to avoid cluttering up the code

convert_bins <- function(CM_5) {
  l <- dim(CM_5)[1]
  CM_10 <- matrix(nrow = l/2, ncol = l/2)
  
  col_count <- 1
  for (col in seq(1, l, by = 2)){
    row_count <- 1
    for (row in seq(1, l, by = 2)){
      CM_10[row_count, col_count] <- CM_5[row,col] +
        CM_5[row,col+1] + CM_5[row+1,col] + CM_5[row+1,col+1]
      row_count <- row_count + 1
    }
    col_count <- col_count + 1
  }
  
  return(CM_10)
}

extrapolate <- function(CM_10) {
  N70 <- dim(CM_10)[1]
  N60 <- N70 - 1
  N80 <- N70 + 1
  
  CM_Final <- matrix(nrow=N80, ncol=N80)
  colnames(CM_Final) <- Age
  rownames(CM_Final) <- Age
  
  # fill rows for 80+ with same data from 70-79
  CM_Final[1:N70, 1:N70] <- CM_10
  CM_Final[2:N80, N80] <- CM_10[1:N70, N70]
  CM_Final[N80, 2:N80] <- CM_10[N70, 1:N70]
  
  CM_Final[1, N80] <- CM_Final[1, N70]
  CM_Final[N80, 1] <- CM_Final[N70, 1]
  
  # Decrease contact for bins 0-69 for 80+ and 
  # split these contacts between 70-79 & 80+
  col_decrease <- .1 * CM_Final[1:N60, N80]
  CM_Final[1:N60, N80] <- .9 * CM_Final[1:N60, N80]
  CM_Final[N70, N80] <- CM_Final[N70, N80] + sum(col_decrease)/2
  CM_Final[N80, N80] <- CM_Final[N80, N80] + sum(col_decrease)/2
  
  row_decrease <- 0.1 * CM_Final[N80, 1:N60]
  CM_Final[N80, 1:N60] <- 0.9 * CM_Final[N80, 1:N60]
  CM_Final[N80, N70] <- CM_Final[N80, N70] + sum(row_decrease)/2
  CM_Final[N80, N80] <- CM_Final[N80, N80] + sum(row_decrease)/2
  
  return(CM_Final)
}

get_ContactMatrix <- function(Country) {
  # Thanks to https://github.com/kieshaprem/synthetic-contact-matrices
  load("../synthetic-contact-matrices/output/syntheticcontactmatrices2020/overall/contact_all.rdata")
  
  CM_5 <- contact_all[[Country]]
  CM_10 <- convert_bins(CM_5)
  CM_Final <- extrapolate(CM_10)
  
  return(CM_Final)
}