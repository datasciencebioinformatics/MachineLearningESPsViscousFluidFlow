#########################################################################################################
# Store nome of analyzed variables
# Flow rate	Inlet Temperature T1 	Inlet Temperature T2 			Inlet Pressure P1	Outlet Pressure P2	Shaft Torque
variables<-variables<-c("Q","Inlet.Temperature.T1","Inlet.Temperature.T2","Inlet.Pressure.P1","Outlet.Pressure.P2","RPM","Shaft.Torque","Inlet.Density.ρi","n")

# Sub-select collumns
subselect_merge_water_viscous<-na.omit(merge_water_viscous[,variables])

# Converto numeric
subselect_merge_water_viscous <- data.frame(apply(subselect_merge_water_viscous, 2, function(x) as.numeric(as.character(x))))
#########################################################################################################
# Split into trainning and testing
trainning<- as.vector(createDataPartition(subselect_merge_water_viscous$n,times = 1,p = 0.5,list = TRUE)[[1]])
testing <- which(!rownames(subselect_merge_water_viscous) %in% trainning)

# Split into trainning and testing
# Store trainning and testing data
trainingControl_features<-subselect_merge_water_viscous[trainning,]

# Store trainning and testing data
trainning_features<-subselect_merge_water_viscous[trainning,]
testing_features  <-subselect_merge_water_viscous[testing,]
#########################################################################################################
# Basic Parameter Tuning
fitControl <- trainControl(number = 3)

# Train regression-like models
rf_viscous    <- train(n ~ ., data = trainning_features, method = "rf", trControl = fitControl)
lm_viscous    <- train(n ~ ., data = trainning_features, method = "lm", trControl = fitControl)
#########################################################################################################
resamps <- resamples(list(rf_viscous = rf_viscous, 
                          lm_viscous = lm_viscous))    
                                                  
# bwplo               
png(filename=paste(output_dir,"Plot_bwplot_results.png",sep=""), width = 25, height = 12, res=600, units = "cm")  
  bwplot(resamps, layout = c(3, 1),scales = list(x = list(relation = "free"),y = list(relation = "free")))
dev.off()
#########################################################################################################
# caclulate variable importance from the regresssion-like models
varImp_lm_viscous <- varImp(lm_viscous, scale = FALSE)
varImp_rf_viscous <- varImp(rf_viscous, scale = FALSE)

# Plot variable importance from the regression-like models
plot_lm_viscous<-plot(varImp_lm_viscous, main = "lm") 
plot_rf_viscous<-plot(varImp_rf_viscous, main = "rf")

# bwplot               
png(filename=paste(output_dir,"Variable_Importance_results.png",sep=""), width = 25, height = 25, res=600, units = "cm")  
  grid.arrange(plot_lm_viscous,plot_rf_viscous)
dev.off()
