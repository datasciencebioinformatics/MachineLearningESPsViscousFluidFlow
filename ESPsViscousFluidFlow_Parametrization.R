# The pump head is the hydraulic power or pump output power (PQ) transmitted to the fluid handled relative to ρ · g · Q. 
# https://www.ksb.com/en-global/centrifugal-pump-lexicon/article/head-1115612
# set  the gravitational constant
# 9.81 meters per second squared (m/s2) is the approximate value of the acceleration due to gravity on Earth's surface. This value is represented by the letter g. 
g=9.81]

# Number of stages (constant equanto to 3)
N   <-3 

# Store the useful power Ph
All_viscous$P_h<-0

# Store the pump head
All_viscous$H<-0

# Store the shaft torque is the mechanical parameter used to calculate the driving power or brake horsepower (BHP)
All_viscous$BHP<-0

# Store the flow rate in m3s1
All_viscous$Q<-0

# Store the diameter Impelleters diameter
All_viscous$D<-0

# Store the kinetic viscosity
All_viscous$kv<-0

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
  All_viscous[measure,"H"]<-(P2-P1)/(d*g)*(1/N) 

  # useful power Ph
  All_viscous[measure,"P_h"]<- p*g*H*Q

  # Inner diameter of pipe, di in m
  # [m]
  id  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 

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

