#########################################################################################################
# numeric vector that contains the pipe diameter [m or f t] which should be D >=0.0025 m (0.0082 ft).
# Q (for velocity function only) numeric vector that contains the flow rate [m3s−1or f t3s−1]

# Add the impellers diameter
All_viscous$L <- metada_data[match(All_viscous$equip,metada_data$model),"Impeller.diameter"]

# Mass flow rate can be used to calculate velocity through the volumetric flow rate equation. The equation is ṁ = (v * A) * ρ, where: 
All_viscous$Q <-as.numeric(All_viscous$Flow.rate)/3600

# Collumn to add the velocity calculated by the hydrolautics
All_viscous$Velocity_H<-0

# First, Calculate the velocity
for (measure in rownames(All_viscous))
{
  Q=All_viscous[measure,"Q"]
  L=All_viscous[measure,"L"]
  All_viscous[measure,"Velocity_H"]<-velocity(D = L, Q = Q)
}
#####################################################################################
# d density    (kg/m3)                 ok
# v flow speed (m/s)                   ok
# L length     (m)                     ok
# dv dynamic viscosity (Pa·s or kg/ms) cP*0.001
# kv viscosity (m2/s)                  dv/d

# Second, Calculate the reynolds number
for (measure in rownames(All_viscous))
{
  Velocity_H = All_viscous[measure,"Velocity_H"]
  L          =All_viscous[measure,"L"]

  # https://en.wikipedia.org/wiki/Reynolds_number
  vicosity=as.numeric(All_viscous[measure,"Outlet.Viscosity.mo"])
  d=d                  # d density    (kg/m3)
  dv=vicosity          # dv dynamic viscosity (Pa·s or kg/ms) cP*0.001
  kv=dv/d              # kv kinetic viscosity (m2/s)) 
  
  All_viscous[measure,"Re_H"]<-reynolds_number(V = Velocity_H, D = L, nu = kv)
}
