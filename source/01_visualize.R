# Read cleaned data
library(here)
here::i_am("source/01_visualize.R")
Wage <- readRDS(here::here("data/cleaned_Wage.RDS"))

# Plot of Wage distribution
library(ggplot2)

title1 <- "Distribution of Wages"
plot1 <- ggplot(Wage, aes(wage)) +
  geom_histogram(bins = 40, fill = "gray70", color = "black") +
  labs(title = title1)+
  theme(
    legend.title = element_text(size = 6),
    legend.text  = element_text(size = 5),
    text = element_text(size = 6)
  )

title2 <- "Wage vs Age\n by Education"
plot2 <- ggplot(Wage, aes(age, wage, color = education)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "loess", se = FALSE) +
  labs(title = title2,
       x = "Age", y = "Wage (USD)") +
  theme(
    legend.title = element_text(size = 6),
    legend.text  = element_text(size = 5),
    text = element_text(size = 6)
  )

ggsave(
  filename = here("results", "figures", "fig1_wage_distribution.png"),
  plot = plot1, width = 6, height = 4, dpi = 300
)

ggsave(
  filename = here("results", "figures", "fig2_wage_vs_age_edu.png"),
  plot = plot2, width = 7, height = 4.5, dpi = 300
)
