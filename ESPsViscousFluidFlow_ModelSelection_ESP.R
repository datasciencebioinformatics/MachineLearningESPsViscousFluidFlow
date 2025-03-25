##################################################################################################
# Common variables water and fluid
fluid_variables<-c("Flow.rate","Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4", "Average.Inlet.Temp.Tm.i", "Average.Outlet.Temp.Tm.o","Inlet.Pressure.P1", "Outlet.Pressure.P2", "Net.Shaft.Torque", "Inlet.Density.ρi", "Inlet.Viscosity.mi",  "Outlet.Viscosity.mo", "RPM")

# For each variable
for (variable in fluid_variables)
{
  # Take all the variable except the "variable"
  X=fluid_variables[!fluid_variables %in% variable]
  
}
fluid_variables
