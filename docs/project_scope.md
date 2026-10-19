# Stage 1 scope

## Included

- QSR R07 item-day sales from 2021–2025 and the supporting tables used for calendar, menu, weather, event, and marketing context.
- Data manipulation and summaries using `tidyverse` and native `|>` pipes.
- Visualization techniques shown in Weeks 1–5: rankings, distributions, trends over time, scatterplots, smoothing lines, correlation displays, faceting, multiple geoms, and aesthetic mapping.
- A short story linking the menu mix, timing of demand, product co-movement, promotion distributions, item economics, weather, events, and marketing context to practical decisions.

## Excluded

- Machine learning or predictive models.
- Transaction-level product bundling claims: only daily item quantities are available.
- Causal claims that promotions, temperature, events, or advertising caused demand to change.
- Separate graphs for every available variable; weak relationships are shown only where a graph meaningfully answers the business question.
- Restaurant profile attributes not needed for the selected Stage 1 questions.

## Core limitations

- Some item-day quantities are missing; summaries use observed quantities.
- Weather readings do not cover every calendar date and `-99` temperatures are treated as missing.
- Price and food-cost values are applied across the five-year quantity history for comparative margin estimates. The estimate excludes operating expenses and is not net profit.
- Results describe R07 only and are not automatically generalizable to every restaurant.


## Exploration page

The Exploration page walks from data structure to quantity baselines, grouped summaries, purposeful transformations, and four charts selected for their objectives. Chart source is folded under a “Show R code” control; explanation and takeaways remain visible.
