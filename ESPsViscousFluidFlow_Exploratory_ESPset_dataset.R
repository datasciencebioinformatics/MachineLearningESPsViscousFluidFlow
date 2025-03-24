##################################################################################################
# Colnames
common_varibles<-colnames(All_viscous)[which(colnames(All_viscous) %in% colnames(All_water))]

# Merge tables
merge_water_viscous<-rbind(All_water[,common_varibles],All_viscous[,common_varibles])
##################################################################################################
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
fluid_variables<-c("Flow.rate","Inlet.Temperature.T1","Inlet.Temperature.T2","Outlet.Temperature.T3","Outlet.Temperature.T4", "Inlet.Pressure.P1", "Outlet.Pressure.P2", "Net.Shaft.Torque", "Average.Inlet.Temp.Tm.i", "Average.Outlet.Temp.Tm.o", "Inlet.Density.ρi", "Inlet.Viscosity.mi",  "Outlet.Viscosity.mo", "RPM")

# Only variables of fluids 
water_variables<-c("Flow.rate", "Inlet.Temperature.T1", "Inlet.Temperature.T2", "Outlet.Temperature.T3", "Outlet.Temperature.T4", "Inlet.Pressure.P1", "Outlet.Pressure.P2", "Shaft.Torque", "RPM")

# Convert the variables to numeric
selected_viscous_variables <- data.frame(apply(All_viscous[,fluid_variables], 2, function(x) as.numeric(as.character(x))))
selected_water_variables  <- data.frame(apply(All_water[,water_variables], 2, function(x) as.numeric(as.character(x))))

# selected_water_variables                                                                                                            
png(filename=paste(project_folder,"selected_water_variables.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
        selected_water_variables
dev.off()

# selected_viscous_variables                                                                                                            
png(filename=paste(project_folder,"selected_viscous_variables.png",sep=""), width = 30, height = 30, res=600, units = "cm")  
        selected_viscous_variables
dev.off()

chart.Correlation(my_data, histogram=TRUE, pch=19)
chart.Correlation(my_data, histogram=TRUE, pch=19)

