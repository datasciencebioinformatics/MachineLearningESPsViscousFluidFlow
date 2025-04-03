################################################################################################################
# All samples Water samples
merge_water_viscous

# Water samples
ESP_water<-na.omit(merge_water_viscous[merge_water_viscous$fluid=="water",])

# Fluid samples 
ESP_fluid<-na.omit(merge_water_viscous[merge_water_viscous$fluid!="water",])
################################################################################################################
# The correction the BEP from the fitt curve Q*n.
# Q (head) : (Q*n in water) AND (Q*n in viscous)

# Fit a curve for Q_water_fit
Q_fit <- lm(merge_water_viscous$Q ~ merge_water_viscous$n)

# Find maximum value
BEP_Q<-max(Q_fit$fitted.values)
################################################################################################################

# Fit a curve for Q_water_fit
Q_water_fit <- lm(ESP_water$Q ~ ESP_water$Pi)

# Fit a curve for Q_water_fit
Q_viscous_fit <- lm(ESP_fluid$Q ~ ESP_fluid$Pi)

