# read lables
# just in case something has to be set setwd("./Assignments/UCI HAR Dataset")
features<-read.table("./features.txt", stringsAsFactors=FALSE)
# keep only feature names
features<-features$V2
# reading separate feature data sets
X_test<-read.table("./test/X_test.txt", col.names=features, stringsAsFactors=FALSE)
X_train<-read.table("./train/X_train.txt", col.names=features, stringsAsFactors=FALSE)
# feature - merge vertically
X_data<-rbind(X_train, X_test)
# adding index for inner join
X_data$index<-c(1:nrow(X_data))

# reading separate Activity data sets
activity_train<-read.table("./train/y_train.txt", strings=FALSE)
activity_test<-read.table("./test/y_test.txt", strings=FALSE)
#activity - merge verically
activity<-rbind(activity_train, activity_test)
# adding name
names(activity)<-"activity"
# adding index for inner join
activity$index<-c(1:nrow(activity))

#reading separate subject data sets
subject_train<-read.table("./train/subject_train.txt", strings=FALSE)
subject_test<-read.table("./test/subject_test.txt", strings=FALSE)
#subject - merge vertically
subject<-rbind(subject_train, subject_test)
# adding name
names(subject)<-"subject"
# adding index for inner join
subject$index<-c(1:nrow(subject))

#add activity to global data set using a different method
X_all<-merge(X_data, activity, by="index")

#add subject to global data set
X_all<-merge(X_all, subject, by="index")


# clean-up including index in X_data, activity and subject data sets to keep the feature number under control
X_all$index<-NULL
X_data$index<-NULL
activity$index<-NULL
subject$index<-NULL

#give meaningful names to teh ovearall data set
names(X_all)<-c(features, "activity", "subject")

# extracting only the the measurements on the mean and standard deviation
# adding mean
X_data_reduced<-X_all[,grep("*mean*", colnames(X_all))]
# adding std
X_data_reduced<-cbind(X_data_reduced, X_all[,grep("*std*", colnames(X_all))])
# adding activity and proper name
X_data_reduced<-cbind(X_data_reduced, X_all[,grep("*activity*", colnames(X_all))])
names(X_data_reduced)[ncol(X_data_reduced)]<-"activity"
#adding subject and proper name
X_data_reduced<-cbind(X_data_reduced, X_all[,grep("*subject*", colnames(X_all))])
names(X_data_reduced)[ncol(X_data_reduced)]<-"subject"

#build activity labels
activity_label<-read.table("./activity_labels.txt", strings=FALSE)
activity_label<-activity_label$V2

#replace headers with meaningful values for activity
j<-1
for (j in seq_along(activity_label)) {
    X_data_reduced$activity<-gsub(j, activity_label[j], X_data_reduced$activity)
}

#produce tidy data set depending on activity and subject
X_data_reduced$subject<-as.factor(X_data_reduced$subject)
tmp<-X_data_reduced[0,]
for (j in seq_along(levels(X_data_reduced$subject))) { 
    for (i in seq_along(activity_label)) {
        tmp[nrow(tmp)+1,]<-sapply(X_data_reduced[(X_data_reduced$activity==activity_label[i] & X_data_reduced$subject==j),], mean)
        tmp[nrow(tmp), "activity"]<-activity_label[i]
        tmp[nrow(tmp), "subject"]<-j
    }
}
# write the output file
write.table(tmp, file="./Clean_data_project.txt", row.name=FALSE)
