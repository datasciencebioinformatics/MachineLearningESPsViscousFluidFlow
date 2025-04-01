# The pump head is the hydraulic power or pump output power (PQ) transmitted to the fluid handled relative to ρ · g · Q. 
# https://www.ksb.com/en-global/centrifugal-pump-lexicon/article/head-1115612
# set  the gravitational constant
# 9.81 meters per second squared (m/s2) is the approximate value of the acceleration due to gravity on Earth's surface. This value is represented by the letter g. 
g=9.81]

# Number of stages (constant equanto to 3)
N   <-3 

# Store the useful power Ph
All_viscous$P_h<-0

# The pump efficiency (n) is defined as:
All_viscous$n<-0

# Store the pump head
All_viscous$H<-0

# Store the shaft torque is the mechanical parameter used to calculate the driving power or brake horsepower (BHP)
All_viscous$BHP<-0

# Store the flow rate in m3s1
All_viscous$Q<-0

# First, Calculate the velocity
for (measure in rownames(All_viscous))
{                     
  # The Flow Rate, Q 
  # [kg/h]
  Q=as.numeric(All_viscous[measure,"Flow.rate"])
  
  # Store inlet and outlet pressure
  P1  <-as.numeric(All_viscous[measure,"Inlet.Pressure.P1"])
  P2  <-as.numeric(All_viscous[measure,"Outlet.Pressure.P2"])
  
  # Density
  p  <-as.numeric(All_viscous[measure,"Inlet.Density.ρi"])

  # Head pump
  All_viscous[measure,"H"]<-((P2-P1)/(d*g))*(1/N) 

  # The rotational speed w in rpm
  w=as.numeric(All_viscous[measure,"RPM"])

  # Net.Shaft.Torque
  T=as.numeric(All_viscous[measure,"Net.Shaft.Torque"])

  # ESP is the BHP
  All_viscous[measure,"BHP"]=(1/N)*(w*T)

  # useful power Ph
  All_viscous[measure,"P_h"]<- p*g*All_viscous[measure,"H"]*Q

  # The pump efficiency (n) is defined as:
  All_viscous[measure,"n"] <- All_viscous[measure,"P_h"]/BHP
}
