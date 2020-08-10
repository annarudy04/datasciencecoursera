data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
data_state_index <- 7
data_hospital_index <- 2
outcomes <- c("heart attack", "heart failure", "pneumonia")
outcome_cols <- c(11, 17, 23)
names(outcome_cols) <- outcomes

histogram <- function(){
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  outcome[, 11] <- as.numeric(outcome[,11])
  hist(outcome[, 11])
}

validate_data <- function(outcome, state=''){
  # validate the values provided for outcome and state
  # outcome will be used by all functions, but state may not be
  if (state !='' & !(state %in% data[[7]])){
    print(paste(
      "Error in best(), invalide state: ",
      state
    ))
    FALSE
  }
  else if (!(outcome %in% outcomes)){
    print(paste(
      "Error in best(), invalide outcome: ",
      outcome
    ))
    FALSE
  }
  else{
    TRUE
  }
}

get_ranked_state_data <- function(state, outcome){
  # Use an integer index for the outcome column since they
  # are long, and I'm not sure how to index by string when the 
  # string is pasted 
  outcome_col_ind <- outcome_cols[outcome]
  
  # Select the hospital name and the mortality outcome
  # for the given state where the outcome mortality rate is available
  state_data <- subset(
    data, 
    data[[data_state_index]] == state & !is.na(data[[outcome_col_ind]]) & 
      data[[outcome_col_ind]] != 'Not Available', 
    select=c(data_hospital_index, outcome_col_ind)
  )
  # Change the mortality column name to be easier to reference
  names(state_data) <- c(names(state_data)[1], "outcome_mortality_rate")
  # Order the state's data by outcome mortality rate and then by 
  # hospital name
  state_data <- state_data[order(
    as.numeric(state_data$outcome_mortality_rate), 
    state_data$Hospital.Name
    ),]
}

get_ranked_us_data <- function(outcome){
  # Use an integer index for the outcome column since they
  # are long, and I'm not sure how to index by string when the 
  # string is pasted 
  outcome_col_ind <- outcome_cols[outcome]
  # Select the hospital name, state, and outcome mortality rate
  # where outcome mortality rate is available
  us_data <- subset(
    data, 
      !is.na(data[[outcome_col_ind]]) & 
      data[[outcome_col_ind]] != 'Not Available', 
    select=c(data_hospital_index, data_state_index, outcome_col_ind)
  )
  # Change the mortality column name to be easier to reference
  names(us_data) <- c(
    names(us_data)[1],
    names(us_data)[2],
    "outcome_mortality_rate"
  )
  # Order the data by state, outcome mortality rate, 
  # and then hospital name
  us_data <- us_data[order(
    us_data$State, 
    as.numeric(us_data$outcome_mortality_rate), 
    us_data$Hospital.Name
  ),]
}

best <- function(state, outcome){
  # select the first value in the $Hospital.Name column
  # since ranked_state_data has been sorted by rank
  if (validate_data(outcome, state)){
    ranked_state_data <- get_ranked_state_data(state, outcome)
    ranked_state_data$Hospital.Name[1]
  }
}

rankhospital <- function(state, outcome, rank){
  if (validate_data(outcome, state)){
    ranked_state_data <- get_ranked_state_data(state, outcome)
    # Use either the number, 1 for best or the number of rows in the
    #  dataframe for worst
    rank <- if (class(rank) == "numeric"){
      rank
    }
    else{
      string_ranks <- c(
        "best"=1,
        "worst"=nrow(ranked_state_data)
      )
      string_ranks[rank]
    }
    # Return the name of the hospital that cooresponds to rank
    ranked_state_data$Hospital.Name[rank]
  }
}

rankall <- function(outcome, num = "best"){
  if (validate_data(outcome)){
    ranked_us_data <- get_ranked_us_data(outcome) 
    # Split data into a list broken up by state (remember the data
    # is already ordered by state, outcome mortality rate, and state)
    split_data <- split(ranked_us_data, ranked_us_data$State)
    # for each element of the returned list (i.e. each state), select
    # the hospital name corresponding to the rank
    nth_state <- if(class(num) == "numeric"){
      sapply(split_data, function(x){x[num,]$Hospital.Name})
    }
    else if (num == 'best'){
      sapply(split_data, function(x){x[num,]$Hospital.Name})
    }
    else if (num == 'worst'){
      sapply(split_data, function(x){x[nrow(x),]$Hospital.Name})
    }
    else{
      print(paste("Invalid value for num:", num))
      return()
    }
    # Turn the results returned by sapply() into a dataframe
    nth_state_df <- data.frame(state=names(nth_state), hospital=nth_state)
  }
}