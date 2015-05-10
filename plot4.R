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

par(mfrow = c(2,2), mar=c(4,4,1,2))
days$DateTime <- ymd_hms(paste(days$Date,days$Time))


# Plot 1
with(days,plot(DateTime,Global_active_power,type = "l",
         xlab = "", ylab = "Global Active Power (kilowatts)"))
    
# Plot 2
with(days,plot(DateTime,Voltage,type = "l",
         xlab = "DateTime", ylab = "Voltage"))
  
# Plot 3
### For the sub_metering plot, Tidy data first then plot the data
submeter <- select(days,DateTime,Sub_metering_1,Sub_metering_2,Sub_metering_3)
submelt <- melt(submeter,id=c("DateTime"),
                measure.cars=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(submelt, plot(DateTime,value,type = "n",ylab = "Energy sub metering"))
with(subset(submelt, variable == "Sub_metering_1"), 
     lines(DateTime, value, col = "black"),type = "l")
with(subset(submelt, variable == "Sub_metering_2"), 
     lines(DateTime, value, col = "red"),type = "l")
with(subset(submelt, variable == "Sub_metering_3"), 
     lines(DateTime, value, col = "blue"),type = "l")
legend("topright",lty = c(1,1,1), col = c("black","blue","red"), 
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       cex = 0.4)

# Plot 4
with(days, plot(DateTime,Global_reactive_power,type = "l",
         xlab = "DateTime", ylab = "Global Reactive Power"))
    
 
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot4.png")
dev.off()
    