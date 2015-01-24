complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases

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

#good<-complete.cases(all_data)
#all_data_good<-all_data[good,]

    all_data_good<-all_data[complete.cases(all_data),]

#subsetting on ID
#subset(all_data_good, ID==id)
#calculating with rezults in a matrix
    r<-matrix(nrow=length(id), ncol=2)
    colnames(r)<-c("id","nobs")

    for (i in seq_len(nrow(r))) {
        for (j in 1:2) {
            r[i,1]=id[i]
            r[i,2]=nrow(all_data_good[all_data_good$ID==id[i],])
        }
    }
    data.frame(r)
}
