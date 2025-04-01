# To do 01/04/2025
# Check paper for the units of each variable
# Reproduce figure 1. Flow rate (dimensoneless) vs. head 
# Organize test matrixes

# The pump head is the hydraulic power or pump output power (PQ) transmitted to the fluid handled relative to ρ · g · Q. 
# https://www.ksb.com/en-global/centrifugal-pump-lexicon/article/head-1115612
# set  the gravitational constant
# 9.81 meters per second squared (m/s2) is the approximate value of the acceleration due to gravity on Earth's surface. This value is represented by the letter g. 
g=9.81

# Number of stages (constant equanto to 3)
N   <-3 

# Store the useful power Ph
merge_water_viscous$P_h<-0

# The pump efficiency (n) is defined as:
merge_water_viscous$n<-0

# Store the pump head
merge_water_viscous$H<-0

# Store the shaft torque is the mechanical parameter used to calculate the driving power or brake horsepower (BHP)
merge_water_viscous$BHP<-0

# Store the flow rate in m3s1
merge_water_viscous$Q<-0

# dimensionless flow rate
merge_water_viscous$teta<-0

# First, Calculate the velocity
for (measure in rownames(merge_water_viscous))
{ 
  # The Flow Rate, Q 
  # [kg/h]
  model=merge_water_viscous[measure,"equip"]

  # Impeller Diameter
  D=unique(metada_data[which(metada_data$model == merge_water_viscous[measure,"equip"]),2])
  
  # The Flow Rate, Q 
  # [kg/h]
  merge_water_viscous[measure,"Q"]<-as.numeric(merge_water_viscous[measure,"Flow.rate"])
  
  # Store inlet and outlet pressure
  P1  <-as.numeric(merge_water_viscous[measure,"Inlet.Pressure.P1"])
  P2  <-as.numeric(merge_water_viscous[measure,"Outlet.Pressure.P2"])
  
  # Density
  p  <-as.numeric(merge_water_viscous[measure,"Inlet.Density.ρi"])

  # Head pump
  merge_water_viscous[measure,"H"]<-((P2-P1)/(d*g))*(1/N) 

  # The rotational speed w in rpm
  w=as.numeric(merge_water_viscous[measure,"RPM"])

  # Net.Shaft.Torque
  T=as.numeric(merge_water_viscous[measure,"Shaft.Torque"])

  # ESP is the BHP
  merge_water_viscous[measure,"BHP"]=(1/N)*(w*T)

  # useful power Ph
  merge_water_viscous[measure,"P_h"]<- p*g*merge_water_viscous[measure,"H"]*Q

  # The pump efficiency (n) is defined as:
  merge_water_viscous[measure,"n"] <- merge_water_viscous[measure,"P_h"]/BHP

  # dimensionless flow rate
  merge_water_viscous[measure,"teta"]<- merge_water_viscous[measure,"Q"]/(w*(D^3))
}
