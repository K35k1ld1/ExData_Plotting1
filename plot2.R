urlfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(urlfile, destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")

data <- read.table("./household_power_consumption.txt", sep =";", header = TRUE, stringsAsFactors=FALSE, dec=".")

data$Date <- as.Date(data$Date, "%d/%m/%Y")

datasub <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

datasub$DateTime <- strptime(paste(datasub$Date, datasub$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

datasub$Global_active_power <- as.numeric(datasub$Global_active_power)

plot(datasub$DateTime, datasub$Global_active_power, type = "l", col ="Black", main = "", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.copy(device = png, file = "plot2.png", width=480, height=480)

dev.off()