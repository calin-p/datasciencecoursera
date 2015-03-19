rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    # set correct path related to scripts directory
    # full_path = "~/Documents/Training/Coursera/Data Science/R Programming/Assignments/"
    file<-paste(full_path, "rprog_data_ProgAssignment3-data/", "outcome-of-care-measures.csv", sep="")
    outcome_data<-read.csv(file, colClasses="character")
    
    ## Check that outcome is valid
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
    
    # order all data on state, outcome, hospital_name
    outcome_data_select<-outcome_data[, c("State", "Hospital.Name",outcome_table_name)]
    
    outcome_data_ord<-outcome_data_select[order(outcome_data_select$State, as.numeric(outcome_data_select[[outcome_table_name]]), outcome_data_select$Hospital.Name),]
    #
    # pre-allocate spece on output dataframe on length of state_vect
    state_vect<-unique(outcome_data_ord$State)
    output_frame <- data.frame(hospital = character(length(state_vect)), state = character(length(state_vect)),stringsAsFactors = FALSE)
    i<-1
    # select for each state
    for (state in state_vect) {
        hosp<-outcome_data_ord[outcome_data_ord$State == state,]
        hosp_ord<-hosp[order(as.numeric(hosp[[outcome_table_name]]),hosp$Hospital.Name),]
        # check num
        if (num =="best") {
            number<-1
        } else if (num=="worst") {
            number<-nrow(subset(hosp_ord,!is.na(as.numeric(hosp_ord[[outcome_table_name]]))))
        } else if (!is.numeric(num)) {
            stop("Invalid num!")
        } else {
            number<-num
        }
    
        output_frame$hospital[i]<-hosp_ord$Hospital.Name[number]
        output_frame$state[i]<-state
        i<-i+1
    }
    
    
    ## For each state, find the hospital of the given rank
    
    output_frame
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
}