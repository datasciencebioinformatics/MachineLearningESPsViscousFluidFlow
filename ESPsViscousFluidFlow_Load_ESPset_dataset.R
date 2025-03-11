#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
#########################################################################################################
# Set the project folder 
project_folder="/home/felipe/googledrive/MachineLearningFaultDetectionESP/"    # With access to the google driver
project_folder="C:/Users/Valter/Documents/dataset/"                            # Without acces to the google driver
#########################################################################################################
# For each sample, the data will be loaded by all rotational speed 
# First, the P100 in water samples (1800, 2400, 3000, 3500)
# Specify sheet by its name
p100_water_1800_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p100_water_2400_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p100_water_3000_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p100_water_3500_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Specify sheet by its name
p47_water_1800_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p47_water_2400_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p47_water_3000_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p47_water_3500_data <- data.frame(read_excel(paste(project_folder,"P47_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Specify sheet by its name
p37_water_1800_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p37_water_2400_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p37_water_3000_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p37_water_3500_data <- data.frame(read_excel(paste(project_folder,"P37_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Specify sheet by its name
p62_water_1800_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p62_water_2400_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p62_water_3000_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p62_water_3500_data <- data.frame(read_excel(paste(project_folder,"P62_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Specify sheet by its name
HC12500_water_1200_data <- data.frame(read_excel(paste(project_folder,"HC12500_water.xlsx",sep=""), sheet = "1200 rpm",skip = 8))
HC12500_water_1800_data <- data.frame(read_excel(paste(project_folder,"HC12500_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
HC12500_water_2400_data <- data.frame(read_excel(paste(project_folder,"HC12500_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
HC12500_water_3000_data <- data.frame(read_excel(paste(project_folder,"HC12500_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
HC12500_water_3500_data <- data.frame(read_excel(paste(project_folder,"HC12500_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Specify sheet by its name
HC10000_water_1800_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
HC10000_water_2400_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
HC10000_water_3000_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
HC10000_water_3500_data <- data.frame(read_excel(paste(project_folder,"HC10000_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Add the fluid to each table
p100_water_1800_data$sample<-"p100"
p100_water_2400_data$sample<-"p100"
p100_water_3000_data$sample<-"p100"
p100_water_3500_data$sample<-"p100"

p37_water_1800_data$sample<-"p37"
p37_water_2400_data$sample<-"p37"
p37_water_3000_data$sample<-"p37"
p37_water_3500_data$sample<-"p37"

p47_water_1800_data$sample<-"p47"
p47_water_2400_data$sample<-"p47"
p47_water_3000_data$sample<-"p47"
p47_water_3500_data$sample<-"p47"

p62_water_1800_data$sample<-"p62"
p62_water_2400_data$sample<-"p62"
p62_water_3000_data$sample<-"p62"
p62_water_3500_data$sample<-"p62"

HC12500_water_1200_data$sample<-"HC12500"
HC12500_water_1800_data$sample<-"HC12500"
HC12500_water_2400_data$sample<-"HC12500"
HC12500_water_3000_data$sample<-"HC12500"
HC12500_water_3500_data$sample<-"HC12500"

HC10000_water_1800_data$sample<-"HC10000"
HC10000_water_2400_data$sample<-"HC10000"
HC10000_water_3000_data$sample<-"HC10000"
HC10000_water_3500_data$sample<-"HC10000"

# Add the fluid to each table
p100_water_1800_data$rpm<-"1800"
p100_water_2400_data$rpm<-"2400"
p100_water_3000_data$rpm<-"3000"
p100_water_3500_data$rpm<-"3500"

p37_water_1800_data$rpm<-"1800"
p37_water_2400_data$rpm<-"2400"
p37_water_3000_data$rpm<-"3000"
p37_water_3500_data$rpm<-"3500"

p47_water_1800_data$rpm<-"1800"
p47_water_2400_data$rpm<-"2400"
p47_water_3000_data$rpm<-"3000"
p47_water_3500_data$rpm<-"3500"

p62_water_1800_data$rpm<-"1800"
p62_water_2400_data$rpm<-"2400"
p62_water_3000_data$rpm<-"3000"
p62_water_3500_data$rpm<-"3500"

HC12500_water_1200_data$rpm<-"1200"
HC12500_water_1800_data$rpm<-"1800"
HC12500_water_2400_data$rpm<-"2400"
HC12500_water_3000_data$rpm<-"3000"
HC12500_water_3500_data$rpm<-"3500"

HC10000_water_1800_data$rpm<-"1800"
HC10000_water_2400_data$rpm<-"2400"
HC10000_water_3000_data$rpm<-"3000"
HC10000_water_3500_data$rpm<-"3500"

# Bind all water samples
water_samples<-rbind(rbind(p100_water_1800_data,p100_water_2400_data,p100_water_3000_data,p100_water_3500_data),
rbind(p37_water_1800_data,p37_water_2400_data,p37_water_3000_data,p37_water_3500_data),
rbind(p47_water_1800_data,p47_water_2400_data,p47_water_3000_data,p47_water_3500_data),
rbind(p62_water_1800_data,p62_water_2400_data,p62_water_3000_data,p62_water_3500_data),
rbind(HC12500_water_1200_data,HC12500_water_1800_data,HC12500_water_2400_data,HC12500_water_3000_data,HC12500_water_3500_data),
rbind(HC10000_water_1800_data,HC10000_water_2400_data,HC10000_water_3000_data,HC10000_water_3500_data))

# Add fluid name to water samples
water_samples$fluid<-"water"

# Add table name to water samples
water_samples$table<-1
#########################################################################################################
# Specify sheet by its name
p100_fluid_1800_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p100_fluid_2400_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p100_water_3000_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p100_water_3500_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

#########################################################################################################
