combine_file_data <- function(directory, id = 1:332){
  # inital df with just columns (no data)
  data <- data.frame(
    Date=as.Date(character()),
    sulfate=numeric(),
    nitrate=numeric(),
    id=integer()
  )
  # read in data for each ID and combine, returning one df
  for (num in id){
    num_zeros = 3 - nchar(num)
    zeros = rep(0, num_zeros)
    file_name = paste(c(directory, '/', zeros,num,'.csv'), collapse="")
    data = rbind(data, read.csv(file_name))
  }
  data
}

pollutantmean <- function(directory, pollutant, id = 1:332){
  # get mean for one pollutant
  data <- combine_file_data(directory, id)
  pollutant_df = data[pollutant]
  mean(pollutant_df[!is.na(pollutant_df)])
}

get_complete_data <- function(data){
  # return a complete dataset with no NA's
  data =subset(
    data, 
    !is.na(Date) & !is.na(sulfate) & !is.na(nitrate) & !is.na(ID)
  )
}

complete <- function(directory, id = 1:332, include_cor = FALSE){
  #get only complete data
  data <- combine_file_data(directory, id)
  data <- get_complete_data(data)
  # initialze df with just columns
  count_df <- data.frame(
    id=integer(),
    nobs=integer(),
    cor=numeric()
  )
  # manually get counts, and cors if include_cor, for each ID 
  # and store in a final df to return 
  for (num in id){
    id_data = subset(
      data,
      ID==num
    )
    id_corr <- if (include_cor){
      cor(id_data[["sulfate"]], id_data[["nitrate"]])
    }
    else{
      NA
    }
    nobs = nrow(id_data)
    id_df = data.frame(
      id=num,
      nobs=nobs,
      cor=id_corr
    )
    count_df <- rbind(count_df, id_df )
  }
  count_df
}

corr <- function(directory, threshold=0){
  # get a complete set of the data in the dir
  id_data = complete(directory, include_cor=TRUE)
  # select only ids with counts over the threshold
  ids_over_thres <- subset(id_data, nobs > threshold)
  # return the correlations of those ids
  ids_over_thres[['cor']]
}  
  