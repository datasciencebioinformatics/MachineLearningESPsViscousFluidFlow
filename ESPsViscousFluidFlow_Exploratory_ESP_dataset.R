################################################################################################################
# To Do:
# reproduce Fig. 7—ESP P47 performance pumping viscous fluid at 3,500 rev/min.
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

# Melt water_viscous
melt_water_viscous<-melt(merge_water_viscous,id.vars=c("id","fluid","RPM","replicate","equip"))
##################################################################################################
# Remove the equip.
# Set the axis scale free, both x and y
# change to wrap
# plot each equipment at once
# remove na
melt_water_viscous<-na.omit(melt_water_viscous)
##################################################################################################
# Basic density
p <- ggplot(melt_water_viscous, aes(x=as.numeric(value),fill=fluid)) + geom_density(alpha=0.4) + facet_wrap(vars(variable,RPM), nrow = 7, scales="free") + theme_bw()
# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"Plot_melt_water_viscous_variable_rpm.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
 p
dev.off()


# Basic density
p <- ggplot(melt_water_viscous, aes(x=as.numeric(value),fill=equip)) + geom_density(alpha=0.4) + facet_wrap(vars(variable,fluid), nrow = 7, scales="free") + theme_bw()

# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"Plot_melt_water_viscous_variable_equip.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
 p
dev.off()
#########################################################################################################
# Performance assessment
melt_water_viscous_sub_P1<-melt_water_viscous[which( melt_water_viscous$variable=="Inlet.Pressure.P1" & melt_water_viscous$RPM == 1800),]
melt_water_viscous_sub_T1<-melt_water_viscous[which( melt_water_viscous$variable=="Inlet.Temperature.T1" & melt_water_viscous$RPM == 1800),]
melt_water_viscous_sub<-rbind(melt_water_viscous_sub_P1,melt_water_viscous_sub_T1)

# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"melt_water_viscous_sub_P1.png",sep=""), width = 20, height = 20, res=600, units = "cm")  
 ggplot(melt_water_viscous_sub_P1, aes(x=fluid, y=as.numeric(value)))+theme_classic()+ facet_wrap(vars(variable,equip), nrow = 3, scales="free") + theme_bw() +geom_boxplot() + geom_jitter() + ggtitle("1800 RPM")
dev.off()

# Plot_raw_vibration_data.png                                                                                                            
png(filename=paste(project_folder,"melt_water_viscous_sub_T1.png",sep=""), width = 20, height = 20, res=600, units = "cm")  
 ggplot(melt_water_viscous_sub_T1, aes(x=fluid, y=as.numeric(value)))+theme_classic()+ facet_wrap(vars(variable,equip), nrow = 3, scales="free") + theme_bw() +geom_boxplot() + geom_jitter()  + ggtitle("1800 RPM")
dev.off()
#########################################################################################################
# Common variables water and fluid
fluid_variables<-c("Flow.rate","Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4", "Average.Inlet.Temp.Tm.i", "Average.Outlet.Temp.Tm.o","Inlet.Pressure.P1", "Outlet.Pressure.P2", "Shaft.Torque", "Inlet.Density.ρi", "Inlet.Viscosity.mi",  "Outlet.Viscosity.mo", "RPM")

# Only variables of fluids 
water_variables<-c("Flow.rate", "Inlet.Temperature.T1", "Inlet.Temperature.T2",  "Inlet.Pressure.P1", "Outlet.Pressure.P2", "Shaft.Torque", "RPM")

# Convert the variables to numeric
selected_viscous_variables <- data.frame(apply(All_viscous[,fluid_variables], 2, function(x) as.numeric(as.character(x))))
selected_water_variables  <- data.frame(apply(All_water[,water_variables], 2, function(x) as.numeric(as.character(x))))

# selected_water_variables                                                                                                            
png(filename=paste(project_folder,"chart.Correlation.water.png",sep=""), width = 20, height = 20, res=600, units = "cm")  
        chart.Correlation(selected_water_variables, histogram=TRUE, pch=19)
dev.off()

# selected_viscous_variables                                                                                                            
png(filename=paste(project_folder,"chart.Correlation.viscous.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
        chart.Correlation(selected_viscous_variables, histogram=TRUE, pch=19)
dev.off()
#########################################################################################################
