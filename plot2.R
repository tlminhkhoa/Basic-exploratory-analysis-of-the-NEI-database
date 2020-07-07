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
png(filename = "plot2.png",width = 480,height = 480)

BalCity <- subset(NEI,fips == "24510")
totalEmissionsOnYearBal<- with(BalCity,tapply(Emissions,year,FUN = sum))
barplot(totalEmissionsOnYearBal, xlab = "year", ylab = " Amount of PM2.5 emitted (tons)", main = "Total Emissions by years in Baltimore City")

dev.off()



