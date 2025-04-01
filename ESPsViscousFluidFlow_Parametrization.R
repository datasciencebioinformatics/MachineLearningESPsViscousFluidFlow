# The pump head is the hydraulic power or pump output power (PQ) transmitted to the fluid handled relative to ρ · g · Q. 
# https://www.ksb.com/en-global/centrifugal-pump-lexicon/article/head-1115612
# set  the gravitational constant
# 9.81 meters per second squared (m/s2) is the approximate value of the acceleration due to gravity on Earth's surface. This value is represented by the letter g. 
g=9.81

# Store the flow rate in m3s1
All_viscous$Q<-0

# Store the diameter Impelleters diameter
All_viscous$D<-0

# First, Calculate the velocity
for (measure in rownames(All_viscous))
{                     
  # The Flow Rate, Q 
  # [kg/h]
  Q=as.numeric(All_viscous[measure,"Flow.rate"])
  
  # Density
  # [kg/m³]
  d  <-as.numeric(All_viscous[measure,"Inlet.Density.ρi"])

  # Inner diameter of pipe, di in m
  # [m]
  id  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 

  # Flow rate in m3/s 
  # [m3/s]
  All_viscous[measure,"Q"]<-Q/(d*3600)

  # [m]
  All_viscous[measure,"D"]<-id
}
