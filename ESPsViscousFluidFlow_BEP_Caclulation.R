# Take unique values of viscosity, equipment and rpm
unique_viscosity <-sort(unique(as.numeric(merge_water_viscous$Inlet.Viscosity)))
unique_equipment <-sort(unique(merge_water_viscous$equip))
unique_rpm <-sort(unique(merge_water_viscous$RPM))

# Generate test matrix as data.frame
expand.grid(unique_rpm,unique_equipment,unique_viscosity)

# For each combination of test

# The best efficient point will be calculated fro each configuration in the test matrix
# Fit a curve for Qxn
fit <- lm(ESP_P47_water$Q ~ poly(ESP_P47_water$n, 5, raw=TRUE))

# Find maximum value
BEP_Q<-max(fit$fitted.values)

