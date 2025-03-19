#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
#########################################################################################################
# Set the project folder 
project_folder="/home/felipe/Documents/MachineLearningESPsViscousFluidFlow/"                            # With access to the google driver
#########################################################################################################
# For each sample, the data will be loaded by all rotational speed 
# First, the P100 in water samples
P100_viscous_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9)),RPM="2400")
P100_viscous_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9)),RPM="3000")
P100_viscous_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9)),RPM="3500")

# Second, the P62 in water samples
P62_viscous_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9)),RPM="2400")
P62_viscous_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9)),RPM="3000")
P62_viscous_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9)),RPM="3500")

# Third, the P47 in water samples
P47_viscous_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9)),RPM="2400")
P47_viscous_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9)),RPM="3000")
P47_viscous_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9)),RPM="3500")

# Fourh, the P37 in water samples
P37_viscous_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9)),RPM="2400")
P37_viscous_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9)),RPM="3000")
P37_viscous_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9)),RPM="3500")

# Fifth, the P37 in water samples
HC10000_viscous_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_viscous.xlsx",sep=""), sheet = "1800 rpm",skip = 9)),RPM="1800")
HC10000_viscous_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9)),RPM="2400")
HC10000_viscous_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9)),RPM="3000")

# Sixthh, the P37 in water samples
HC12500_viscous_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"HC12500_viscous.xlsx",sep=""), sheet = "1800 rpm",skip = 9)),RPM="1800")
HC12500_viscous_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"HC12500_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9)),RPM="2400")
HC12500_viscous_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"HC12500_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9)),RPM="3000")

# Bing all sheets for P100_viscous
P100_viscous<-cbind(rbind(P100_viscous_2400_data[-1,],P100_viscous_3000_data[-1,],P100_viscous_3500_data[-1,]),equip="P100")
P62_viscous <-cbind(rbind(P62_viscous_2400_data[-1,],P62_viscous_3000_data[-1,],P62_viscous_3500_data[-1,]),equip="P62")
P47_viscous <-cbind(rbind(P47_viscous_2400_data[-1,],P47_viscous_3000_data[-1,],P47_viscous_3500_data[-1,]),equip="P47")
P37_viscous <-cbind(rbind(P37_viscous_2400_data[-1,],P37_viscous_3000_data[-1,],P37_viscous_3500_data[-1,]),equip="P37")
HC10000_viscous <-cbind(rbind(HC10000_viscous_1800_data[-1,],HC10000_viscous_2400_data[-1,],HC10000_viscous_3000_data[-1,]),equip="HC10000")
HC12500_viscous <-cbind(rbind(HC12500_viscous_1800_data[-1,],HC12500_viscous_2400_data[-1,],HC12500_viscous_3000_data[-1,]),equip="HC12500")

# Merge all viscous
All_viscous<-rbind(P100_viscous,P62_viscous,P47_viscous,P37_viscous,HC10000_viscous,HC12500_viscous)
#########################################################################################################
# First, the P100 in water samples
#P100_water_1200_data <-cbind(data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1200 rpm",skip = 7)),RPM="1200")
P100_water_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7)),RPM="1800")
P100_water_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "2400 rpm",skip = 7)),RPM="2400")
P100_water_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3000 rpm",skip = 7)),RPM="3000")
P100_water_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3500 rpm",skip = 7)),RPM="3500")

#P62_water_1200_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "1200 rpm",skip = 7)),RPM="1200")
P62_water_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7)),RPM="1800")
P62_water_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "2400 rpm",skip = 7)),RPM="2400")
P62_water_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "3000 rpm",skip = 7)),RPM="3000")
P62_water_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "3500 rpm",skip = 7)),RPM="3500")

#P47_water_1200_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "1200 rpm",skip = 7)),RPM="1200")
P47_water_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7)),RPM="1800")
P47_water_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "2400 rpm",skip = 7)),RPM="2400")
P47_water_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "3000 rpm",skip = 7)),RPM="3000")
P47_water_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "3500 rpm",skip = 7)),RPM="3500")

#P37_water_1200_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "1200 rpm",skip = 7)),RPM="1200")
P37_water_1800_data <-  cbind(data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7)),RPM="1800")
P37_water_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "2400 rpm",skip = 7)),RPM="2400")
P37_water_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "3000 rpm",skip = 7)),RPM="3000")
P37_water_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "3500 rpm",skip = 7)),RPM="3500")

#HC10000_water_1200_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9)),RPM="1200")
HC10000_water_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7)),RPM="1800")
HC10000_water_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "2400 rpm",skip = 7)),RPM="2400")
HC10000_water_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3000 rpm",skip = 7)),RPM="3000")
HC10000_water_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3500 rpm",skip = 7)),RPM="3500")

#HC12500_water_1200_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1200 rpm",skip = 7)),RPM="1200")
HC12500_water_1800_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7)),RPM="1800")
HC12500_water_2400_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "2400 rpm",skip = 7)),RPM="2400")
HC12500_water_3000_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3000 rpm",skip = 7)),RPM="3000")
HC12500_water_3500_data <- cbind(data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3500 rpm",skip = 7)),RPM="3500")

# Bing all sheets for P100_viscous
P100_water<-cbind(rbind(P100_water_1800_data[-1,],P100_water_2400_data[-1,],P100_water_3000_data[-1,],P100_water_3500_data[-1,]),equip="P100")
P62_water<-cbind(rbind(P62_water_1800_data[-1,],P62_water_2400_data[-1,],P62_water_3000_data[-1,],P62_water_3500_data[-1,]),equip="P62")
P47_water<-cbind(rbind(P47_water_1800_data[-1,],P47_water_2400_data[-1,],P47_water_3000_data[-1,],P47_water_3500_data[-1,]),equip="P47")
P37_water<-cbind(rbind(P37_water_1800_data[-1,],P37_water_2400_data[-1,],P37_water_3000_data[-1,],P37_water_3500_data[-1,]),equip="P37")
HC10000_water<-cbind(rbind(HC10000_water_1800_data[-1,],HC10000_water_2400_data[-1,],HC10000_water_3000_data[-1,],HC10000_water_3500_data[-1,]),equip="HC10000")
HC12500_water<-cbind(rbind(HC12500_water_1800_data[-1,],HC12500_water_2400_data[-1,],HC12500_water_3000_data[-1,],HC12500_water_3500_data[-1,]),equip="HC12500")


# Merge all water
All_water<-rbind(P100_water,P47_water,P37_water,P62_water,HC10000_water,HC12500_water)

# Colnames
common_varibles<-colnames(All_viscous)[which(colnames(All_viscous) %in% colnames(All_water))]

# Merge tables
merge_water_viscous<-rbind(All_water[,common_varibles],All_viscous[,common_varibles])

# Melt water_viscous
melt_water_viscous<-melt(merge_water_viscous,id.vars=c("id","fluid","RPM","replicate"))

# Basic density
p <- ggplot(melt_water_viscous, aes(x=value,fill=fluid)) + geom_density(alpha=0.4) + facet_grid(vars(variable, RPM), scales="free") 


Rchrgit

