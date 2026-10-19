# Shared, course-aligned ggplot2 styling.
# Charts are static ggplot2 figures; assets/qsr-effects.html only animates their
# entrance as the reader scrolls. No chart-interaction library is used.

category_colors <- c(
  "Breakfast" = "#E69F00",
  "Burgers" = "#0072B2",
  "Chicken" = "#D55E00",
  "Combos" = "#009E73",
  "Desserts" = "#CC79A7",
  "Drinks" = "#56B4E9",
  "Sides" = "#666666",
  "Specials" = "#A6761D"
)

qsr_navy <- "#16384B"
qsr_teal <- "#267487"
qsr_coral <- "#E97855"

# Titles are supplied by the report section headings so they never collide with
# the plot area. The theme puts focus on axes, marks, and a clean legend.
theme_business <- ggplot2::theme_minimal(base_size = 15) +
  ggplot2::theme(
    text = ggplot2::element_text(family = "sans", color = "#263B4A"),
    plot.title = ggplot2::element_blank(),
    plot.subtitle = ggplot2::element_blank(),
    plot.caption = ggplot2::element_text(size = 10.5, color = "#71808D", hjust = 0, lineheight = 1.15,
                                         margin = ggplot2::margin(t = 10)),
    axis.title = ggplot2::element_text(size = 13, color = "#415769"),
    axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 10)),
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = 10)),
    axis.text = ggplot2::element_text(size = 12, color = "#526575"),
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major = ggplot2::element_line(color = "#E8EDF1", linewidth = 0.5),
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.title = ggplot2::element_text(face = "bold", size = 11.5),
    legend.text = ggplot2::element_text(size = 11),
    legend.key.width = grid::unit(1.2, "lines"),
    legend.spacing.x = grid::unit(0.25, "cm"),
    plot.margin = ggplot2::margin(14, 32, 20, 16)
  )

show_chart <- function(p) {
  p <- p + ggplot2::labs(title = NULL, subtitle = NULL) +
    ggplot2::theme(plot.title = ggplot2::element_blank(), plot.subtitle = ggplot2::element_blank())
  print(p)
  invisible(p)
}
