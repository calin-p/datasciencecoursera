rankhospital <- function(state, outcome, num = "best") {
    
    
    ## Read outcome data
    # set correct path related to scripts directory
    # full_path = "~/Documents/Training/Coursera/Data Science/R Programming/Assignments/"
    file<-paste(full_path, "rprog_data_ProgAssignment3-data/", "outcome-of-care-measures.csv", sep="")
    outcome_data<-read.csv(file, colClasses="character")
    
    ## Check that state and outcome are valid
    #state
    if (!(state %in% unique(outcome_data$State))) {
        stop("Invalid state!")
    }
    #outcome
    if (outcome == "heart attack") {
        outcome_table_name<-"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "heart failure") {
        outcome_table_name<-"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else if (outcome == "pneumonia") {
        outcome_table_name<-"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } else {
        stop("invalid outcome")
    }
    
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    
    hosp<-outcome_data[outcome_data$State==state, c("Hospital.Name",outcome_table_name)]
    hosp_ord<-hosp[order(as.numeric(hosp[[outcome_table_name]]),hosp$Hospital.Name),]
    
    # check num
    if (num =="best") {
        num<-1
    } else if (num=="worst") {
        num<-nrow(subset(hosp_ord,!is.na(as.numeric(hosp_ord[[outcome_table_name]]))))
    } else if (!is.numeric(num)) {
        stop("Invalid num!")
    }
  
    hosp_ord$Hospital.Name[num]
    
    
}