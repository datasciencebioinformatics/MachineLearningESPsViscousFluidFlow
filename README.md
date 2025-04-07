### 1) Set the project folder either on Linux or in Window
#### a) If in Linux 
project_folder="/home/felipe/Documents/MachineLearningESPsViscousFluidFlow/"

#### b) Or in Windows
project_folder="C:/Users/Valter/Documents/GitHub/MachineLearningESPsViscousFluidFlow/"

#### 2) Load all packages
source(paste(project_folder,"ESPsViscousFluidFlow_Load_All_R_Packages.R",sep=""))

#### 3) Load ESP dataset from files
source(paste(project_folder,"ESPsViscousFluidFlow_Load_ESP_dataset.R",sep=""))

#### 4) Calculate the efficiency parameters (Efficiency, Head, Power)
source(paste(project_folder,"ESPsViscousFluidFlow_Parametrization.R",sep=""))

#### 5) Add the test matrix (RPM, equipment, visosity)
source(paste(project_folder,"ESPsViscousFluidFlow_TestMatrix_ESP.R",sep=""))

#### 6) Calculate the BEP
source(paste(project_folder,"ESPsViscousFluidFlow_BEP_Caclulation.R",sep=""))

#### 7) Load ESP dataset from files
source(paste(project_folder,"ESPsViscousFluidFlow_Exploratory_ESP_dataset.R",sep=""))

#### 8) Train regression-like models
source(paste(project_folder,"ESPsViscousFluidFlow_TrainModel.R",sep=""))
