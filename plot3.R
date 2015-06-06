library(ggplot2)
library(reshape2)

library(dplyr)

tab5rows <- read.table("household_power_consumption.txt", sep=";" ,header = TRUE, nrows = 5)
classes <- sapply(tab5rows, class)
tabAll <- read.table("household_power_consumption.txt", sep=";", header = TRUE, colClasses = classes, nrows = 200000, na.strings = "?")
tabAll <- mutate(tabAll, DateTime = paste(tabAll$Date, tabAll$Time, sep =","))


tabAll$DateTime <- strptime(tabAll$DateTime, format="%d/%m/%Y,%H:%M:%S")
subset <- (as.Date(tabAll$DateTime) < as.Date("2007-02-03"))
subsetFeb <- tabAll[subset,]
subset2 <- (as.Date(subsetFeb$DateTime) > as.Date("2007-01-31"))
df <- subsetFeb[subset2,]

with(df, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab="Energy sub metering"))
with(df, lines(DateTime, Sub_metering_1, col = "black"))
with(df, lines(DateTime, Sub_metering_2, col = "red"))
with(df, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))