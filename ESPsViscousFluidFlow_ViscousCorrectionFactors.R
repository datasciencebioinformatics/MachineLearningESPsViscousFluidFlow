################################################################################################################
# All samples Water samples
merge_water_viscous

# Water samples
ESP_water<-na.omit(merge_water_viscous[merge_water_viscous$fluid=="water",])

# Fluid samples 
ESP_fluid<-na.omit(merge_water_viscous[merge_water_viscous$fluid!="water",])
################################################################################################################
# First, take the BEP in water and in Viscous
# Q (head) : (Q*n in water) AND (Q*n in viscous)

# Fit a curve for Qxn
Q_water_fit   <- lm(ESP_water$Q ~ poly(ESP_water$n, 5, raw=TRUE))
Q_viscous_fit <- lm(ESP_fluid$Q ~ poly(ESP_fluid$n, 5, raw=TRUE))

# Find maximum value
BEP_water_Q<-max(Q_water_fit$fitted.values)
BEP_viscous_Q<-max(Q_viscous_fit$fitted.values)

# The BEP flow rate in water is analogous to the BEP flow rate in viscous fluids.
# therefore, the BEP_water_Q is analogous BEP_water_Q.
C_Q<-BEP_water_Q/BEP_viscous_Q
################################################################################################################
# The heads and efficiencies corresponding to these flow rates define the other correction facter
# Take all the infofmation corresponding the BEP_water_Q and BEP_viscous_Q
ESP_water_BEP_Q<-ESP_water[ESP_water$Q == sort((ESP_water)$Q)[match.closest(BEP_water_Q,  sort((ESP_water)$Q))],]
ESP_fluid_BEP_Q<-ESP_fluid[ESP_fluid$Q == sort((ESP_fluid)$Q)[match.closest(BEP_viscous_Q,  sort((ESP_fluid)$Q))],]
  
# P = pressure in water
P1_water  <-as.numeric(ESP_water_BEP_Q[,"Inlet.Pressure.P1"])  * 100000 # Bar converted to pa
P2_water  <-as.numeric(ESP_water_BEP_Q[,"Outlet.Pressure.P2"]) * 100000 # Bar converted to pa

# P = pressure in viscous
P1_viscous  <-as.numeric(ESP_fluid_BEP_Q[,"Inlet.Pressure.P1"])  * 100000 # Bar converted to pa
P2_viscous  <-as.numeric(ESP_fluid_BEP_Q[,"Outlet.Pressure.P2"]) * 100000 # Bar converted to pa

# Density in water and in viscous
# p = density, mL–3, kg/m3
# Unit checked kg/m3
p_water    <-as.numeric(ESP_water_BEP_Q[,"Inlet.Density.ρi"])
p_viscous  <-as.numeric(ESP_fluid_BEP_Q[,"Inlet.Density.ρi"])

# Head pump
# H = head, L, m
ESP_water_BEP_Q[,"H"]<-((P2_water-P1_water)/(p_water*g))*(1/N)
ESP_fluid_BEP_Q[,"H"]<-((P2_viscous-P1_viscous)/(p_viscous*g))*(1/N)

# The rotational speed w in rpm
# unit checked RPM
w_water  =as.numeric(ESP_water_BEP_Q[,"RPM"])*0.10472
w_viscous=as.numeric(ESP_fluid_BEP_Q[,"RPM"])*0.10472

# Net.Shaft.Torque
# T = shaft torque, mL2,t–2, N·m
# unit checked N·m
T_water=as.numeric(ESP_water_BEP_Q[,"Shaft.Torque"])
T_viscous=as.numeric(ESP_fluid_BEP_Q[,"Shaft.Torque"])

# ESP is the BHP
# BHP = mL^2t^–3, watts
ESP_water_BEP_Q[,"BHP"]=(1/N)*(w_water*T_water)
ESP_fluid_BEP_Q[,"BHP"]=(1/N)*(w_viscous*T_viscous)

# useful power Ph
ESP_water_BEP_Q[,"P_h"]<- p_water*g*ESP_water_BEP_Q[,"H"]*ESP_water_BEP_Q[,"Q"]
ESP_fluid_BEP_Q[,"P_h"]<- p_viscous*g*ESP_fluid_BEP_Q[,"H"]*ESP_fluid_BEP_Q[,"Q"]

# The pump efficiency (n) is defined as:
# n = efficiency, dimensionless [%]
ESP_water_BEP_Q[,"n"] <- ESP_water_BEP_Q[,"P_h"]/ESP_water_BEP_Q[,"BHP"]
ESP_fluid_BEP_Q[,"n"] <- ESP_fluid_BEP_Q[,"P_h"]/ESP_fluid_BEP_Q[,"BHP"]




