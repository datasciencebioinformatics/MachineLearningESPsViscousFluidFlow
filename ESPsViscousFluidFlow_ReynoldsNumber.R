#########################################################################################################
# Path to metadata file
metada_data_file="eps_metada.xlsx"

# Load the metada file
metada_data<-data.frame(read_excel(paste(project_folder,metada_data_file,sep=""),skip=1))

# Split data.frame into RPM and rads
metada_data_rpm <-cbind(metada_data[,c(1,2,3,4,5,6)],Metric="RPM")
metada_data_rads<-cbind(metada_data[,c(1,2,7,8,9,10)],Metric="rads")

# Split data.frame into RPM and rads
colnames(metada_data_rpm)<-c("model","Impeller.diameter","1800","2400","3000","3500","Metric")
colnames(metada_data_rads)<-c("model","Impeller.diameter","1800","2400","3000","3500","Metric")

# Compile metada data
metada_data<-rbind(metada_data_rpm,metada_data_rads)
#########################################################################################################
# Calculation of Reynolds number
All_viscous$Re<-0

# Re	=	número de Reynolds
# Ρ	=	densidade do fluido
# Μ	=	velocidade do fluxo
# L	=	dimensão linear característica
# υ	=	viscosidade dinâmica do fluido

# P=Inlet.Density.ρi
# M=Flow.rate
# L=Impeller.diameter
# υ=Outlet.Viscosity.mo

# To calculate the velocity of a fluid from its flow rate, you can use the formula \(v=Q/A\). In this formula, \(v\) is the velocity, \(Q\) is the flow rate, and \(A\) is the cross-sectional area. 
# cross-sectional area -> A = pi*(L/2)^2
# velocity=Flow.rate/A
# For each measure
for (measure in rownames(All_viscous))
{
  # Take the equipment
  equip<-All_viscous[measure,"equip"]
  F<-as.numeric(All_viscous[measure,"Flow.rate"])
  L<-as.numeric(metada_data[metada_data$model==equip & metada_data$Metric=="rads","Impeller.diameter"]) 
  υ<-as.numeric(All_viscous[measure,"Outlet.Viscosity.mo"])
  P<-as.numeric(All_viscous[measure,"Inlet.Density.ρi"])
  A       <- pi*(L/2)^2
  velocity<-F/A

  # Reynolds number
  Re = (P*velocity*L)/υ

  # Set the reynolds number
  All_viscous[measure,"Re"]<-Re
}
