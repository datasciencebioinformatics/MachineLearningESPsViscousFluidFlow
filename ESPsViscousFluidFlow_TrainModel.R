#########################################################################################################
# Store nome of analyzed variables
variables<-variables<-c("Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4","Inlet.Pressure.P1","Outlet.Pressure.P2","Shaft.Torque","Inlet.Density.ρi", "Outlet.Viscosity.mo", "fluid","RPM","equip","n" ,"H","BHP","Q","Inlet.Viscosity")

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
fitControl <- trainControl(number = 3)

# Train regression-like models
lm_viscous    <- train(n ~ ., data = subselect_merge_water_viscous, method = "lm", trControl = fitControl)
rf_viscous    <- train(n ~ ., data = subselect_merge_water_viscous, method = "rf", trControl = fitControl)

#########################################################################################################
# Resample models for comparisson
resamps <- resamples(list(lm_viscous = lm_viscous, 
                          rf_viscous = rf_viscous)) 

# Set up bwplot
theme1 <- trellis.par.get()
theme1$plot.symbol$col = rgb(.2, .2, .2, .4)
theme1$plot.symbol$pch = 16
theme1$plot.line$col = rgb(1, 0, 0, .7)
theme1$plot.line$lwd <- 2
trellis.par.set(theme1)

# bwplo               
png(filename=paste(output_dir,"Plot_bwplot_results.png",sep=""), width = 25, height = 12, res=600, units = "cm")  
  bwplot(resamps, layout = c(3, 1))
dev.off()
#########################################################################################################
# caclulate variable importance from the regresssion-like models
varImp_lm_viscous <- varImp(lm_viscous, scale = FALSE)
varImp_rf_viscous <- varImp(rf_viscous, scale = FALSE)

# Plot variable importance from the regression-like models
plot_lm_viscous<-plot(varImp_lm_viscous, main = "svmLinear") 
plot_rf_viscous<-plot(varImp_rf_viscous, main = "svmRadial")

# bwplot               
png(filename=paste(output_dir,"Variable_Importance_results.png",sep=""), width = 25, height = 25, res=600, units = "cm")  
  grid.arrange(plot_lm_viscous,plot_rf_viscous)
dev.off()
