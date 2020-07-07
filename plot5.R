# load library
library("dplyr")

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

png(filename = "plot5.png",width = 480,height = 480)

NEI %>% filter(fips == "24510" & type == "ON-ROAD") %>% with(tapply(Emissions,year,FUN = sum)) %>%  barplot(ylab = "Amount of PM2.5 emitted (tons)", xlab = "Year", main = "Total Emissions in Baltimore City by Vehicle Related Source")

dev.off()

