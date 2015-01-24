pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    
# set local path   
#    full_path = "~/Documents/Training/Coursera/Data Science/R Programming/Assignments/"
    if (!exists("full_path")) {
        full_path=""
    }
    
# go to specified directory     
    setwd(paste(full_path, directory, sep=""))   
# take the existing files    
    files = list.files() 

# take data from there
# alternatively can be done in a loop 
    data = lapply(files[id], read.table, sep=",", header=T)

# convert the list of lists to data frame  
# alternatively can be done in a loop 
    all_data<-do.call("rbind",data)

#calculate
    round(mean(all_data[,pollutant], na.rm=TRUE), digits=3)
}
