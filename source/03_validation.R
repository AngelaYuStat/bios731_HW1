# Read cleaned data
library(here)
here::i_am("source/03_validation.R")
Wage <- readRDS(here::here("data/cleaned_Wage.RDS"))
fit <- readRDS(here::here("results/models/fit_gam.RDS"))

library(mgcv)
library(ggplot2)
race_groups <- c("White", "Black", "Asian")
plots_list <- list()

for (race_group in race_groups) {
  newdat <- expand.grid(
    age = seq(min(Wage$age), max(Wage$age), length = 100),
    education = levels(Wage$education),
    race = race_group,
    KEEP.OUT.ATTRS = FALSE
  )

  newdat$education <- factor(newdat$education, levels = levels(Wage$education))
  newdat$race <- factor(newdat$race, levels = levels(Wage$race))
  newdat$pred_logwage <- predict.gam(fit, newdata = newdat)
  newdat$pred_wage <- exp(newdat$pred_logwage)

  p <- ggplot(Wage, aes(x = age, y = wage, color = education)) +
    geom_point(alpha = 0.2) +
    geom_line(
      data = newdat,
      aes(x = age, y = pred_wage, color = education),
      size = 1.2
    ) +
    labs(
      x = "Age",
      y = "Wage",
      title = sprintf("Observed Wages and Fitted Age-Wage Trends\nby Education Level (%s)", race_group)
    ) +
    theme_minimal() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 12),
      legend.position = "bottom",
      legend.title = element_text(size = 10),
      legend.text = element_text(size = 9)
    )

  plots_list[[race_group]] <- p

  ggsave(
    filename = here("results", "figures",
                    sprintf("age_wage_trends_%s.png", tolower(race_group))),
    plot = p, width = 7, height = 5, dpi = 300
  )

}

combined_plot <- cowplot::plot_grid(plotlist = plots_list, ncol = 3)
ggsave(
  filename = here("results", "figures", "age_wage_trends_all_races.png"),
  plot = combined_plot, width = 14, height = 5, dpi = 300
)
