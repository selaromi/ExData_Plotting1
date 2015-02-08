plot3 <- function() {
        library(data.table)
        if(!file.exists("data")){
                dir.create("data")
        }
        
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        file <- "data/power_consumption.zip"
        download.file(url = fileURL,destfile = file ,method = "curl")
        zipFileInfo <- unzip(file,exdir = "data")
        hpcData <- fread(input = "data/household_power_consumption.txt", header = TRUE, na.strings = c("?"),sep = ";")
        hpcData$Date <- as.Date(strptime(hpcData$Date,"%d/%m/%Y"))
        
        from <- as.Date("2007-02-01")
        to <- as.Date("2007-02-03")
        
        subsetHpc <- subset(x = hpcData,subset = hpcData$Date >= from & hpcData$Date < to)
        
        subsetHpc$datetime<-as.POSIXct(as.POSIXct(paste(subsetHpc$Date,subsetHpc$Time), format="%Y-%m-%d %H:%M:%S"))
        
        if(!file.exists("generated_charts")){
                dir.create("generated_charts")
        }
        
        par(bg="transparent")
        png(
                "generated_charts/plot3.png",
                width     = 480,
                height    = 480,
                bg        = "transparent",
                units     = "px"
        )       
        with(subsetHpc,{
                plot(datetime,Sub_metering_1,type="l",ylab = "Energy sub metering",xlab = "",main = "")
                lines(datetime,Sub_metering_2, col="red")
                lines(datetime,Sub_metering_3, col="blue")
                legend("topright", col =c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),lty=1)
        })
        dev.off()
}
