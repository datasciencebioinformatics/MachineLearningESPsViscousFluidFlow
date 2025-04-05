# To do 01/04/2025
# Check paper for the units of each variable
# Reproduce figure 1. Flow rate (dimensoneless) vs. head 
# Organize test matrixes

# set  the gravitational constant
# 9.81 meters per second squared (m/s2) is the approximate value of the acceleration due to gravity on Earth's surface. This value is represented by the letter g. 
g=9.81

# Number of stages (constant equanto to 3)
N   <-3 

# Store the useful power Ph
merge_water_viscous$P_h<-0

# The pump efficiency (n) is defined as:
# n = efficiency, dimensionless [%]
merge_water_viscous$n<-0

# Store the pump head
# H = head, L, m
merge_water_viscous$H<-0

# Store the shaft torque is the mechanical parameter used to calculate the driving power or brake horsepower (BHP)
# BHP = mL^2t^–3, watts
merge_water_viscous$BHP<-0

# Store the flow rate in m3s1
# Q = volumetric flow rate, L3 t–1 , m3/h
merge_water_viscous$Q<-0

# First, Calculate the velocity
for (measure in rownames(merge_water_viscous))
{ 
  # Model
  model=merge_water_viscous[measure,"equip"]

  # Impeller Diameter mm
  # Unit checked mm
  D=unique(metada_data[which(metada_data$model == merge_water_viscous[measure,"equip"]),2]) * 1000 # m converted to mm
    
  # Store inlet and outlet pressure
  # P = pressure, mL–1t–2, Pa
  # Unit checked pa
  P1  <-as.numeric(merge_water_viscous[measure,"Inlet.Pressure.P1"])  * 100000 # Bar converted to pa
  P2  <-as.numeric(merge_water_viscous[measure,"Outlet.Pressure.P2"]) * 100000 # Bar converted to pa
  
  # Density
  # p = density, mL–3, kg/m3
  # Unit checked kg/m3
  p  <-as.numeric(merge_water_viscous[measure,"Inlet.Density.ρi"])

  # The Flow Rate, Q 
  # Q = volumetric flow rate, L3, t–1, m3/h
  # Unit checked m3/h
  merge_water_viscous[measure,"Q"]<-as.numeric(merge_water_viscous[measure,"Flow.rate"])/(p) # kg/h converted to m3/h

  # Head pump
  # H = head, L, m
  merge_water_viscous[measure,"H"]<-((P2-P1)/(p*g))*(1/N) 

  # The rotational speed w in rpm
  # unit checked RPM
  w=as.numeric(merge_water_viscous[measure,"RPM"])*0.10472
  
  # Net.Shaft.Torque
  # T = shaft torque, mL2,t–2, N·m
  # unit checked N·m
  T=as.numeric(merge_water_viscous[measure,"Shaft.Torque"])

  # ESP is the BHP
  # BHP = mL^2t^–3, watts
  merge_water_viscous[measure,"BHP"]=(1/N)*(w*T)

  #P_{h}: The power in kilowatts (kW) 
  # Q    : The flow capacity in cubic meters per hour (m3/h) 
  # p    : The density of the fluid in kilograms per cubic meter (kg/m3) 
  # g    : The acceleration due to gravity (9.81m/s2) 
  # H    : The differential head in meters (m)

  # useful power Ph
  merge_water_viscous[measure,"P_h"]<- (p*g*merge_water_viscous[measure,"H"]*merge_water_viscous[measure,"Q"])

  # The pump efficiency (n) is defined as:
  # n = efficiency, dimensionless [%]
  merge_water_viscous[measure,"n"] <- merge_water_viscous[measure,"P_h"]/merge_water_viscous[measure,"BHP"]
}
################################################################################################################
# Subset ESP_P47 
ESP_P47_water<-merge_water_viscous[merge_water_viscous$RPM=="3500" & merge_water_viscous$equip=="P47",]
################################################################################################################
# Fig. 7—ESP P47 performance pumping viscous fluid at 3,500 rev/min.
# Melt tabele
ESP_P47_water_plot_Q_H <- ggplot(ESP_P47_water, aes(x = Q, y = H,shape = RPM,colour=fluid))   + geom_point() + theme_bw()   + ggtitle ("Flow rate Q (m3/h) vs. Head H")    + ylab("Head H")  +  xlab("Flow rate Q m3/h") + theme(legend.position = "none") + geom_vline(xintercept=BEP_Q)
ESP_P47_water_plot_BHP <- ggplot(ESP_P47_water, aes(x = Q, y = BHP,shape = RPM,colour=fluid))   + geom_point() + theme_bw() + ggtitle ("Flow rate Q (m3/h) vs. Power BHP") + ylab("Power BHP")  +  xlab("Flow rate Q m3/h")     + theme(legend.position = "none") + geom_vline(xintercept=BEP_Q) 
ESP_P47_water_plot_n   <- ggplot(ESP_P47_water, aes(x = Q, y = n/100,shape = RPM,colour=fluid))   + geom_point() + theme_bw()   + ggtitle ("Flow rate Q (m3/h) vs. Efficiency n (%)") + ylab("Efficiency n (%)")  +  xlab("Flow rate Q m3/h")+ theme(legend.position = "bottom") + geom_vline(xintercept=BEP_Q)

# Melt tabele
# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"ESP_P47_water_RPM3500.png",sep=""), width = 20, height = 25, res=600, units = "cm")  
  grid.arrange(ESP_P47_water_plot_Q_H,ESP_P47_water_plot_BHP,ESP_P47_water_plot_n, nrow =3)
dev.off()
################################################################################################################
# Subset variables Inlet.Viscosity, RPM, equip and efficiency n.
# Goal of the analysis, compare the efficiency per equipement, rpm and Inlet.Viscosity

# Data.frame only with selected variables
viscosity_RPM_equip_n<-na.omit(merge_water_viscous[,c("Inlet.Viscosity","RPM","equip","n","fluid")])

# Split dataset in water, glycerin and diluted glycering for rpm 3000
viscosity_RPM_equip_n_water          <-viscosity_RPM_equip_n[which(viscosity_RPM_equip_n$fluid=="water" & viscosity_RPM_equip_n$RPM=="3000"),]
viscosity_RPM_equip_n_Glycerin       <-viscosity_RPM_equip_n[which(viscosity_RPM_equip_n$fluid=="Glycerin" & viscosity_RPM_equip_n$RPM==3000),]
viscosity_RPM_equip_n_DilutedGlycerin<-viscosity_RPM_equip_n[which(viscosity_RPM_equip_n$fluid=="Diluted Glycerin" & viscosity_RPM_equip_n$RPM==3000),]



# Basic box plot
png(filename=paste(project_folder,"viscosity_RPM_equip_n_Glycerin.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
  ggplot(viscosity_RPM_equip_n_Glycerin, aes(x=equip, y=n)) +geom_boxplot() + facet_wrap(vars(Inlet.Viscosity,RPM), nrow = 3, scales="free") + theme_bw() + ggtitle("Glycerin samples")+ theme(axis.text.x = element_text(angle = 90))
dev.off()
################################################################################################################
