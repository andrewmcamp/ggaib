# Generate comparison images for the pkgdown home page slider
# Run this script from the package root: source("data-raw/generate-comparison-images.R")

library(ggplot2)
library(ggaib)

set.seed(42)
districts <- data.frame(
  spending = c(rnorm(40, 11, 2), rnorm(40, 15, 2.5), rnorm(40, 13, 3)),
  avg_score = c(rnorm(40, 250, 15), rnorm(40, 270, 12), rnorm(40, 258, 18)),
  urbanicity = rep(c("Urban", "Suburban", "Rural"), each = 40)
)

base_plot <- ggplot(districts, aes(spending, avg_score, color = urbanicity)) +
  geom_point(size = 1) +
  scale_x_continuous(labels = scales::label_dollar()) +
  scale_y_continuous(limits = c(215, 300), breaks = seq(200, 300, 20)) +
  labs(
    title = "Per-Pupil Spending and Math Achievement",
    subtitle = "For Urban, Suburban, and Rural Districts",
    x = "Per-Pupil Expenditures\n($1,000s)",
    y = "Average Math Score",
    color = "Urbanicity",
    caption = "Note: Simulated data for illustration"
  )

# Default ggplot2 (no ggaib)
ragg::agg_png(
  "man/figures/compare-default.png",
  width = 800,
  height = 560,
  res = 600,
  scaling = 0.25
)
print(base_plot)
dev.off()

# With ggaib styling
ragg::agg_png(
  "man/figures/compare-ggaib.png",
  width = 800,
  height = 560,
  res = 600,
  scaling = 0.25
)
print(
  base_plot +
    scale_color_aib() +
    scale_x_continuous(labels = aib_label("dollar")) +
    theme_aib() +
    aib_color_title(
      "For Urban, Suburban, and Rural Districts",
      colors = c(
        "Urban"    = unname(aib_colors("navy")),
        "Suburban" = unname(aib_colors("red")),
        "Rural"    = unname(aib_colors("emerald"))
      ),
      element = "subtitle"
    ) +
    theme(legend.position = "none")
)
dev.off()
