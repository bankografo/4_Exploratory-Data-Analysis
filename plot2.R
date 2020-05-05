###-----
# Plot 2
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

### Create "Plot 2" and save it to png file

png("plot2.png", width=480, height=480)

plot(x = Data_power[, dateTime], 
     y = Data_power[, Global_active_power], 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kiloWatts)"
     )

dev.off()