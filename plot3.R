# load library
library(ggplot2)

# Read and download file
if(!file.exists("Data")){dir.create("Data")}
fileName <- "exdata_data_NEI_data.zip"
path <- getwd()
if(!file.exists(paste(path,"/Data","/",fileName,sep = ""))){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(url,destfile = paste(path,"/Data","/",fileName,sep = ""))
        unzip("./Data/exdata_data_NEI_data.zip",exdir = "./Data")
}

NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

# Plot and save the plot as png
BalCity <- subset(NEI,fips == "24510")

png(filename = "plot3.png",width = 480,height = 480)

g <- ggplot(BalCity,aes(factor(year),Emissions))
g + geom_bar(stat="identity") + facet_grid(.~type) + ylab("Amount of PM2.5 emitted (tons)") + xlab("year") + ggtitle("Total Emissions by years in Baltimore City by type")

dev.off()
