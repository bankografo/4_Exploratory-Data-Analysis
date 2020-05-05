###-----
# Plot 4  
###-----

library("data.table")
Sys.setlocale("LC_ALL","English") #https://stat.ethz.ch/R-manual/R-devel/library/base/html/locales.html

### Read data from txt file
Data_power <- data.table::fread(input = "data/household_power_consumption.txt"
                                , na.strings="?"
)

### Prevent scientific notation
Data_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

### Change time format
Data_power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

### Chose dates: 2007-02-01 and 2007-02-02
Data_power <- Data_power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

### Create "Plot 4" and save it to png file

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Chart 1
plot(Data_power[, dateTime], Data_power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Chart 2
plot(Data_power[, dateTime],Data_power[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Chart 3
plot(Data_power[, dateTime], Data_power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(Data_power[, dateTime], Data_power[, Sub_metering_2], col="red")
lines(Data_power[, dateTime], Data_power[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), 
       lty=c(1,1), 
       bty="n", 
       cex=.5
       ) 

# Chart 4
plot(Data_power[, dateTime], 
     Data_power[,Global_reactive_power], 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power"
     )

dev.off()



