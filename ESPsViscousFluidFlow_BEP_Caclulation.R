# The best efficient point will be calculated fro each configuration in the test matrix
# Fit a curve for Qxn
fit <- lm(ESP_P47_water$Q ~ poly(ESP_P47_water$n, 5, raw=TRUE))

# Find maximum value
BEP_Q<-max(fit$fitted.values)

