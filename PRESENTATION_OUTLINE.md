# Presentation Outline — What I Learned and What I Implemented
Rahul Jangir — OMIS 681 QSR Daily Demand project — Week 15 style (first vs updated analysis)
Outline prepared Sun Nov 22, 2026. BUILT: presentation.qmd (Quarto revealjs, static numbers, speaker notes) was built from this outline on Nov 22, 2026, after the Modeling page rendered in Rahul's RStudio and its metrics were verified. All model numbers below are those verified rendered values.

Format rule for every slide: title, max 3 bullets, one chart/table named. Talk track is one sentence per slide in the notes below each.

---

## Part 1 — Stage 1: what I learned in Weeks 1–6, and what it built

### Slide 1 — Title: Predicting Restaurant Demand, One Day at a Time
- Rahul Jangir, OMIS 681, QSR Daily Demand, restaurant R07 (Minneapolis), 2021–2025
- One line: Stage 1 described demand; Stage 2 predicts it
- Visual: none (title slide), site homepage screenshot optional
- Talk: "My project asks a simple question: can we know, in advance, how busy tomorrow will be?"

### Slide 2 — The data, and why the unit of observation matters (Weeks 1–3)
- 8 source tables joined; one sales row = one menu item on one date, not a customer
- Two different outcomes kept separate: quantity per item-day vs total units per restaurant-day
- Data quality found, not hidden: 365 missing quantities, 14 temperatures coded -99, 55 dates with no weather record
- Visual: Data page table inventory / EDA quality-checks table
- Talk: "Most early mistakes in this class came from not knowing what a row was. I fixed that first."

### Slide 3 — What sells (Weeks 4–5)
- Drinks lead unit volume; a few familiar items carry much of the demand
- Category totals and typical item-day quantities answer different questions, both are needed
- Visual: Report chart — total units by category (ranking bar)
- Talk: "Volume tells the owner what must never run out."

### Slide 4 — When it sells (Weeks 4–5)
- Demand rises into summer, varies by weekday, and categories do not share one seasonal shape
- Averages alone mislead; weekday boxplots show the spread within each day
- Visual: Report charts — average daily demand by month (line) and weekday distribution (boxplot)
- Talk: "The calendar rhythm in this slide is exactly what the Stage 2 models are asked to learn."

### Slide 5 — Relationships worth testing, and one that failed (Weeks 4–5)
- Promotions, weather, and events show associations; price and preparation time show no clear overall linear pattern
- Negative result kept on purpose: a weak scatterplot is a finding, not a failure to hide
- Visual: EDA faceted scatterplots — price and prep time vs average item-day quantity
- Talk: "Stage 1 ended with hypotheses, not conclusions. That set up the modeling honestly."

### Slide 6 — Week 6: the project is a Quarto website
- Every page renders from the same data and code; "Show R code" on every chart
- No hand-typed numbers anywhere on the site
- Visual: screenshot of the site navigation (Home / Data / Exploration / Report / Modeling / Slides)
- Talk: "Reproducibility was the Week 6 lesson: if a number cannot be recomputed, it does not go on the site."

## Part 2 — Stage 2: what I learned in Weeks 8–12, and what it built

### Slide 7 — Week 8: my first model, and the split-first rule
- Target chosen: total daily demand, one row per date, a regression problem
- 80/20 train/test split with a seed, before any preprocessing
- Recipe v1 (lean): median imputation for numbers, dummies for categories, no normalization for a plain linear model
- Visual: Modeling page — split table and Recipe v1 coefficient table
- Talk: "The biggest Week 8 lesson: the recipe is prepped inside the workflow on training data only, or the test set leaks."

### Slide 8 — Week 9: two recipes, four model specs, five workflows
- Recipe v2 (full) adds season, events, precipitation type; mode imputation for text; normalize predictors only, never the outcome
- Models: linear regression (lm), lasso (glmnet, mixture 1), ridge (glmnet, mixture 0 — added because Week 12 Activity 3 fits ridge in class), decision tree (rpart) — all regression mode; only the lasso penalty is tuned
- The bugs I learned to avoid: recipe vs baked data, median vs mode imputation, classification mode on a numeric outcome
- Visual: Modeling page — workflows table (5 workflows + what each pairs)
- Talk: "Week 9 was about each tidymodels package having one job: rsample splits, recipes prep, parsnip specifies, workflows combine."

### Slide 9 — Week 10: predictions, judged against baselines
- Every model predicts the same held-out test days; two baselines (overall mean, weekday average) predicted too
- Predicted-vs-actual and residuals-over-time charts show where the model fails, not just how much
- Visual: Modeling page — predicted vs actual chart (provisional best workflow)
- Talk: "A model that cannot beat the weekday average has learned nothing. The baselines keep the results honest."

