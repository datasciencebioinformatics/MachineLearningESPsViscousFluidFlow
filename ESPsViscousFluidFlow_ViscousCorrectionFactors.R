################################################################################################################
# Needed variables
# Q    : The flow capacity in cubic meters per hour (m3/h)                    OK
# p    : The density of the fluid in kilograms per cubic meter (kg/m3)        OK (must be calculated for water)
# g    : The acceleration due to gravity (9.81m/s2)                           OK
# H    : The differential head in meters (m)                                  OK
# T    : Net.Shaft.Torque                                                     OK
# N    : Number of stage                                                      OK
################################################################################################################
# Viscous samples
# All_viscous

# Water samples
# All_water

# Make the colnames correspondents
################################################################################################################
# For each viscous category o of the test matrix, calculate the BEP_water_Q and BEP_viscous_Q 
# For each test condition, the head, BHP and efficiency are already calculate.
# TO DO : use the values at the calculated BEP_water_Q and BEP_viscous_Q
################################################################################################################
# First, take the BEP in water and in Viscous
# Q (head) : (Q*n in water) AND (Q*n in viscous)

# Fit a curve for Qxn
Q_water_fit   <- lm(ESP_water$Q ~ poly(ESP_water$n, 5, raw=TRUE))
Q_viscous_fit <- lm(ESP_fluid$Q ~ poly(ESP_fluid$n, 5, raw=TRUE))

# Find maximum value
BEP_water_Q<-max(Q_water_fit$fitted.values)
BEP_viscous_Q<-max(Q_viscous_fit$fitted.values)
################################################################################################################
# The heads and efficiencies corresponding to these flow rates define the other correction facter
# Take all the infofmation corresponding the BEP_water_Q and BEP_viscous_Q
ESP_water_BEP_Q<-ESP_water[ESP_water$Q == sort((ESP_water)$Q)[match.closest(BEP_water_Q,  sort((ESP_water)$Q))],]
ESP_fluid_BEP_Q<-ESP_fluid[ESP_fluid$Q == sort((ESP_fluid)$Q)[match.closest(BEP_viscous_Q,  sort((ESP_fluid)$Q))],]
  
######################################################################################3
# The BEP flow rate in water is analogous to the BEP flow rate in viscous fluids.
# therefore, the BEP_water_Q is analogous BEP_water_Q.
C_Q<-BEP_water_Q/BEP_viscous_Q

# Correction 
C_n=ESP_water_BEP_Q[,"n"]/ESP_fluid_BEP_Q[,"n"]

# Correction 
C_H=ESP_water_BEP_Q[,"H"]/ESP_fluid_BEP_Q[,"H"]
