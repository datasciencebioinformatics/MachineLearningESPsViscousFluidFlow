################################################################################################################
# All samples Water samples
merge_water_viscous

# Water samples
ESP_water<-na.omit(merge_water_viscous[merge_water_viscous$fluid=="water",])

# Fluid samples 
ESP_fluid<-na.omit(merge_water_viscous[merge_water_viscous$fluid!="water",])
################################################################################################################
# First, take the BEP in water and in Viscous
# Q (head) : (Q*n in water) AND (Q*n in viscous)

# Fit a curve for Qxn
Q_water_fit   <- lm(ESP_water$Q ~ poly(ESP_water$n, 5, raw=TRUE))
Q_viscous_fit <- lm(ESP_fluid$Q ~ poly(ESP_fluid$n, 5, raw=TRUE))

# Find maximum value
BEP_water_Q<-max(Q_water_fit$fitted.values)
BEP_viscous_Q<-max(Q_viscous_fit$fitted.values)
################################################################################################################
# The BEP flow rate in water is analogous to the BEP flow rate in viscous fluids.
# therefore, the BEP_water_Q is analogous BEP_water_Q.
