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

#hist(df$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)",ylim=range(0:1200))
with(df, plot(df$DateTime,df$Global_active_power, type="l",ylab="Global Active Power (kilowatts)", xlab=""))

dev.copy(png, file ="plot2.png")
dev.off()