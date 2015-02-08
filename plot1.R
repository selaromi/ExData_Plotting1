plot1 <- function() {
        
        if(!file.exists("data")){
                dir.create("data")
        }
        
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        file <- "data/power_consumption.zip"
        download.file(url = fileURL,destfile = file ,method = "curl")
        
        zipFileInfo <- unzip(file, list=TRUE)
        hpcData <- read.table(unz(file, as.character(zipFileInfo$Name)), header = TRUE, na.strings = "?",sep = ";")
        hpcData$Date <- as.Date(strptime(hpcData$Date,"%d/%m/%Y"))
        
        from <- as.Date("2007-02-01")
        to <- as.Date("2007-02-03")
        
        subsetHpc <- subset(x = hpcData,subset = hpcData$Date >= from & hpcData$Date < to)
        
        if(!file.exists("generated_charts")){
                dir.create("generated_charts")
        }
        
        png(
                "generated_charts/plot1.png",
                width     = 480,
                height    = 480,
                units     = "px"
        )       
        with(subsetHpc,hist(Global_active_power,
                            col = "red",
                            xlab = "Global Active Power (kilowatts)",
                            main = "Global Active Power"))
        dev.off()
}
