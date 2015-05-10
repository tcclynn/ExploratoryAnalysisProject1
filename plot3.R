library(dplyr)
library(lubridate)
library(reshape2)

power <- read.table("household_power_consumption.txt",
                    header = TRUE, sep = ";",
                    na.strings = "?", stringsAsFactors = FALSE)
power$Date <- as.Date(power$Date,format="%d/%m/%Y")

# filtered out required data
days <- filter(power,Date == "2007-02-01"|Date == "2007-02-02")
rm(power)

# set the global parameters
par(mfrow = c(1,1),mar = c(3,2,2,1))

# create a new column for datetime for plotting the data
days$DateTime <- ymd_hms(paste(days$Date,days$Time))

### Tidy data first then plot the data
submeter <- select(days,DateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3)
submelt <- melt(submeter,id=c("DateTime"),
                measure.cars=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

### Plot the data
with(submelt, plot(DateTime,value,type = "n",ylab = "Energy sub metering"))
with(subset(submelt, variable == "Sub_metering_1"), 
     lines(DateTime, value, col = "black"),type = "l")
with(subset(submelt, variable == "Sub_metering_2"), 
     lines(DateTime, value, col = "red"),type = "l")
with(subset(submelt, variable == "Sub_metering_3"), 
     lines(DateTime, value, col = "blue"),type = "l")
legend("topright",lty = c(1,1,1), col = c("black","blue","red"), 
     legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
     cex = 0.8)


# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
