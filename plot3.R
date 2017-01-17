


#Loading the first row of the data - just to save the header
one_row<- read.table(file = "./data/household_power_consumption.txt", sep= ";", nrows = 1, header=TRUE, stringsAsFactors = FALSE)

#Loading the interesting part of the file (I roughly checked where needed rows start - we will load with some margins and filter then)
df<- read.table(file = "./data/household_power_consumption.txt", sep= ";", skip=66600, nrows = 4000, header=FALSE, stringsAsFactors = FALSE, na.strings = "?")

names(df) <- names(one_row)

#selecting only required rows
df<-df[df$Date == "1/2/2007" | df$Date == "2/2/2007",] 

#Concatenating Date and Time and saving in POSIXlt format
df$Date<- strptime(x= paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

#setting locale to english to have english weekdays names
#Sys.setlocale("LC_TIME", "English")

#openign png graphic device
png(filename= "plot3.png")

#drawing chart
plot(x=df$Date, y=df$Global_active_power, xlab="",  ylab = "Energy sub metering", type="n", ylim = c(0,38))
lines(x=df$Date, y=df$Sub_metering_1, col = "black")
lines(x=df$Date, y=df$Sub_metering_2, col = "red")
lines(x=df$Date, y=df$Sub_metering_3, col = "blue")
legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#closing graphic device
dev.off()