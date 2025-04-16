################################################################################################################
# Needed variables
# Q    : The flow capacity in cubic meters per hour (m3/h)                    OK
# p    : The density of the fluid in kilograms per cubic meter (kg/m3)        OK (must be calculated for water)
# g    : The acceleration due to gravity (9.81m/s2)                           OK
# H    : The differential head in meters (m)                                  OK
# T    : Net.Shaft.Torque                                                     OK
# N    : Number of stage                                                      OK
################################################################################################################
df_test_matrix$H_at_BEP           <--1
df_test_matrix$Q_at_BEP           <--1
df_test_matrix$N_at_BEP           <--1
df_test_matrix$BHP_at_BEP         <--1

# for each configurartion of the test matris
for (condition_id in rownames(df_test_matrix))
{
  # Take the value of the BEP
  BEP_Q<-df_test_matrix[condition_id,"BEP"]

  # Subset data from specific condition of test matrix
  condition_water_viscous<-merge_water_viscous[which(merge_water_viscous$fluid  == df_test_matrix[condition_id,"fluid"]),]

  # Subset data from specific condition of test matrix
  condition_water_viscous<-condition_water_viscous[which(condition_water_viscous$RPM  == df_test_matrix[condition_id,"RPM"]),]

  # Subset data from specific condition of test matrix
  condition_water_viscous<-condition_water_viscous[which(condition_water_viscous$Inlet.Viscosity  == df_test_matrix[condition_id,"viscosity"]),]

  # If condition_water_viscous not empty
  if(dim(condition_water_viscous)[1]>=1)
  {
    # The heads and efficiencies corresponding to these flow rates define the other correction facter
    # Take all the infofmation corresponding the BEP_water_Q and BEP_viscous_Q
    BEP_Q_correspondence<-sort((condition_water_viscous)$Q)[match.closest(BEP_Q,  sort((condition_water_viscous)$Q))]

    # Update the BEP_Q_correspondence H_at_BEP Q_at_BEP N_at_BEP BHP_at_BEP
    # In case the efficiency curve has more than one peak, take the value in the first output
    df_test_matrix[condition_id,"H_at_BEP"]         <-condition_water_viscous[which(condition_water_viscous$Q == BEP_Q_correspondence),"H"][1]
    df_test_matrix[condition_id,"Q_at_BEP"]         <-condition_water_viscous[which(condition_water_viscous$Q == BEP_Q_correspondence),"Q"][1]
    df_test_matrix[condition_id,"N_at_BEP"]         <-condition_water_viscous[which(condition_water_viscous$Q == BEP_Q_correspondence),"n"][1]
    df_test_matrix[condition_id,"BHP_at_BEP"]       <-condition_water_viscous[which(condition_water_viscous$Q == BEP_Q_correspondence),"BHP"][1]    
  }
}
################################################################################################################
# For each viscous category, split the data in the three possible fluids
# In case of water, there is only one viscous categorie
################################################################################################################
# For water viscosity is alway zero
# Homologous conditions will be set among equipment and RPM
homologous_conditions<-unique(df_test_matrix_water[,c("RPM","equip")])

# Take only the water samples, glycerin and diluted glycering.
# each in one vector
df_test_matrix_water          <-df_test_matrix[df_test_matrix$fluid=="water",]
df_test_matrix_fluid          <-df_test_matrix[df_test_matrix$fluid!="water",]

# Add collumns for each correction factor
df_test_matrix_fluid$C_Q<-0 # Correction factor for flow rate Q
df_test_matrix_fluid$C_n<-0 # Correction factor for flow rate n
df_test_matrix_fluid$C_H<-0 # Correction factor for flow rate H 

# for each configurartion of the test matris
for (condition_id in rownames(df_test_matrix_fluid))
{
  # Take the value of the RPM in water 
  RPM     <-df_test_matrix_fluid[condition_id,"RPM"]

  # Take the value of equipmement in water
  equip   <-df_test_matrix_fluid[condition_id,"equip"]

  # Take the value of viscosity in 
  viscosity<-df_test_matrix_fluid[condition_id,"viscosity"]

  # Take the BEP_water_Q for this equipment and this rpm
  Q_at_BEP_water<-df_test_matrix_water[df_test_matrix_water$RPM== RPM & df_test_matrix_water$equip == equip,"Q_at_BEP"]
  N_at_BEP_water<-df_test_matrix_water[df_test_matrix_water$RPM== RPM & df_test_matrix_water$equip == equip,"N_at_BEP"]
  H_at_BEP_water<-df_test_matrix_water[df_test_matrix_water$RPM== RPM & df_test_matrix_water$equip == equip,"H_at_BEP"]

  # Take the value of equipmement in water
  df_test_matrix_fluid[condition_id,"C_Q"]<-(df_test_matrix_fluid[condition_id,"Q_at_BEP"]/Q_at_BEP_water)
  df_test_matrix_fluid[condition_id,"C_n"]<-(df_test_matrix_fluid[condition_id,"N_at_BEP"]/N_at_BEP_water)
  df_test_matrix_fluid[condition_id,"C_H"]<-(df_test_matrix_fluid[condition_id,"H_at_BEP"]/H_at_BEP_water)
}
################################################################################################################
# Melt data.frame for the plot
melt_df_test_matrix_fluid<-melt(df_test_matrix_fluid[,c("equip","RPM","fluid","viscosity","Q_at_BEP","N_at_BEP","H_at_BEP")],id.vars=c("equip","RPM","fluid","viscosity"))

ESP_P47_melt_df_test_matrix_fluid<-melt_df_test_matrix_fluid[which(melt_df_test_matrix_fluid$equip=="P47" & melt_df_test_matrix_fluid$fluid=="Glycerin"),]
################################################################################################################
# Melt tabele
# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"ESP_P47_melt_df_test_matrix_fluid.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
  ggplot(data=ESP_P47_melt_df_test_matrix_fluid, aes(x=viscosity, y=value, group=RPM)) + geom_line()+ facet_wrap(vars(variable,RPM), scales = "free")+ theme_bw()   + ggtitle ("P47 Glycerin") + geom_point()
dev.off()
################################################################################################################
