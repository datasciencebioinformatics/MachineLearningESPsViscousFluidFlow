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
fitControl <- trainControl(method = "repeatedcv",
                           number = 10,
                           repeats = 10,
                           ## Estimate class probabilities
                           classProbs = TRUE)

knn_espset    <- train(n ~ ., data = subselect_merge_water_viscous, method = "knn", trControl = fitControl,metric="ROC")
mlp_espset    <- train(n ~ ., data = subselect_merge_water_viscous, method = "mlp", trControl = fitControl,metric="ROC")
dnn_espset    <- train(n ~ ., data = subselect_merge_water_viscous, method = "dnn", trControl = fitControl,metric="ROC")
glm_espset    <- train(n ~ ., data = subselect_merge_water_viscous, method = "glm", trControl = fitControl,metric="ROC")
#########################################################################################################
resamps <- resamples(list(svmLinear = svm_1_espset, 
                          svmRadial = svm_2_espset,
                          knn = knn_espset,
                          mlp=mlp_espset,
                          dnn=dnn_espset,                 
                          glm=glm_espset))                          
#########################################################################################################
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
svm_1_pred <- predict(svm_1_espset, testing_features) 
svm_2_pred <- predict(svm_2_espset, testing_features) 
knn_pred <- predict(knn_espset, testing_features) 
mlp_pred <- predict(mlp_espset, testing_features) 
dnn_pred <- predict(dnn_espset, testing_features) 
glm_pred <- predict(glm_espset, testing_features) 
#########################################################################################################
varImp_svm_1_espset <- varImp(svm_1_espset, scale = FALSE)
varImp_svm_2_espset <- varImp(svm_2_espset, scale = FALSE)
varImp_knn_espset   <- varImp(knn_espset, scale = FALSE)
varImp_mlp_espset   <- varImp(dnn_espset, scale = FALSE)
varImp_glm_espset   <- varImp(glm_espset, scale = FALSE)
varImp_dnn_espset   <- varImp(dnn_espset, scale = FALSE)

plot_varImp_svm_1_espset<-plot(varImp_svm_1_espset, main = "svmLinear") 
plot_varImp_svm_2_espset<-plot(varImp_svm_2_espset, main = "svmRadial") 
plot_varImp_mlp_espset<-plot(varImp_mlp_espset, main = "mlp") 
plot_varImp_knn_espset<-plot(varImp_knn_espset, main = "knn") 
plot_varImp_glm_espset<-plot(varImp_glm_espset, main = "glm") 
plot_varImp_dnn_espset<-plot(varImp_dnn_espset, main = "dnn") 

# bwplo               
png(filename=paste(output_dir,"Variable_Importance_results.png",sep=""), width = 25, height = 25, res=600, units = "cm")  
  grid.arrange(plot_varImp_svm_1_espset,plot_varImp_svm_2_espset,plot_varImp_mlp_espset,plot_varImp_knn_espset,plot_varImp_glm_espset,plot_varImp_dnn_espset)
dev.off()

#########################################################################################################
