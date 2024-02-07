library(dplyr)
par(mfrow = c(1,1))

hh <- read.csv("household_power_consumption.txt", sep = ";")
days <- which(hh$Date == "1/2/2007" | hh$Date == "2/2/2007")
hh2 <- slice(hh, days)
hh2$Global_active_power <- as.numeric(hh2$Global_active_power)

png("plot1.png", width=480, height=480)
hist(hh2$Global_active_power, , main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()