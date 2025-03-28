#########################################################################################################
# Mass flow rate can be used to calculate velocity through the volumetric flow rate equation. The equation is ṁ = (v * A) * ρ, where: 
All_viscous$Velocity<-0

# v = m/(A*d)
# m: Mass flow rate               [kg/h]
# v: Velocity                     [m/h]
# A: Cross-sectional area of flow [m2] 
# d: Density                      [kg/m³]

# First, Calculate the velocity
for (measure in rownames(All_viscous))
{
  # Take the equipment
  equip<-All_viscous[measure,"equip"]
                     
  # The Flow Rate, Q 
  # [kg/h]
  m=as.numeric(All_viscous[measure,"Flow.rate"])
  
  # Density
  # [kg/m³]
  d=as.numeric(All_viscous[measure,"Inlet.Density.ρi"])

  # Inner diameter of pipe, di in m
  # [m]
  id  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 

  # Area from pipe
  # [m2]
  A   <- pi*((id/2)^2)

  # v = m/(A*d) 
  # [m/h]
  v = m/(A*d)

  # [m/s]
  v = v*0.0002777778

  # Store velocity m/s
  All_viscous[measure,"Velocity"]<-v
  
}
#####################################################################################
# d density    (kg/m3)                 ok
# v flow speed (m/s)                   ok
# L length     (m)                     ok
# dv dynamic viscosity (Pa·s or kg/ms) cP*0.001
# kv viscosity (m2/s)                  dv/d

# Calculation of Reynolds number
All_viscous$Re_A<-0 # https://en.wikipedia.org/wiki/Reynolds_number
All_viscous$Re_B<-0 # https://en.wikipedia.org/wiki/Reynolds_number

# Second, calculate the Reynolds number
for (measure in rownames(All_viscous))
{
  # Take the equipment
  equip<-All_viscous[measure,"equip"]
                     
  # The Flow Rate, Q 
  # [kg/h]
  m=as.numeric(All_viscous[measure,"Flow.rate"])
  
  # Density
  # [kg/m³]
  d=as.numeric(All_viscous[measure,"Inlet.Density.ρi"])

  # Inner diameter of pipe, di in m
  # [m]
  id  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 

  # Store velocity
  velocity<-All_viscous[measure,"Velocity"]

  # Store viscosity
  # [cP]
  vicosity<-as.numeric(All_viscous[measure,"Outlet.Viscosity.mo"])
                  
  # https://en.wikipedia.org/wiki/Reynolds_number
  d=d                  # d density    (kg/m3)
  v=velocity           # v flow speed (m/s)
  L=id                 # L length     (m)
  dv=vicosity          # dv dynamic viscosity (Pa·s or kg/ms) cP*0.001
  kv=dv/d              # kv kinetic viscosity (m2/s))           

  # Reynolds number
  # Re_1 = [u is the flow speed (m/s) * L is a characteristic length (m)] / ν is the kinematic viscosity of the fluid (m2/s).
  # Re_2 = [ρ is the density of the fluid (kg/m3) * u is the flow speed (m/s) * L is a characteristic length (m)] / μ is the dynamic viscosity of the fluid (Pa·s)

  # Re_B
  Re_B_1 = (v * L)/kv
  Re_B_2 = (d*v*L)/dv

  # Reynolds number
  All_viscous[measure,"Re_A"]<-Re_B_1  
  All_viscous[measure,"Re_B"]<-Re_B_2  
}
