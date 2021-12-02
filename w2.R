#Part1

#Write a function named 'pollutantmean' that calculates the mean of a pollutant 
#(sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes 
#three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 
#'pollutantmean' reads that monitors' particulate matter data from the directory 
#'#specified in the 'directory' argument and returns the mean of the pollutant across 
#'all of the monitors, ignoring any missing values coded as NA. 


dir.create('specdata')
setwd("~/Desktop/R_coursera/DataScience_R_Coursera/specdata")

pollutantmean <- function(directory, pollutant, id=1:332){
  data <- NA
  for(monitor in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
    monitor_data <- read.csv(path)
    data <- rbind(data, monitor_data)
  }
  mean(data[[pollutant]],na.rm = TRUE) #double[[]]
}
#or
pollutantmean <- function(directory, pollutant, id = 1:332) {
  # Get full path of the specsdata folder
  directory <- paste(getwd(),"/",directory,"/",sep="")
  
  # Aux variables
  file_list <- list.files(directory)
  data <- NA
  #For each id passed as parameter:
  for (i in id) {
    #Read the file,
    file_dir <- paste(directory,file_list[i],sep="")
    file_data <- read.csv(file_dir)
    
    # accumulate the data
    data <- rbind(data,file_data)
  }
  # Calculate the mean and return it
  mean(data[[pollutant]],na.rm = TRUE)
}

pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")

#Part2

#Write a function that reads a directory full of files and reports the number of completely 
#observed cases in each data file. The function should return a data frame where the first 
#column is the name of the file and the second column is the number of complete cases.

setwd("~/Desktop/R_coursera/DataScience_R_Coursera/specdata")

complete <- function(directory, id=1:332){
  ids <- numeric(0) #intialization with empty vector/num
  nobs <- numeric(0)
  for(i in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", i), ".csv", sep = "")
    data <- read.csv(path)
    ids <- c(ids, i)
    nobs <- c(nobs, sum(complete.cases(data)))
  }
  data.frame(id = ids, nobs = nobs)
}

complete <- function(directory, id = 1:332) {
  # Get full path of the specsdata folder
  directory <- paste(getwd(),"/","specdata","/",sep="")
  # Aux variables
  file_list <- list.files(directory)
  ids <- vector()
  nobs <- vector()
  #For each id passed as parameter:
  for (i in id) {
    # Read the file,
    file_dir <- paste(directory,file_list[i],sep="")
    file_data <- read.csv(file_dir)
    
    # acumulate ids and nobs values in the vectors    
    ids = c(ids,i)
    nobs = c(nobs,sum(complete.cases(file_data)))        
  }
  # Finally, Create the data frame using the vectors and return it
  data.frame(id = ids, nobs = nobs)
}

complete <- function(directory, id = 1:332){
  results <- data.frame(id=numeric(0), nobs=numeric(0))
  for(monitor in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
    data <- read.csv(path)
    nobs <- sum(complete.cases(data))
    results <- rbind(results, data.frame(id=monitor, nobs=nobs))
  }
  results
}

complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
complete("specdata", 54)

#Part3

#Write a function that takes a directory of data files and a threshold for 
#complete cases and calculates the correlation between sulfate and nitrate for 
#monitor locations where the number of completely observed cases (on all variables) 
#is greater than the threshold. The function should return a vector of correlations 
#for the monitors that meet the threshold requirement. If no monitors meet the 
#threshold requirement, then the function should return a numeric vector of length 0.

setwd("~/Desktop/R_coursera/DataScience_R_Coursera/specdata")

corr <- function(directory, threshold = 0){
  id <- 1:332
  vec <- numeric(0)
  for(monitor in id){
    path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
    data <- read.csv(path)
    if(sum(complete.cases(data))>threshold){
      #data_clean <- subset(data, complete.cases(data))
      data_clean <- subset(data, is.na(data$sulfate)==FALSE,is.na(data$nitrate)==FALSE)
      vec <- c(vec, cor(data_clean$sulfate, data_clean$nitrate))
    }
  }
  vec
}

corr("specdata", 150)
