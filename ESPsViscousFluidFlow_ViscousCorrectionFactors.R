################################################################################################################
# Needed variables
# Q    : The flow capacity in cubic meters per hour (m3/h)                    OK
# p    : The density of the fluid in kilograms per cubic meter (kg/m3)        OK (must be calculated for water)
# g    : The acceleration due to gravity (9.81m/s2)                           OK
# H    : The differential head in meters (m)                                  OK
# T    : Net.Shaft.Torque                                                     OK
# N    : Number of stage                                                      OK
################################################################################################################
df_test_matrix$BEP_Q_corresponde<--1

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

    # Update the BEP_Q_correspondence
    df_test_matrix[condition_id,"BEP_Q_corresponde"]<-BEP_Q_correspondence
  }
}
################################################################################################################
# For each viscous category o of the test matrix, calculate the BEP_water_Q and BEP_viscous_Q 
# For each test condition, the head, BHP and efficiency are already calculate.
# TO DO : use the values at the calculated BEP_water_Q and BEP_viscous_Q
################################################################################################################
# First, take the BEP in water and in Viscous
# Q (head) : (Q*n in water) AND (Q*n in viscous)
  
######################################################################################3
# The BEP flow rate in water is analogous to the BEP flow rate in viscous fluids.
# therefore, the BEP_water_Q is analogous BEP_water_Q.
C_Q<-BEP_water_Q/BEP_viscous_Q

# Correction 
C_n=ESP_water_BEP_Q[,"n"]/ESP_fluid_BEP_Q[,"n"]

# Correction 
C_H=ESP_water_BEP_Q[,"H"]/ESP_fluid_BEP_Q[,"H"]
