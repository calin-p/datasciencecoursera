corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
# set local path   
#    full_path = "~/Documents/Training/Coursera/Data Science/R Programming/Assignments/"
    if (!exists("full_path")) {
        full_path=""
    }
    
# go to specified directory     
    setwd(paste(full_path, directory, sep=""))   
# take the existing files    
    files = list.files() 
    id=1:length(files)
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
#calculating number of obseravtions on complete cases
    nobs<-vector(mode="logical", length=length(id))
#selecting observations with more nobs than threshold 
    for (i in seq_along(nobs)) {
        if(nrow(all_data_good[all_data_good$ID==id[i],])>threshold) {
            nobs[i]=TRUE
        }
    }
#for which id the condition is TRUE
#and calculating
    data_nobs<-data.frame(id, nobs)
    cor_val<-vector()
    j<-1
    for (i in seq_len(nrow(data_nobs))) {
        if(data_nobs$nobs[i]==TRUE) {
            cor_val[j]<-cor(all_data_good$sulfate[all_data_good$ID==data_nobs$id[i]],all_data_good$nitrate[all_data_good$ID==data_nobs$id[i]])
            j<-j+1
        }
    }
    cor_val

}
