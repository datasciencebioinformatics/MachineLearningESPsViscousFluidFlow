# Fit a curve for Qxn
fit <- lm(ESP_P47_water$Q ~ ESP_P47_water$n)

# Find maximum value
BEP_Q<-max(fit$fitted.values)

