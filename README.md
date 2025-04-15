#### 1) Set the project folder either on Linux or in Window
#### a) If in Linux 
project_folder="/home/felipe/Documents/MachineLearningESPsViscousFluidFlow/"

#### b) Or in Windows
project_folder="C:/Users/User/Documents/GitHub/MachineLearningESPsViscousFluidFlow/"

#### c) set outputfolder
output_dir=project_folder

#### 2) Load all packages
source(paste(project_folder,"ESPsViscousFluidFlow_Load_All_R_Packages.R",sep=""))

#### 3) Load ESP dataset from files
source(paste(project_folder,"ESPsViscousFluidFlow_Load_ESP_dataset.R",sep=""))

#### 4) Calculate the efficiency parameters (Efficiency, Head, Power)
source(paste(project_folder,"ESPsViscousFluidFlow_Parametrization.R",sep=""))

#### 5) Add the test matrix (RPM, equipment, visosity)
source(paste(project_folder,"ESPsViscousFluidFlow_TestMatrix_ESP.R",sep=""))

#### 6) Load ESP dataset from files
source(paste(project_folder,"ESPsViscousFluidFlow_Exploratory_ESP_dataset.R",sep=""))

#### 7) Assess regression-like models
source(paste(project_folder,"ESPsViscousFluidFlow_AssessModel.R",sep=""))

# TO DO: 
- Check Implementation till number 7
- Start implementation of BEP and correction factor 
#### 8) Calculate the BEP and correction Factors
source(paste(project_folder,"ESPsViscousFluidFlow_BEP_Caclulation.R",sep=""))
