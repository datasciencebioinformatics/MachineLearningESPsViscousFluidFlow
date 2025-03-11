#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
#########################################################################################################
# Set the project folder 
project_folder="/home/felipe/googledrive/MachineLearningFaultDetectionESP/"    # With access to the google driver
project_folder="C:/Users/Valter/Documents/dataset/"                            # Without acces to the google driver

# List all excel files
# Specify sheet by its name
p100_water_1800_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "1800 rpm",skip = 8))
p100_water_2400_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "2400 rpm",skip = 8))
p100_water_3000_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3000 rpm",skip = 8))
p100_water_3500_data <- data.frame(read_excel(paste(project_folder,"P100_water.xlsx",sep=""), sheet = "3500 rpm",skip = 8))




# Load all excel files in the list
df.list <- lapply(file.list, read_excel)
#########################################################################################################
