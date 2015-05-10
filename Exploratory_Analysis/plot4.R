# data file is in the same working directory with the script
# file containing graphics will be generated also in the same working directory 

library("lubridate")

# save default graphical parameters
default_par<-par()

t_initial<-dmy_hms("01/02/2007 00:00:00")
t_final<-dmy_hms("02/02/2007 23:59:00")

# get some needed info about the dataset
tab_r1<-read.table("household_power_consumption.txt", sep=";", header=TRUE, nrows = 1)
# iddentify classes for a faster readibg
classes<-sapply(tab_r1, class)
# identify date and time of first record to use as time origin
t_zero<-dmy_hms(paste(tab_r1[[1]], tab_r1[[2]]))

# read only the interesting data
tab_data<-read.table("household_power_consumption.txt", sep=";", colClasses=classes, comment.char="",
                 nrows = (t_final-t_initial)/eminutes(1), 
                 skip=(t_initial-t_zero)/eminutes(1)+1, na.strings="?")
colnames(tab_data)<-colnames(tab_r1)

#graphics

#
# multiple graphics
par(mfrow=c(2,2))
#active power
plot(strptime(paste(tab_data$Date,tab_data$Time), format="%d/%m/%Y %H:%M:%S"), tab_data$Global_active_power, 
     type = "l", 
     ylab="Global Active Power", 
     xlab="")

# voltage
plot(strptime(paste(tab_data$Date,tab_data$Time), format="%d/%m/%Y %H:%M:%S"), tab_data$Voltage, 
     type = "l", 
     ylab="Voltage", 
     xlab="datetime")

# submetering
plot(strptime(paste(tab_data$Date,tab_data$Time), format="%d/%m/%Y %H:%M:%S"), tab_data$Sub_metering_1, 
     type = "l", 
     ylab="Energy sub metering", 
     xlab="")
lines(strptime(paste(tab_data$Date,tab_data$Time), format="%d/%m/%Y %H:%M:%S"), tab_data$Sub_metering_2, 
      col="red")
lines(strptime(paste(tab_data$Date,tab_data$Time), format="%d/%m/%Y %H:%M:%S"), tab_data$Sub_metering_3, 
      col="blue")

# reactive power
plot(strptime(paste(tab_data$Date,tab_data$Time), format="%d/%m/%Y %H:%M:%S"), tab_data$Global_reactive_power, 
     type = "l", 
     ylab="Global_reactive_power", 
     xlab="datetime")

# creating file
dev.copy(png, file="plot4.png")
dev.off()

# restore graphical parametres to default
# ignore the warnings
par(default_par)
