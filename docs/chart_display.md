# Chart display notes

- Each chart is built as a named `ggplot` object and then passed to `show_chart(plot_object)`. This makes the displayed object explicit and prevents the theme object from being printed as raw `<theme> List ...` output.
- Each visualization chunk has `echo: true`, `code-fold: true`, and the label `Show R code`; the report's setup chunk remains hidden.
- The price-demand and preparation-time charts are separate figures, so the project no longer needs the `patchwork` package.
- All report graphics remain static `ggplot2` plots with the CSS scroll-reveal effect. There is no Plotly toolbar or graph interaction library.
