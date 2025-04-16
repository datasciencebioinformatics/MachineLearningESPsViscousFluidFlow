################################################################################################################
# Needed variables
# Q    : The flow capacity in cubic meters per hour (m3/h)                    OK
# p    : The density of the fluid in kilograms per cubic meter (kg/m3)        OK (must be calculated for water)
# g    : The acceleration due to gravity (9.81m/s2)                           OK
# H    : The differential head in meters (m)                                  OK
# T    : Net.Shaft.Torque                                                     OK
# N    : Number of stage                                                      OK
################################################################################################################
# Take the obversed BEP value for the estimated BEP value
# take the Q value that matches the closesest with the estimated Q
df_test_matrix$BEP_Q_fluid        <--1
df_test_matrix$BEP_Q_water        <--1

# for each configurartion of the test matris
for (condition_id in rownames(df_test_matrix))
{
  # Take the value of the BEP
  BEP_Q<-df_test_matrix[condition_id,"BEP"]

  # Take the RPM value
  RPM<-df_test_matrix[condition_id,"RPM"]
  
  # Take the equip value
  equip<-df_test_matrix[condition_id,"equip"]

  # Take the viscosity value
  viscosity<-df_test_matrix[condition_id,"viscosity"]

  # Take the fluid value
  fluid<-df_test_matrix[condition_id,"fluid"]
   
  # Subset data from specific condition of test matrix
  condition_water_viscous<-merge_water_viscous[as.numeric(merge_water_viscous$RPM)==RPM,]

  # Subset data from specific condition of test matrix
  condition_water_viscous<-condition_water_viscous[condition_water_viscous$equip==equip,]

  # Subset data from specific condition of test matrix
  condition_viscous<-condition_water_viscous[condition_water_viscous$Inlet.Viscosity==viscosity,]

  # Subset data from specific condition of test matrix
  condition_viscous<-na.omit(condition_viscous[condition_viscous$fluid==fluid,])

  # Take the data for water
  condition_water<-condition_water_viscous[condition_water_viscous$fluid=="water",]
  
  # If condition_water_viscous not empty
  if(dim(condition_viscous)[1]>=1)
  {
    # The heads and efficiencies corresponding to these flow rates define the other correction facter
    # Take all the infofmation corresponding the BEP_water_Q and BEP_viscous_Q
    BEP_Q_fluid<-sort((condition_viscous)$Q)[match.closest(BEP_Q,  sort((condition_viscous)$Q))]
    BEP_Q_water<-sort((condition_water)$Q)[match.closest(BEP_Q,  sort((condition_water)$Q))]
  
    # Update the BEP_Q_correspondence H_at_BEP Q_at_BEP N_at_BEP BHP_at_BEP
    # In case the efficiency curve has more than one peak, take the value in the first output
    df_test_matrix[condition_id,"BEP_Q_fluid"]         <-BEP_Q_fluid
    df_test_matrix[condition_id,"BEP_Q_water"]         <-BEP_Q_water
  }
}
##################################################################################################################
# TO DO:
# For each test condition, the take the the H, Q and n and BEP for viscous and water
# using BEP_Q_fluid and BEP_Q_water
# The loop above can be repeated.
##################################################################################################################
# for each configurartion of the test matrix 
for (condition_id in rownames(df_test_matrix))
{
  # Take the value of the BEP
  BEP_Q_fluid<-df_test_matrix[condition_id,"BEP_Q_fluid"]
  BEP_Q_water<-df_test_matrix[condition_id,"BEP_Q_water"]         

  # Take the RPM value
  RPM<-df_test_matrix[condition_id,"RPM"]
  
  # Take the equip value
  equip<-df_test_matrix[condition_id,"equip"]
  
  # Take the viscosity value
  viscosity<-df_test_matrix[condition_id,"viscosity"]
  
  # Take the fluid value
  fluid<-df_test_matrix[condition_id,"fluid"]
  
  # Subset data from specific condition of test matrix
  condition_water_viscous<-merge_water_viscous[as.numeric(merge_water_viscous$RPM)==RPM,]
  
  # Subset data from specific condition of test matrix
  condition_water_viscous<-condition_water_viscous[condition_water_viscous$equip==equip,]
  
  # Subset data from specific condition of test matrix
  condition_viscous<-condition_water_viscous[condition_water_viscous$Inlet.Viscosity==viscosity,]
  
  # Subset data from specific condition of test matrix
  condition_viscous<-na.omit(condition_viscous[condition_viscous$fluid==fluid,])
  
  # Take the data for water
  condition_water<-condition_water_viscous[condition_water_viscous$fluid=="water",]
  
  # If condition_water_viscous not empty
  if(dim(condition_viscous)[1]>=1)
  {
    # Take the metrics in fluids
    n_viscous_at_BEP<-condition_viscous[which(condition_viscous$Q == BEP_Q_fluid),"n"]
    H_viscous_at_BEP<-condition_viscous[which(condition_viscous$Q == BEP_Q_fluid),"H"]
    BHP_viscous_at_BEP<-condition_viscous[which(condition_viscous$Q == BEP_Q_fluid),"BHP"]
    Q_viscous_at_BEP<-condition_viscous[which(condition_viscous$Q == BEP_Q_fluid),"Q"]

    # Take the metrics in water
    n_water_at_BEP<-condition_water[which(condition_water$Q == BEP_Q_water),"n"]
    H_water_at_BEP<-condition_water[which(condition_water$Q == BEP_Q_water),"H"]
    BHP_water_at_BEP<-condition_water[which(condition_water$Q == BEP_Q_water),"BHP"]
    Q_water_at_BEP<-condition_water[which(condition_water$Q == BEP_Q_water),"Q"]

    # Store in results matrix - fluids
    df_test_matrix[condition_id,"H_at_BEP_viscous"]<-n_viscous_at_BEP
    df_test_matrix[condition_id,"n_at_BEP_viscous"]<-H_viscous_at_BEP
    df_test_matrix[condition_id,"BHP_at_BEP_viscous"]<-BHP_viscous_at_BEP
    df_test_matrix[condition_id,"Q_at_BEP_viscous"]<-Q_viscous_at_BEP

    # Store in results matrix - water
    df_test_matrix[condition_id,"H_at_BEP_water"]<-n_water_at_BEP
    df_test_matrix[condition_id,"n_at_BEP_water"]<-H_water_at_BEP
    df_test_matrix[condition_id,"BHP_at_BEP_water"]<-BHP_water_at_BEP
    df_test_matrix[condition_id,"Q_at_BEP_water"]<-Q_water_at_BEP
  }
}

