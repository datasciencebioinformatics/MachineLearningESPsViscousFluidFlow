# Variabels for "Inlet.Density.ρi" model
density_model_variables<-c("Flow.rate","Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4", "Average.Inlet.Temp.Tm.i", "Average.Outlet.Temp.Tm.o","Inlet.Pressure.P1", "Outlet.Pressure.P2", "Net.Shaft.Torque", "Inlet.Viscosity.mi",  "Outlet.Viscosity.mo", "RPM")

# Variabels for "Inlet.Viscosity.mi" model
viscosity_inlet_model_variables<-c("Flow.rate","Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4", "Average.Inlet.Temp.Tm.i", "Average.Outlet.Temp.Tm.o","Inlet.Pressure.P1", "Outlet.Pressure.P2", "Net.Shaft.Torque", "Inlet.Density.ρi",  "Outlet.Viscosity.mo", "RPM")

# Variabels for "Outlet.Viscosity.mo" model
viscosity_outlet_model_variables<-c("Flow.rate","Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4", "Average.Inlet.Temp.Tm.i", "Average.Outlet.Temp.Tm.o","Inlet.Pressure.P1", "Outlet.Pressure.P2", "Net.Shaft.Torque", "Inlet.Density.ρi", "Inlet.Viscosity.mi",  "Outlet.Viscosity.mo", "RPM")

# Save names of variables for density, viscosity_inlet and viscosity_outlet
density_var            <- "Inlet.Density.ρi" 
viscosity_inlet_var    <- "Inlet.Viscosity.mi"
viscosity_outlet_var   <- "Outlet.Viscosity.mo"
##################################################################################################
# Split into trainning and testing
trainning<- as.vector(createDataPartition(rownames(All_viscous),times = 1,p = 0.5,list = TRUE)[[1]])
testing <- which(!rownames(All_viscous) %in% trainning)


# Split into trainning and testing
# Store trainning and testing data
trainingControl_density          <-All_viscous[trainning,c(density_var,density_model_variables)]
trainingControl_viscosity_inlet  <-All_viscous[trainning,c(viscosity_inlet_var,viscosity_inlet_model_variables)]
viscosity_outlet_model_variables <-All_viscous[trainning,c(viscosity_outlet_var,viscosity_inlet_model_variables)]

# Store trainning and testing data
trainning_ddensity                   <-All_viscous[trainning,c(density_var,density_model_variables)]
trainning_viscosity_inlet            <-All_viscous[trainning,c(viscosity_inlet_var,viscosity_inlet_model_variables)]
trainning_outlet_model_variables     <-All_viscous[trainning,c(viscosity_outlet_var,viscosity_inlet_model_variables)]
#########################################################################################################
# Basic Parameter Tuning
fitControl <- trainControl(method = "cv",
                           number = 10,
                           repeats = 10)

ml_Inlet.Density.ρi <- train(RPM ~  Flow.rate , data = All_viscous,method = "lm", preProc = c("center")) 


svm_1_espset  <- train(Class ~ ., data = trainning_features, method = "svmLinear", trControl = fitControl,metric="ROC")
