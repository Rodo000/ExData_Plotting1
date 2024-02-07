library(dplyr)

hh <- read.csv("household_power_consumption.txt", sep = ";")
days <- which(hh$Date == "1/2/2007" | hh$Date == "2/2/2007")
hh2 <- slice(hh, days)
hh2$Global_active_power <- as.numeric(hh2$Global_active_power)

hh2$Global_active_power <- as.numeric(hh2$Global_active_power)
hh2$Date <- as.Date(hh2$Date, format = "%d/%m/%Y")
hh2$DateTime <- paste(hh2$Date, hh2$Time)
hh2$DateTime <- as.POSIXct(hh2$DateTime, format = "%Y-%m-%d %H:%M:%S")
hh2$Global_active_power[hh2$Global_active_power == "?"] <- NA

hh2$Sub_metering_1 <- as.numeric(hh2$Sub_metering_1)
hh2$Sub_metering_2 <- as.numeric(hh2$Sub_metering_2)
hh2$Sub_metering_3 <- as.numeric(hh2$Sub_metering_3)

hh2$Voltage <- as.numeric(hh2$Voltage)
hh2$Global_reactive_power <- as.numeric(hh2$Global_reactive_power)

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

#a
plot(hh2$DateTime, hh2$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
date_range <- range(hh2$DateTime)
axis(1, at = c(date_range[1], date_range[1] + 86400, date_range[2]), labels = c("Thu", "Fri", "Sat"))

#b
plot(hh2$DateTime, hh2$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(1, at = c(date_range[1], date_range[1] + 86400, date_range[2]), labels = c("Thu", "Fri", "Sat"))

#c
plot(hh2$DateTime, hh2$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(hh2$DateTime, hh2$Sub_metering_2, col = "red")
lines(hh2$DateTime, hh2$Sub_metering_3, col = "blue")
axis(1, at = c(date_range[1], date_range[1] + 86400, date_range[2]), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, cex = 0.6, bty = 'n')

#d
plot(hh2$DateTime, hh2$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(1, at = c(date_range[1], date_range[1] + 86400, date_range[2]), labels = c("Thu", "Fri", "Sat"))

dev.off()