################################################################################################################
# For each viscous category, split the data in the three possible fluids
# In case of water, there is only one viscous categorie
################################################################################################################
# Add collumns for each correction factor
df_test_matrix$C_Q<-df_test_matrix$Q_at_BEP_viscous/df_test_matrix$Q_at_BEP_water
df_test_matrix$C_n<-df_test_matrix$n_at_BEP_viscous/df_test_matrix$n_at_BEP_water
df_test_matrix$C_H<-df_test_matrix$H_at_BEP_viscous/df_test_matrix$H_at_BEP_water
################################################################################################################
# Melt data.frame for the plot
melt_df_test_matrix_fluid<-melt(df_test_matrix[,c("equip","RPM","fluid","viscosity","C_Q","C_n","C_H")],id.vars=c("equip","RPM","fluid","viscosity"))

ESP_P47_melt_df_test_matrix_fluid<-melt_df_test_matrix_fluid[which(melt_df_test_matrix_fluid$equip=="P47"),]
################################################################################################################
# Melt tabele
# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"ESP_P47_melt_df_test_matrix_fluid.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
  ggplot(data=ESP_P47_melt_df_test_matrix_fluid, aes(x=viscosity, y=value, group=RPM,colour=RPM)) + geom_line()+ facet_grid(vars(variable), scales = "free")+ theme_bw()   + ggtitle ("P47") + geom_point()
dev.off()
################################################################################################################
