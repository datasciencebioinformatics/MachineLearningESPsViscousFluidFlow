#########################################################################################################
# Mass flow rate can be used to calculate velocity through the volumetric flow rate equation. The equation is ṁ = (v * A) * ρ, where: 
merge_water_viscous$Re <-0

# First, Calculate the velocity
for (measure in rownames(merge_water_viscous))
{
  # Save the equipment 
  equip=merge_water_viscous[measure,"equip"]
  
  # Density
  # [kg/m³]
  p  <-as.numeric(merge_water_viscous[measure,"Inlet.Density.ρi"])

  # Store viscosity
  # [kg/ms] 
  v<-as.numeric(merge_water_viscous[measure,"Outlet.Viscosity.mo"])/p
  
  # Inner diameter of pipe, di in m
  # [m]
  D2  <-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"])*as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"])

  # The rotational speed w in rpm
  # unit checked RPM m/s
  w = as.numeric(merge_water_viscous[measure,"RPM"])

  # Store Reynollds number
  merge_water_viscous[measure ,"Re"]= (p*w*D2)/v
}
#####################################################################################
png(filename=paste(project_folder,"Boxplot_All_viscous.png",sep=""), width = 15, height = 15, res=600, units = "cm")  
  ggplot(na.omit(merge_water_viscous), aes(x=fluid, y=Re, fill=equip)) +  geom_boxplot()+ theme(legend.position = "bottom") + theme_bw()
dev.off()
#####################################################################################
