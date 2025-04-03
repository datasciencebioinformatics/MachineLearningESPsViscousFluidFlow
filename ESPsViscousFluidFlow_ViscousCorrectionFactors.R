################################################################################################################
# Water samples
ESP_water<-na.omit(merge_water_viscous[merge_water_viscous$fluid=="water",])

# Fluid samples 
ESP_fluid<-na.omit(merge_water_viscous[merge_water_viscous$fluid!="water",])
################################################################################################################
# The correction the BEP from the fitt curve Q*n.
# Q (head) : (Q*n in water) AND (Q*n in viscous)

# Fit a curve for Qxn
Q_water_fit <- lm(ESP_water$Q ~ ESP_water$Pi)

# Find maximum value
Q_water_BEP<-max(Q_water_fit$fitted.values)

# homologous conditions on the viscous and water curves

# CQ= Qvis/Qw
