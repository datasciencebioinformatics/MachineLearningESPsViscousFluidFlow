# Fit a curve for Qxn
fit <- lm(ESP_P47_water$Q ~ poly(ESP_P47_water$n, 3, raw=TRUE))

# Find maximum value
BEP_Q<-max(fit$fitted.values)

