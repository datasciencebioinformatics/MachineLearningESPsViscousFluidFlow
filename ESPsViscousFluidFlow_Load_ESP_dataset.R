#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
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
#########################################################################################################
# Path to metadata file
metada_data_file="eps_metada.xlsx"

# Load the metada file
metada_data<-data.frame(read_excel(paste(project_folder,metada_data_file,sep=""),skip=1))

# Split data.frame into RPM and rads
metada_data_rpm <-cbind(metada_data[,c(1,2,3,4,5,6)],Metric="RPM")
metada_data_rads<-cbind(metada_data[,c(1,2,7,8,9,10)],Metric="rads")

# Split data.frame into RPM and rads
colnames(metada_data_rpm)<-c("model","Impeller.diameter","1800","2400","3000","3500","Metric")
colnames(metada_data_rads)<-c("model","Impeller.diameter","1800","2400","3000","3500","Metric")

# Compile metada data
metada_data<-rbind(metada_data_rpm,metada_data_rads)
#########################################################################################################
# Rename Shaft.Torque
colnames(All_viscous)[9]<-"Shaft.Torque"

# Calculate water density at inlet temperature
t = as.numeric(All_water$Inlet.Temperature.T1)
# p = (999.83952 + 16.945176*(t) - 7.9870401*(10^-3)*(t^2) - 46.170461*(10^-6)*(t^3) + 105.56302*(10^-9)*(t^4) - 280.54253 * (10^-12)*(t^5)) / (1 + 16.897850 * (10^-3)*(t))
p  = dens(T = as.numeric(All_water$Inlet.Temperature.T1), units = 'SI')
mu = dvisc(T = as.numeric(All_water$Inlet.Temperature.T1), units = 'SI')*1000

# Add collumns for viscosities in water. 
# Star values as -1
All_water$Inlet.Viscosity.mi  <- mu
All_water$Outlet.Viscosity.mo <- mu

# Inlet.Density.ρi
All_water$Inlet.Density.ρi<-p

# Colnames
common_varibles<-colnames(All_viscous)[which(colnames(All_viscous) %in% colnames(All_water))]

# Merge tables
merge_water_viscous<-rbind(All_water[,common_varibles],All_viscous[,common_varibles])
##################################################################################################
# Remove water samples
merge_water_viscous<-na.omit(merge_water_viscous[merge_water_viscous$fluid != "water",])
##################################################################################################


