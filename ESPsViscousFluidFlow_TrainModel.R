#########################################################################################################
# Store nome of analyzed variables
# Flow rate	Inlet Temperature T1 	Inlet Temperature T2 			Inlet Pressure P1	Outlet Pressure P2	Shaft Torque
# TO DO : 
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
rf_viscous            <- train(n ~ ., data = trainning_features, method = "rf", trControl = fitControl)            # randomForest                                  Ok
lm_viscous            <- train(n ~ ., data = trainning_features, method = "lm", trControl = fitControl)            # linear regresssion                            Ok      
rpart_viscous         <- train(n ~ ., data = trainning_features, method = "rpart", trControl = fitControl)         # Recursive Partitioning and Regression Trees   Ok
svmLinear_viscous     <- train(n ~ ., data = trainning_features, method = "svmLinear", trControl = fitControl)     # Support Vector Machines                       Ok
knn_viscous           <- train(n ~ ., data = trainning_features, method = "knn", trControl = fitControl)           # K-Nearest Neighbors (KNN)                     Ok
#########################################################################################################
resamps <- resamples(list(rf = rf_viscous, 
                          lm = lm_viscous,
                          rpart=rpart_viscous,
                          svmLinear=svmLinear_viscous,
                          knn=knn_viscous))    
                                                  
# bwplo               
png(filename=paste(output_dir,"Plot_bwplot_results.png",sep=""), width = 25, height = 12, res=600, units = "cm")  
  bwplot(resamps, layout = c(3, 1),scales = list(x = list(relation = "free"),y = list(relation = "free")))
dev.off()
#########################################################################################################
# caclulate variable importance from the regresssion-like models
varImp_rf_viscous    <- varImp(rf_viscous, scale = FALSE)
varImp_lm_viscous    <- varImp(lm_viscous, scale = FALSE)
varImp_rpart_viscous <- varImp(rpart_viscous, scale = FALSE)
varImp_knn_viscous   <- varImp(knn_viscous, scale = FALSE)
varImp_svm_viscous   <- varImp(svmLinear_viscous, scale = FALSE)
                                                  
                                                  
# Plot variable importance from the regression-like models
plot_lm_viscous   <-plot(varImp_lm_viscous, main = "lm") 
plot_rf_viscous   <-plot(varImp_rf_viscous, main = "rf")
plot_rpart_viscous<-plot(varImp_rpart_viscous, main = "rpart")
plot_knn_viscous  <-plot(varImp_knn_viscous, main = "knn")
plot_svm_viscous  <-plot(varImp_svm_viscous, main = "svmLinear")
                                                  
# bwplot               
png(filename=paste(output_dir,"Variable_Importance_results.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
  grid.arrange(plot_lm_viscous,plot_rf_viscous,plot_rpart_viscous,plot_knn_viscous, plot_svm_viscous)
dev.off()

#########################################################################################################
rf_viscous_prediction<-predict(rf_viscous , testing_features[,c("Q","Inlet.Temperature.T1","Inlet.Temperature.T2","Inlet.Pressure.P1","Outlet.Pressure.P2","RPM","Shaft.Torque","Inlet.Density.ρi")])
lm_viscous_prediction<-predict(lm_viscous , testing_features[,c("Q","Inlet.Temperature.T1","Inlet.Temperature.T2","Inlet.Pressure.P1","Outlet.Pressure.P2","RPM","Shaft.Torque","Inlet.Density.ρi")])
rpart_viscous_prediction<-predict(rpart_viscous , testing_features[,c("Q","Inlet.Temperature.T1","Inlet.Temperature.T2","Inlet.Pressure.P1","Outlet.Pressure.P2","RPM","Shaft.Torque","Inlet.Density.ρi")])
knn_viscous_prediction<-predict(knn_viscous , testing_features[,c("Q","Inlet.Temperature.T1","Inlet.Temperature.T2","Inlet.Pressure.P1","Outlet.Pressure.P2","RPM","Shaft.Torque","Inlet.Density.ρi")])
svm_viscous_prediction<-predict(svmLinear_viscous , testing_features[,c("Q","Inlet.Temperature.T1","Inlet.Temperature.T2","Inlet.Pressure.P1","Outlet.Pressure.P2","RPM","Shaft.Torque","Inlet.Density.ρi")])

                                                  

correlation_rf<-cor(testing_features$n,as.vector(rf_viscous_prediction))
correlation_rpart<-cor(testing_features$n,as.vector(rpart_viscous_prediction))
correlation_knn<-cor(testing_features$n,as.vector(knn_viscous_prediction))
correlation_lm<-cor(testing_features$n,as.vector(lm_viscous_prediction))
correlation_svm<-cor(testing_features$n,as.vector(svm_viscous_prediction))


# Store correlation values
df_correction_values<-data.frame(Method=c("rf","rpart","knn","lm","svm"),Correlation=c(correlation_rf,correlation_rpart,correlation_knn,correlation_lm,correlation_svm))
                                                
# bwplot               
png(filename=paste(output_dir,"Correlation_results.png",sep=""), width = 15, height = 15, res=600, units = "cm")  
  ggplot(df_correction_values, aes(x = Method, y = Correlation)) + geom_col(fill = "#0073C2FF") + geom_text(aes(label = round(Correlation,3)), vjust = -0.3) + theme_bw()
dev.off()
