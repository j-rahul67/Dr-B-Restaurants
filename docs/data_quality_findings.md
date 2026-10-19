# Data-quality findings

Initial review of the supplied QSR Daily Demand source files found:

- 365 missing sales quantities, approximately 0.4% of sales rows.
- Zero duplicate date + menu-item combinations.
- Zero sales rows missing menu names after the menu join.
- 14 temperature values coded as `-99` for the selected restaurant's city; these are treated as missing for temperature analysis.
- 55 calendar dates without a matching weather record for Minneapolis.

The Data page recalculates these checks from the original CSVs when rendered and also checks missing listed prices, food-cost values, and preparation times. Missing quantities are excluded from item-day comparisons; daily totals sum observed values and can therefore be understated on dates with missing quantities. Weather values are not invented for dates with no matching record. Blank holiday or event names on non-holiday/non-event dates are expected and are not treated as bad data.
