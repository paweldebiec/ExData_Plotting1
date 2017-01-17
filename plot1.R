
#Downloading and unziping data ()
#if(!file.exists(".\\data")) dir.create(".\\data")
#fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(fileUrl,destfile="./data/HouseholdPowerConsumption.zip")
#unzip(zipfile="./data/HouseholdPowerConsumption.zip",exdir=".\\data")




#Loading the first row of the data - just to save the header
one_row<- read.table(file = "./data/household_power_consumption.txt", sep= ";", nrows = 1, header=TRUE, stringsAsFactors = FALSE)

#Loading the interesting part of the file (I roughly checked where needed rows start - we will load with some margins and filter then)
df<- read.table(file = "./data/household_power_consumption.txt", sep= ";", skip=66600, nrows = 4000, header=FALSE, stringsAsFactors = FALSE, na.strings = "?")

names(df) <- names(one_row)

#selecting only required rows
df<-df[df$Date == "1/2/2007" | df$Date == "2/2/2007",] 

#Concatenating Date and Time and saving in POSIXlt format
df$Date<- strptime(x= paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

#openign png graphic device
png(filename= "plot1.png")

#drawing histogram
hist(x=df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#closing graphic device
dev.off()