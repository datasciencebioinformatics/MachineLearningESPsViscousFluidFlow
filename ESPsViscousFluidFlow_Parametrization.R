# The pump head is the hydraulic power or pump output power (PQ) transmitted to the fluid handled relative to ρ · g · Q. 
# https://www.ksb.com/en-global/centrifugal-pump-lexicon/article/head-1115612
# set  the gravitational constant
# 9.81 meters per second squared (m/s2) is the approximate value of the acceleration due to gravity on Earth's surface. This value is represented by the letter g. 
g=9.81

# Store the flow rate in m3s1
All_viscous$Q<-0

# Store the diameter Impelleters diameter
All_viscous$D<-0

# Store the diameter Impelleters diameter
All_viscous$kv<-0

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

  # Take the parameters to calculate kv
  Velocity_H = All_viscous[measure,"Velocity_H"]
  L          =All_viscous[measure,"L"]
  
  # https://en.wikipedia.org/wiki/Reynolds_number
  vicosity=as.numeric(All_viscous[measure,"Outlet.Viscosity.mo"])
  d=d                  # d density    (kg/m3)
  dv=vicosity          # dv dynamic viscosity (Pa·s or kg/ms) cP*0.001
  kv=dv/d              # kv kinetic viscosity (m2/s))

  # kv [m2/s]
  All_viscous[measure,"kv"]<-id

}

All_viscous$Q,All_viscous_Re_A

ggplot(na.omit(All_viscous), aes(x=Q, y=Re_A, color=equip)) + geom_point()  + facet_wrap(vars(fluid,RPM), nrow = 3, scales="free")

