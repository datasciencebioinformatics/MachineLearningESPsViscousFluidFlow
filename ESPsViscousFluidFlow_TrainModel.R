# Store nome of analyzed variables
variables<-variables<-c("Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4","Inlet.Pressure.P1","Outlet.Pressure.P2","Shaft.Torque","Inlet.Density.ρi", "Inlet.Viscosity.mi", "Outlet.Viscosity.mo", "fluid","replicate","RPM","equip","P_h","n" ,"H","BHP","Q","Inlet.Viscosity")

# Sub-select collumns
subselect_merge_water_viscous<-na.omit(merge_water_viscous[,variables])
#########################################################################################################
# Split into trainning and testing
trainning<- as.vector(createDataPartition(subselect_merge_water_viscous$n,times = 1,p = 0.5,list = TRUE)[[1]])
testing <- which(!rownames(subselect_merge_water_viscous) %in% trainning)

# Split into trainning and testing
# Store trainning and testing data
trainingControl_features<-subselect_merge_water_viscous[trainning,]

# Store trainning and testing data
trainning_features<-subselect_merge_water_viscous[trainning,]
testing_features  <-subselect_merge_water_viscous[trainning,]
#########################################################################################################
# Basic Parameter Tuning
fitControl <- trainControl(number = 10,
                           repeats = 10)

lm_viscous    <- train(n ~ ., data = subselect_merge_water_viscous, method = "lm", trControl = fitControl)
rf_viscous    <- train(n ~ ., data = subselect_merge_water_viscous, method = "rf", trControl = fitControl)
#########################################################################################################
