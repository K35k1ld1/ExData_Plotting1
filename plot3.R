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

plot(datasub$DateTime, datasub$Sub_metering_1, type = "l", col ="Black", main = "", xlab = "", ylab = "Energy sub metering")
points(datasub$DateTime, datasub$Sub_metering_2, type = "l", col = "Red")
points(datasub$DateTime, datasub$Sub_metering_3, type = "l", col = "Blue")
legend("topright", lty = 1, col=c("Black", "Red", "Blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

dev.copy(device = png, file = "plot3.png", width = 480, height = 480)

dev.off()