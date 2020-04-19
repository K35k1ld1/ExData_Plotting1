urlfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlfile, destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")

data <- read.table("./household_power_consumption.txt", sep =";", header = TRUE, stringsAsFactors=FALSE, dec=".")

data$Date <- as.Date(data$Date, "%d/%m/%Y")

datasub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

datasub$DateTime <- strptime(paste(datasub$Date, datasub$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

datasub$Sub_metering_1 <- as.numeric(datasub$Sub_metering_1)
datasub$Sub_metering_2 <- as.numeric(datasub$Sub_metering_2)
datasub$Sub_metering_3 <- as.numeric(datasub$Sub_metering_3)
datasub$Global_active_power <- as.numeric(datasub$Global_active_power)
datasub$Global_reactive_power <- as.numeric(datasub$Global_reactive_power)
datasub$Voltage <- as.numeric(datasub$Voltage)

par(mfrow = c(2,2))

#1st graph (1,1)
plot(datasub$DateTime, datasub$Global_active_power, type = "l", col ="Black", main = "", xlab = "", ylab = "Global Active Power")

#2nd graph (1,2)
plot(datasub$DateTime, datasub$Voltage, type = "l", col ="Black", main = "", xlab = "datetime", ylab = "Voltage")

#3rd graph (2,1)
plot(datasub$DateTime, datasub$Sub_metering_1, type = "l", col ="Black", main = "", xlab = "", ylab = "Energy sub metering")
points(datasub$DateTime, datasub$Sub_metering_2, type = "l", col = "Red")
points(datasub$DateTime, datasub$Sub_metering_3, type = "l", col = "Blue")
legend("topright", lty = 1, bty = "n", cex = 0.5, col=c("Black", "Red", "Blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#4th graph (2,1)
plot(datasub$DateTime, datasub$Global_reactive_power, type = "l", col ="Black", main = "", xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(device = png, file = "plot4.png", width = 480, height = 480)

dev.off()