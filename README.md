### 1) Set the project folder either on Linux or in Window
#### a) If in Linux 
project_folder="/home/felipe/Documents/MachineLearningESPsViscousFluidFlow/"

#### b) Or in Windows
project_folder="C:/Users/Valter/Documents/GitHub/MachineLearningESPsViscousFluidFlow/"

#### 2) Load all packages
source(paste(project_folder,"ESPsViscousFluidFlow_Load_All_R_Packages.R",sep=""))

#### 3) Load ESP dataset from files
source(paste(project_folder,"ESPsViscousFluidFlow_Load_ESP_dataset.R",sep=""))

#### 4) Load all packages
source(paste(project_folder,"ESPsViscousFluidFlow_Parametrization.R",sep=""))

#### 5) Load ESP dataset from files
source(paste(project_folder,"ESPsViscousFluidFlow_Exploratory_ESP_dataset.R",sep=""))
