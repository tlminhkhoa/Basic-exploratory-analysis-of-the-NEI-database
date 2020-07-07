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
png(filename = "plot4.png",width = 480,height = 480)


CoalRelated <- SCC[with(SCC,grep("Coal",EI.Sector)),]
CoalRelatedSCC <- unique(CoalRelated$SCC)
CoalRelatedNEI <- filter(NEI, SCC %in% CoalRelatedSCC)
with(CoalRelatedNEI,barplot(tapply(Emissions,year,FUN = sum),xlab = "year", ylab = " Amount of PM2.5 emitted (tons)", main = "Total Emissions Coal Related Source by years" ))

dev.off()