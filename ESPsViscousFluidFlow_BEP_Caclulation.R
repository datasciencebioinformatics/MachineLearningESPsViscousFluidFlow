##############################################################################################
# Take unique values of viscosity, equipment and rpm
unique_viscosity <-sort(unique(as.numeric(merge_water_viscous$Inlet.Viscosity)))
unique_equipment <-sort(unique(merge_water_viscous$equip))
unique_rpm <-sort(unique(merge_water_viscous$RPM))
unique_fluid <-sort(unique(merge_water_viscous$fluid))

# Generate test matrix as data.frame
df_test_matrix<-expand.grid(unique_rpm,unique_equipment,unique_viscosity,unique_fluid)

# Rename collumns
colnames(df_test_matrix)<-c("RPM","equip","viscosity","fluid")

# Add collumn for BEP
df_test_matrix$BEP<-NA

# For each combination of test
for (condition_id in rownames(df_test_matrix))
{
  # Subset data from specific condition of test matrix
  condition_water_viscous<-merge_water_viscous[which(as.numeric(merge_water_viscous$RPM) == df_test_matrix[condition_id,"RPM"] & merge_water_viscous$equip == df_test_matrix[condition_id,"equip"]  & as.numeric(df_test_matrix[condition_id,"viscosity"]) == merge_water_viscous$Inlet.Viscosity  & merge_water_viscous$fluid == df_test_matrix[condition_id,"fluid"]),]

  # If condition_water_viscous not empty
  if(dim(condition_water_viscous)[1]>=1)
  {
    # The best efficient point will be calculated fro each configuration in the test matrix
    # Fit a curve for Qxn
    fit <- lm(condition_water_viscous$Q ~ poly(condition_water_viscous$n, 5, raw=TRUE))
    
    # Find maximum value
    BEP_Q<-max(fit$fitted.values)
    
    # Store best efficient point
    df_test_matrix[condition_id,"BEP"]<-BEP_Q   
  }
}
# Omit na
df_test_matrix<-na.omit(df_test_matrix)

# Convert to factor
df_test_matrix$viscosity<-as.factor(df_test_matrix$viscosity)

# Basic box plot
png(filename=paste(project_folder,"Best_Efficient_Point_RPM3000.png",sep=""), width = 20, height = 20, res=600, units = "cm")  
  ggplot(df_test_matrix[df_test_matrix$RPM==3000 & df_test_matrix$fluid=="Glycerin",], aes(x=viscosity, y=BEP)) +geom_boxplot()  + theme_bw() + ggtitle("RPM 3000, Glycerin")+ theme(axis.text.x = element_text(angle = 90)) + facet_wrap(vars(equip), nrow = 3, scales="free")
dev.off()

