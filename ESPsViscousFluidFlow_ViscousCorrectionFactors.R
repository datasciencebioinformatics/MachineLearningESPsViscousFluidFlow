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
# add values of H, Q, n at BEP
# for viscous..
df_test_matrix$H_at_BEP_viscous           <--1
df_test_matrix$Q_at_BEP_viscous           <--1
df_test_matrix$N_at_BEP_viscous           <--1
df_test_matrix$BHP_at_BEP_viscous         <--1
# ...and for water
df_test_matrix$H_at_BEP_water           <--1
df_test_matrix$Q_at_BEP_water           <--1
df_test_matrix$N_at_BEP_water           <--1
df_test_matrix$BHP_at_BEP_water         <--1

# for each configurartion of the test matrix 
for (condition_id in rownames(df_test_matrix))
{

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
melt_df_test_matrix_fluid<-melt(df_test_matrix_fluid[,c("equip","RPM","fluid","viscosity","C_Q","C_n","C_H")],id.vars=c("equip","RPM","fluid","viscosity"))

ESP_P47_melt_df_test_matrix_fluid<-melt_df_test_matrix_fluid[which(melt_df_test_matrix_fluid$equip=="P47"),]
################################################################################################################
# Melt tabele
# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"ESP_P47_melt_df_test_matrix_fluid.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
  ggplot(data=ESP_P47_melt_df_test_matrix_fluid, aes(x=viscosity, y=value, group=RPM,colour=RPM)) + geom_line()+ facet_grid(vars(variable), scales = "free")+ theme_bw()   + ggtitle ("P47 Glycerin") + geom_point()
dev.off()
################################################################################################################
