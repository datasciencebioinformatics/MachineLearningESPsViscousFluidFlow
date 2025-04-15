################################################################################################################
# To Do:
# reproduce Fig. 7—ESP P47 performance pumping viscous fluid at 3,500 rev/min.
# Subset ESP_P47 
ESP_P47_water<-merge_water_viscous[merge_water_viscous$RPM=="3500" & merge_water_viscous$equip=="P47" & merge_water_viscous$fluid!="water" ,]
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
