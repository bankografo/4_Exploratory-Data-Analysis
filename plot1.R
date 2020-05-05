###-----
# Plot 1
###-----

library("data.table")
Sys.setlocale("LC_ALL","English") #https://stat.ethz.ch/R-manual/R-devel/library/base/html/locales.html

### Read data from txt file
Data_power <- data.table::fread(input = "data/household_power_consumption.txt"
                             , na.strings="?"
                             )

### Prevent scientific notation
Data_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

### Change dates to Date Type
Data_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

### Chose dates: 2007-02-01 and 2007-02-02
Data_power <- Data_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

### Create "Plot 1" and save it to png file
png("plot1.png", width=480, height=480)

hist(Data_power[, Global_active_power], 
     main="Global Active Power", 
     xlab="Global Active Power (kiloWatts)", 
     ylab="Frequency", 
     col="Red"
     )

dev.off()