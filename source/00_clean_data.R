# Read raw data
library(here)
here::i_am("source/00_clean_data.R")
Wage <- readRDS(here::here("data/Wage.RDS"))

# Convert categorical variables into factor format
library(dplyr)
Wage_clean <- Wage %>%
  mutate(
    year = as.integer(as.character(year)),
    education = factor(education,
                       levels = c("1. < HS Grad", "2. HS Grad", "3. Some College",
                                  "4. College Grad", "5. Advanced Degree"),
                       labels = c("<HS", "HS Grad", "Some College",
                                  "College Grad", "Advanced Degr.")),
    race = factor(race,
                  levels = c("1. White", "2. Black", "3. Asian", "4. Other"),
                  labels = c("White", "Black", "Asian", "Other"))
  )

# Save the cleaned data
saveRDS(Wage_clean, file = here::here("data/cleaned_Wage.RDS"))
