#########################################################################################################
# Mass flow rate can be used to calculate velocity through the volumetric flow rate equation. The equation is ṁ = (v * A) * ρ, where: 
All_viscous$Re <-0

# v = m/(A*d)
# m: Mass flow rate               [kg/h]
# v: Velocity                     [m/h]
# A: Cross-sectional area of flow [m2] 
# d: Density                      [kg/m³]

# First, Calculate the velocity
for (measure in rownames(All_viscous))
{
  # Density
  # [kg/m³]
  p  <-as.numeric(All_viscous[measure,"Inlet.Density.ρi"])

  # Store viscosity
  # [kg/ms] 
  v<-as.numeric(All_viscous[measure,"Outlet.Viscosity.mo"]) *0.001
  
  # Inner diameter of pipe, di in m
  # [m]
  D2  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"])*as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"])

  # The rotational speed w in rpm
  # unit checked RPM m/s
  w = (2*pi*as.numeric(merge_water_viscous[measure,"RPM"]))/60

  # Store Reynollds number
  All_viscous[measure ,"Re"]= (p*w*D2)/v
}
#####################################################################################
png(filename=paste(project_folder,"Boxplot_All_viscous.png",sep=""), width = 15, height = 15, res=600, units = "cm")  
  ggplot(na.omit(All_viscous), aes(x=fluid, y=Re_H, fill=equip)) +  geom_boxplot()+ theme(legend.position = "bottom") + theme_bw()
dev.off()
#####################################################################################