### Slide 10 — Weeks 11–12: assessment before recommendation
- One ranked table: test RMSE/MAE/R², 5-fold CV, and a time split (train 2021–2024, test 2025)
- Only one thing tuned: the lasso penalty, tuned on the folds, never on the test set
- Winner named from the table, then interpreted — never before
- Visual: Modeling page — ranked comparison table and lasso tuning chart
- Talk: "Weeks 11–12 changed my order of work: metrics first, interpretation second, recommendation last."
- FILLED with verified rendered numbers: LM + Recipe v2 test RMSE 130.7 / MAE 84.8 / R2 0.908, CV RMSE 110.6, time-test 134.2 / 96.8 / 0.924; Lasso + Recipe v2 130.8 / 85.0 / 0.908, CV 110.8, time-test 134.1 / 96.9 / 0.924 (essentially ties the winner on the time split — said out loud on the slide); Ridge + Recipe v2 137.8 / 89.8 / 0.901, CV 116.1, time-test 137.8 / 100.8 / 0.919; Tree + Recipe v2 192.7 / 140.7 / 0.799, CV 183.2, time-test 178.8 / 131.5 / 0.835; LM + Recipe v1 196.3 / 114.0 / 0.790, CV 166.4, time-test 169.6 / 108.6 / 0.856; weekday baseline test 383.0 / 294.1 / 0.201, time-test 373.1 / 289.7 / 0.168; overall-mean baseline test 428.0 / 317.8, time-test 407.4 / 318.2.

### Slide 11 — What the winner means for the business
- Winner: LM + Recipe v2. Its test MAE 84.8 (page recommendation rounds to 85 units per day) translated into business terms: a prep buffer and staffing range, not an exact order
- What drives it (Recipe v2 coefficients, normalized scale): month_Jul 216.3, month_Jun 199.1, month_Aug 186.6, day_of_week_Saturday 162.9, month_May 145.6, month_Sep 121.9, event_group_No.special.event -121.1, day_of_week_Friday 111.0, day_of_week_Sunday 98.1, month_Oct 79.5
- Where it still fails: busiest days and seasonal drift (from the residuals chart)
- Visual: Modeling page — residuals-over-time chart
- Talk: "An error bar the owner can use is worth more than a decimal of R-squared."

## Part 3 — Honest close

### Slide 12 — What did not work
- Price and preparation time: no clear linear relationship with demand (Stage 1)
- Weekend flag overlaps Saturday/Sunday dummies: one aliased coefficient in the linear fits (the Week 12 rank-deficiency lesson, in my own project)
- Random-split results are optimistic next to the time split — report both, trust the time split
- Visual: none, or the residuals chart reused small
- Talk: "These three are the slides I would cut last. They are the proof the work was checked."

### Slide 13 — Limitations
- One restaurant only (R07); nothing transfers without refitting
- Weather is recorded weather, not a forecast, and association is not causation
- Monthly marketing was excluded from daily models on purpose — no invented daily precision
- Visual: none (text slide, keep it short)
- Talk: "Every limit here is a data limit, not a model limit. Better inputs beat fancier models."

### Slide 14 — What I learned, in one slide (the Week 15 updated-analysis close)
- First analysis (Stage 1): describe honestly, keep the unit of observation straight, report negative results
- Updated analysis (Stage 2): split first, compare against baselines, assess three ways before recommending
- Next step if I continued: item-level promotion data and real weather forecasts as predictors
- Visual: the Learning Map table from the homepage
- Talk: "The course moved me from 'what happened' to 'what can we predict, and how wrong might we be' — and to saying the second part out loud."

---

## Build notes (not slides)
- DONE Nov 22, 2026: presentation.qmd built as a standalone Quarto revealjs deck (the existing slides.qmd was left untouched), static numbers only, no R chunks, so it renders without the data files.
- Every number in the deck was read off the rendered Modeling page and Rahul's verified screenshots, per the rule above.
- Adaptations made at build time: Slide 12 ("What did not work") leads with the two verified modeling results (Recipe v1 worst at 196.3; decision tree 192.7) and the two build-verification catches (table that did not print; winner label that picked the wrong row), framed as verification steps; the Stage 1 price/prep negative result stays on Slide 5, and the random-split vs time-split caution is carried on the assessment slide and in the limitations notes. A closing slide, "What I learned in this course," was added after Slide 14 mapping Weeks 1–5, 6, 8, 9, 10, 11–12, and 15 to what each produced (15 slides total including the title slide).
