# Take unique values of viscosity, equipment and rpm
unique_viscosity <-sort(unique(as.numeric(merge_water_viscous$Inlet.Viscosity)))
unique_equipment <-sort(unique(merge_water_viscous$equip))
unique_rpm <-sort(unique(merge_water_viscous$RPM))

# Generate test matrix as data.frame
df_test_matrix<-expand.grid(unique_rpm,unique_equipment,unique_viscosity)

# Rename collumns
colnames(df_test_matrix)<-c("RPM","equip","viscosity")

# Add collumn for BEP
df_test_matrix$BEP<-NA

# For each combination of test
for (condition_id in rownames(df_test_matrix))
{
  # Subset data from specific condition of test matrix
  condition_water_viscous<-merge_water_viscous[which(as.numeric(merge_water_viscous$RPM) == df_test_matrix[condition_id,"RPM"]  &  merge_water_viscous$equip == df_test_matrix[condition_id,"equip"]  & as.numeric(df_test_matrix[condition_id,"viscosity"]) == merge_water_viscous$Inlet.Viscosity ),]

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
