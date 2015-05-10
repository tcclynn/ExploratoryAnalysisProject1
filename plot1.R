library(dplyr)
library(lubridate)

power <- read.table("household_power_consumption.txt",
                    header = TRUE, sep = ";",
                    na.strings = "?", stringsAsFactors = FALSE)
power$Date <- as.Date(power$Date,format="%d/%m/%Y")

# use "filter" to get date with date 2007-02-01 and 2007-02-02
days <- filter(power,Date == "2007-02-01"|Date == "2007-02-02")

rm(power)

# Set the global parameters
par(mfrow = c(1,1),mar = c(5,4,4,2))

# build the histogram
hist(days$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col = "red" )

# Copy the hist from screen to file device
# Defaults for png is as follows: width = 480, height = 480, units = "px")
dev.copy(png, file = "./plot1.png")
dev.off()
