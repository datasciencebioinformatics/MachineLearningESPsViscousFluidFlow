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
df_test_matrix_DilutedGlycerin<-df_test_matrix[df_test_matrix$fluid=="Diluted Glycerin",]
df_test_matrix_Glycerin       <-df_test_matrix[df_test_matrix$fluid=="Glycerin",]

# Add collumns for each correction factor
df_test_matrix$C_Q<-0 # Correction factor for flow rate Q
df_test_matrix$C_n<-0 # Correction factor for flow rate n
df_test_matrix$C_H<-0 # Correction factor for flow rate H 

######################################################################################3
# The BEP flow rate in water is analogous to the BEP flow rate in viscous fluids.
# therefore, the BEP_water_Q is analogous BEP_water_Q.
C_Q<-BEP_water_Q/BEP_viscous_Q

# Correction 
C_n=ESP_water_BEP_Q[,"n"]/ESP_fluid_BEP_Q[,"n"]

# Correction 
C_H=ESP_water_BEP_Q[,"H"]/ESP_fluid_BEP_Q[,"H"]
