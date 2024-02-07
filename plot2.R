library(dplyr)
par(mfrow = c(1,1))

hh <- read.csv("household_power_consumption.txt", sep = ";")
days <- which(hh$Date == "1/2/2007" | hh$Date == "2/2/2007")
hh2 <- slice(hh, days)
hh2$Global_active_power <- as.numeric(hh2$Global_active_power)

hh2$Global_active_power <- as.numeric(hh2$Global_active_power)
hh2$Date <- as.Date(hh2$Date, format = "%d/%m/%Y")
hh2$DateTime <- paste(hh2$Date, hh2$Time)
hh2$DateTime <- as.POSIXct(hh2$DateTime, format = "%Y-%m-%d %H:%M:%S")
hh2$Global_active_power[hh2$Global_active_power == "?"] <- NA

png("plot2.png", width=480, height=480)
plot(hh2$DateTime, hh2$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
date_range <- range(hh2$DateTime)
axis(1, at = c(date_range[1], date_range[1] + 86400, date_range[2]), labels = c("Thu", "Fri", "Sat"))
dev.off()
