# load library
library("dplyr")
library("ggplot2")
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

png(filename = "plot6.png",width = 480,height = 480)

Bal_LA_VehicleEmiss <- NEI %>% filter(fips%in%c("24510","06037") & type == "ON-ROAD") %>% group_by(year,fips) %>% summarize(total_emission = sum(Emissions))

Bal_LA_VehicleEmiss$year <- factor(Bal_LA_VehicleEmiss$year)

Bal_LA_VehicleEmiss[Bal_LA_VehicleEmiss$fips == "06037",]$fips <- "LA"
Bal_LA_VehicleEmiss[Bal_LA_VehicleEmiss$fips == "24510",]$fips <- "Baltimore"
names(Bal_LA_VehicleEmiss)[2] <- "City"

ggplot(Bal_LA_VehicleEmiss,aes(year,total_emission,fill = City)) + geom_bar(stat="identity", position = "dodge")


dev.off()