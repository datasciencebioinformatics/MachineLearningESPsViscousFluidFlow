#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
#########################################################################################################
# Set the project folder 
project_folder="/home/felipe/googledrive/MachineLearningFaultDetectionESP/"    # With access to the google driver
project_folder="C:/Users/Valter/Documents/dataset/"                            # Without acces to the google driver

#########################################################################################################
# For each sample, the data will be loaded by all rotational speed 
# First, the P100 in water (1800, 2400, 3000, 3500)
# Take the colnames 
p100_water_colnames  <- t(data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 7,col_names = FALSE))[1:2,] ) 

# Specify sheet by its name
p100_water_1800_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p100_water_2400_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p100_water_3000_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p100_water_3500_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))

# Add a collumn to each table with the name of the sample
p100_water_1800_data$sample<-"p100_water"
p100_water_1800_data$sample<-"p100_water"
#########################################################################################################
