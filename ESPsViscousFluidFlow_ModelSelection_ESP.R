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
trainning<- as.vector(createDataPartition(rownames(All_viscous),times = 1,p = 0.75,list = TRUE)[[1]])
testing <- which(!rownames(All_viscous) %in% trainning)

# Store trainning and testing data
trainning_ddensity                   <-All_viscous[trainning,c(density_var,density_model_variables)]
trainning_viscosity_inlet            <-All_viscous[trainning,c(viscosity_inlet_var,viscosity_inlet_model_variables)]
trainning_outlet_model_variables     <-All_viscous[trainning,c(viscosity_outlet_var,viscosity_inlet_model_variables)]

# Store testibg and testing data
testing_ddensity                   <-All_viscous[testing,c(density_var,density_model_variables)]
testing_viscosity_inlet            <-All_viscous[testing,c(viscosity_inlet_var,viscosity_inlet_model_variables)]
testing_outlet_model_variables     <-All_viscous[testing,c(viscosity_outlet_var,viscosity_inlet_model_variables)]

# Convert data.frame to numeric
trainning_ddensity               <- data.frame(sapply(trainning_ddensity, function(x) as.numeric(as.character(x))))
trainning_viscosity_inlet        <- data.frame(sapply(trainning_viscosity_inlet, function(x) as.numeric(as.character(x))))
trainning_outlet_model_variables <- data.frame(sapply(trainning_outlet_model_variables, function(x) as.numeric(as.character(x))))

# Convert data.frame to numeric
testing_ddensity               <- data.frame(sapply(testing_ddensity, function(x) as.numeric(as.character(x))))
testing_viscosity_inlet        <- data.frame(sapply(testing_viscosity_inlet, function(x) as.numeric(as.character(x))))
testing_outlet_model_variables <- data.frame(sapply(testing_outlet_model_variables, function(x) as.numeric(as.character(x))))                                          
#########################################################################################################
# Basic Parameter Tuning
fitControl <- trainControl(method = "cv",
                           number = 100)

lm_Inlet.Density.ρi    <- train(Inlet.Density.ρi ~. , data = na.omit(trainning_ddensity),method = "lm", trControl = fitControl) 
lm_Inlet.Viscosity.mi  <- train(Inlet.Viscosity.mi~. , data = na.omit(trainning_viscosity_inlet),method = "lm", trControl = fitControl) 
lm_Outlet.Viscosity.mo <- train(Outlet.Viscosity.mo~. , data = na.omit(trainning_outlet_model_variables),method = "lm", trControl = fitControl) 
  
Inlet.Density_predicted         <- predict(lm_Inlet.Density.ρi,     na.omit(testing_ddensity))
Inlet.Viscosity_predicted       <- predict(lm_Inlet.Viscosity.mi,  na.omit(testing_viscosity_inlet))
Outlet.Viscosity_predicted      <- predict(lm_Outlet.Viscosity.mo,  na.omit(testing_outlet_model_variables))

cor(as.vector(Inlet.Density_predicted),na.omit(testing_ddensity)$Inlet.Density.ρi)
cor(as.vector(Inlet.Viscosity_predicted),na.omit(testing_viscosity_inlet)$Inlet.Viscosity.mi)
cor(as.vector(Outlet.Viscosity_predicted),na.omit(testing_outlet_model_variables)$Outlet.Viscosity.mo)

# Overall accuracy assessment
postResample(Inlet.Density_predicted    ,na.omit(testing_ddensity)$Inlet.Density.ρi)
postResample(Inlet.Viscosity_predicted  ,na.omit(testing_viscosity_inlet)$Inlet.Viscosity.mi)
postResample(Outlet.Viscosity_predicted ,na.omit(testing_outlet_model_variables)$Outlet.Viscosity.mo)
