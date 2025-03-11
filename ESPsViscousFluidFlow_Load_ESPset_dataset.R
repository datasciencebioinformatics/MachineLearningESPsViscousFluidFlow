#########################################################################################################
# All the excel files in the project folder are loaded in this                                          #
#########################################################################################################
# Set the project folder 
project_folder="/home/felipe/googledrive/MachineLearningFaultDetectionESP/"    # With access to the google driver
project_folder="C:/Users/Valter/Documents/dataset/"                            # Without acces to the google driver

# List all excel files
file.list <- list.files(path =project_folder,patter='*.xlsx',full.names = TRUE)

# Load all excel files in the list
df.list <- lapply(file.list, read_excel)
#########################################################################################################
