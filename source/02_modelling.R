# Read cleaned data
library(here)
here::i_am("source/02_modelling.R")
Wage <- readRDS(here::here("data/cleaned_Wage.RDS"))

library(mgcv)
# GAM modelling
fit <- gam(log(wage) ~ s(age)
                   + s(age, by = education)
                   + race
                   + education, data = Wage)

#gam.check(fit)
saveRDS(fit, here("results", "models", "fit_gam.RDS"))
