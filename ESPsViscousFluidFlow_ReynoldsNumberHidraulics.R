#########################################################################################################
# numeric vector that contains the pipe diameter [m or f t] which should be D >=0.0025 m (0.0082 ft).
# Q (for velocity function only) numeric vector that contains the flow rate [m3s−1or f t3s−1]

# Add the impellers diameter
All_viscous$L <- metada_data[match(All_viscous$equip,metada_data$model),"Impeller.diameter"]

# Mass flow rate can be used to calculate velocity through the volumetric flow rate equation. The equation is ṁ = (v * A) * ρ, where: 
All_viscous$Q <-as.numeric(All_viscous$Flow.rate)/(3600*as.numeric(All_viscous$Inlet.Density.ρi))

# First, Calculate the velocity
for (measure in rownames(All_viscous))
{
  velocity(D = na.omit(All_viscous)$L, Q = na.omit(All_viscous)$Q)
}
#####################################################################################
# d density    (kg/m3)                 ok
# v flow speed (m/s)                   ok
# L length     (m)                     ok
# dv dynamic viscosity (Pa·s or kg/ms) cP*0.001
# kv viscosity (m2/s)                  dv/d

# Second, calculate the Reynolds number
for (measure in rownames(All_viscous))
{
  
}
