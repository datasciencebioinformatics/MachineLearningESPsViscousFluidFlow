#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
#########################################################################################################
# Set the project folder 
project_folder="/home/felipe/Documents/MachineLearningESPsViscousFluidFlow/"                            # With access to the google driver
#########################################################################################################
# For each sample, the data will be loaded by all rotational speed 
# First, the P100 in water samples
P100_viscous_2400_data <- data.frame(read_excel(paste(project_folder,"P100_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P100_viscous_3000_data <- data.frame(read_excel(paste(project_folder,"P100_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P100_viscous_3500_data <- data.frame(read_excel(paste(project_folder,"P100_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

# Second, the P62 in water samples
P62_viscous_2400_data <- data.frame(read_excel(paste(project_folder,"P62_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P62_viscous_3000_data <- data.frame(read_excel(paste(project_folder,"P62_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P62_viscous_3500_data <- data.frame(read_excel(paste(project_folder,"P62_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

# Third, the P47 in water samples
P47_viscous_2400_data <- data.frame(read_excel(paste(project_folder,"P47_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P47_viscous_3000_data <- data.frame(read_excel(paste(project_folder,"P47_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P47_viscous_3500_data <- data.frame(read_excel(paste(project_folder,"P47_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

# Fourh, the P37 in water samples
P37_viscous_2400_data <- data.frame(read_excel(paste(project_folder,"P37_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P37_viscous_3000_data <- data.frame(read_excel(paste(project_folder,"P37_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P37_viscous_3500_data <- data.frame(read_excel(paste(project_folder,"P37_viscous.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

# Fifth, the P37 in water samples
HC10000_viscous_1800_data <- data.frame(read_excel(paste(project_folder,"HC10000_viscous.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
HC10000_viscous_2400_data <- data.frame(read_excel(paste(project_folder,"HC10000_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
HC10000_viscous_3000_data <- data.frame(read_excel(paste(project_folder,"HC10000_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9))

# Sixthh, the P37 in water samples
HC12500_viscous_1800_data <- data.frame(read_excel(paste(project_folder,"HC12500_viscous.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
HC12500_viscous_2400_data <- data.frame(read_excel(paste(project_folder,"HC12500_viscous.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
HC12500_viscous_3000_data <- data.frame(read_excel(paste(project_folder,"HC12500_viscous.xlsx",sep=""), sheet = "3000 rpm",skip = 9))

# Bing all sheets for P100_viscous
P100_viscous<-cbind(rbind(P100_viscous_2400_data[-1,],P100_viscous_3000_data[-1,],P100_viscous_3500_data[-1,]),equip="P100")
P62_viscous <-cbind(rbind(P62_viscous_2400_data[-1,],P62_viscous_3000_data[-1,],P62_viscous_3500_data[-1,]),equip="P62")
P47_viscous <-cbind(rbind(P47_viscous_2400_data[-1,],P47_viscous_3000_data[-1,],P47_viscous_3500_data[-1,]),equip="P47")
P37_viscous <-cbind(rbind(P37_viscous_2400_data[-1,],P37_viscous_3000_data[-1,],P37_viscous_3500_data[-1,]),equip="P37")
HC10000_viscous <-cbind(rbind(HC10000_viscous_1800_data[-1,],HC10000_viscous_2400_data[-1,],HC10000_viscous_3000_data[-1,]),equip="HC10000")
HC12500_viscous <-cbind(rbind(HC12500_viscous_1800_data[-1,],HC12500_viscous_2400_data[-1,],HC12500_viscous_3000_data[-1,]),equip="HC12500")
#########################################################################################################
# First, the P100 in water samples
#P100_water_1200_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9))
P100_water_1800_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
P100_water_2400_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P100_water_3000_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P100_water_3500_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

#P62_water_1200_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9))
P62_water_1800_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
P62_water_2400_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P62_water_3000_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P62_water_3500_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

#P47_water_1200_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9))
P47_water_1800_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
P47_water_2400_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P47_water_3000_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P47_water_3500_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

#P37_water_1200_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9))
P37_water_1800_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
P37_water_2400_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
P37_water_3000_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
P37_water_3500_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

#HC10000_water_1200_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9))
HC10000_water_1800_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
HC10000_water_2400_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
HC10000_water_3000_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
HC10000_water_3500_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

#HC12500_water_1200_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1200 rpm",skip = 9))
HC12500_water_1800_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1800 rpm",skip = 9))
HC12500_water_2400_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "2400 rpm",skip = 9))
HC12500_water_3000_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3000 rpm",skip = 9))
HC12500_water_3500_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3500 rpm",skip = 9))

