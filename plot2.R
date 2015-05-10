library(dplyr)
library(lubridate)

power <- read.table("household_power_consumption.txt",
                    header = TRUE, sep = ";",
                    na.strings = "?", stringsAsFactors = FALSE)
power$Date <- as.Date(power$Date,format="%d/%m/%Y")

# filtered out required data
days <- filter(power,Date == "2007-02-01"|Date == "2007-02-02")
rm(power)

# set the global parameters
par(mfrow = c(1,1),mar = c(5,4,4,2))

# create a new column for datetime for plotting the data
days$DateTime <- ymd_hms(paste(days$Date,days$Time))
with(days,plot(DateTime,Global_active_power,type = "l"
               ,xlab = "", ylab = "Global Active Power (kilowatts)"))

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
