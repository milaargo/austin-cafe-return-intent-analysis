# Austin Café Return Intent Analysis

## Overview

This customer insights project examines the gap between **customer satisfaction and continued patronage** using Austin café Yelp reviews.

The project began as a broader analysis of café experience themes. During exploratory analysis, a more useful business tension emerged: a customer can leave a highly positive review without indicating any intention to return, while another customer can describe meaningful friction and still show evidence of continued patronage.

That distinction became the focus of the analysis.

Using a balanced 300-review analytical sample, I combined human qualitative discovery, AI-assisted coding, Excel exploration, SQL analysis, and qualitative follow-up to investigate which parts of the café experience appear most closely associated with stated return intent.

---

## Business Question

**Which café experience factors are associated with customers' stated intent to return, and which positive experience factors appear to preserve return intent despite negative experiences?**

---

## Headline Finding

**How customers were treated separated return from non-return more clearly than many operational problems did.**

Among customers whose reviews contained at least one negative experience:

- negative **Service / Treatment** appeared in **58.5% of No-return reviews vs. 28.8% of Yes-return reviews**;
- positive Service appeared in **25.0% of Yes-return reviews vs. 9.8% of No-return reviews**.

Because No-return customers were disproportionately concentrated among lower ratings, I tested the Service pattern again using only Low-rating reviews.

The difference remained:

- negative Service: **63.6% No vs. 35.3% Yes**;
- positive Service: **23.5% Yes vs. 6.1% No**.

This does not establish that Service caused customers to return or leave. It suggests that **interpersonal treatment may influence whether an already-negative experience remains tolerable or becomes relationship-ending**.

---

## Additional Findings

### Distinctiveness may provide a reason to tolerate friction

Within reviews containing at least one negative experience:

- positive Distinctiveness appeared in **21.2% of Yes-return reviews vs. 2.4% of No-return reviews**;
- negative Distinctiveness appeared in **17.1% of No-return reviews vs. 3.8% of Yes-return reviews**.

Qualitative follow-up suggested that customers who continued patronage often described a specific reason the café remained worth choosing, such as signature products, events, community use, family fit, or another memorable experience characteristic.

No-return reviews more often described the business as generic, replaceable, or insufficiently differentiated.

Because these groups are relatively small, Distinctiveness is treated as a secondary exploratory pattern.

### Some friction appears more survivable than others

Negative **Speed / Process Friction** appeared at nearly identical rates among Yes and No customers in the negative-experience cohort:

- 21.2% Yes
- 22.0% No

Product Quality also became a weak separator once Low-rating Yes and No customers were compared with one another.

These results suggest that the existence of a problem alone may matter less than **what kind of problem occurred and what other value remained in the experience**.

---

## Why This Matters

Star ratings summarize how customers evaluate an experience, but they do not necessarily explain whether that experience is strong enough to sustain the customer relationship.

A customer may dislike parking, Wi-Fi, wait time, seating, pricing, or part of the product experience and still decide that the café is worth returning to.

For operators, a more useful prioritization question may therefore be:

**Which failures threaten the customer relationship, and which forms of friction are customers willing to tolerate when other parts of the experience remain valuable?**

---

## Dataset

- **7,616** Austin-area café Yelp reviews in the source dataset
- **300-review analytical sample**
- Balanced across **Low, Mixed, and High** rating tiers
- **13-theme** qualitative coding framework
- Theme-level sentiment: **Positive, Negative, Mixed, Neutral**
- Review-level return signal: **Yes, No, None**
- **1,069** coded review-theme observations

The analytical sample was designed for comparison rather than population-level prevalence estimates.

---

## Data Source

The source data comes from [**Yelp Coffee Reviews**](https://www.kaggle.com/datasets/sripaadsrinivasan/yelp-coffee-reviews), a publicly available Kaggle dataset created by **Sripaad Srinivasan** containing Yelp reviews of Austin-area coffee shops.

For this project, I used only the dataset's `raw_yelp_review_data` file as the analytical starting point.

I did not use the dataset creator's pre-generated sentiment or attribute outputs because I wanted to develop an independent analytical approach from the original review text.

The sampling strategy, qualitative codebook, return-signal framework, AI-assisted coding workflow, QA process, analytical framing, SQL analysis, and resulting interpretations were developed for this project.

**Source:** Sripaad Srinivasan, *Yelp Coffee Reviews*, Kaggle.

---

## Method

1. Human review of raw customer feedback
2. Development of a structured qualitative codebook
3. Human pilot coding
4. AI-assisted coding using the frozen framework
5. Manual calibration and post-coding QA
6. Exploratory analysis in Excel
7. SQL analysis of Yes vs. No return patterns
8. Isolation of a negative-experience cohort
9. Comparison of potential positive buffers and negative relationship breakers
10. Qualitative follow-up of the strongest patterns
11. Rating-tier robustness checks

The workflow moved iteratively between qualitative and quantitative analysis:

**customer language → structured coding → quantitative comparison → qualitative interpretation**

Throughout the project, I treated **analytical restraint as part of the method**. Emerging patterns were documented without automatically expanding the framework or treating descriptive differences as causal findings.

---

## Analytical Structure

The project uses two linked datasets.

### `sample_reviews`

One row per review.

Contains review-level information such as:

- review ID
- café
- full review text
- star rating
- rating tier
- return signal

### `coded_themes`

One row per unique review-theme combination.

Contains:

- review ID
- theme
- theme sentiment
- supporting evidence excerpt
- coding source
- return signal
- audit information

The tables are linked through `review_id`.

For customer-level questions, analysis uses `COUNT(DISTINCT review_id)` so that reviews containing multiple themes do not receive additional weight.

---

## Return Signal Definition

### Yes

Explicit future return or clear evidence of ongoing or repeated patronage.

### No

Explicit intention to stop patronizing the business or take future business elsewhere.

### None

No clear evidence of future or continued patronage.

Strong enthusiasm, recommendation to others, or desire to remain at the café during the current visit are not sufficient on their own to establish a return signal.

Return signal should be interpreted as **stated return intent or evidence of continued patronage**, not verified transactional retention.

---

## AI-Assisted Coding

AI was used to scale a coding framework developed through human qualitative discovery.

The workflow was:

**human discovery → human pilot → frozen codebook → unseen AI calibration → scaled coding → human QA**

The final analytical sample contained:

- **11 human-pilot reviews**
- **289 AI-assisted reviews**

AI classifications were not treated as ground truth.

The purpose of AI was to accelerate application of a defined analytical method rather than determine the method itself.

---

## QA

After AI-assisted coding, I conducted a stratified human QA spot-check of **15 reviews across Yes, No, and None return-signal categories**.

Each audited review was checked against the original full review text for:

- theme assignment;
- theme-level sentiment;
- return-signal classification.

No discrepancies were identified in the 15-review QA spot-check.

This was used as a **consistency check**, not as a formal statistical estimate of AI coding accuracy.

The analytical sample was also checked for duplicate customer reviews. Five exact duplicate pairs were identified and corrected before final analysis.

---

## Rating-Tier Robustness Check

The No-return group was disproportionately concentrated among Low-rating reviews, creating a potential confound.

To test whether the strongest Service pattern merely reflected overall dissatisfaction, I repeated the comparison among Low-rating customers only.

Within Low-rating reviews containing at least one negative experience:

- positive Service: **23.5% Yes vs. 6.1% No**
- negative Service: **35.3% Yes vs. 63.6% No**

The Service pattern therefore remained visible among customers who were similarly dissatisfied overall.

The Mixed-rating subgroup did not reproduce the same pattern clearly and contained only eight No-return reviews, so the result is treated cautiously rather than as evidence of an independent causal effect.

---

## Analytical Guardrails

This project is exploratory.

The findings should not be interpreted as causal effects or population estimates.

Important limitations include:

- stated return intent is not verified repeat-purchase behavior;
- the 300-review sample was deliberately balanced for comparison;
- Yelp reviewers are self-selected;
- some analytical subgroups are small;
- AI-assisted coding introduces classification risk;
- observational review data cannot establish why a customer ultimately returned or churned.

With company CRM or transaction data, the next step would be to test whether these review-language signals correspond with actual repeat purchase, churn, visit frequency, or customer lifetime value.

---

## Project Documentation

- [**Project Decision Timeline**](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/notes/project_timeline.md)  
  How the research question, methodology, and analytical focus evolved throughout the project.

- [**Review Coding Codebook**](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/notes/codebook.md)  
  Operational definitions, coding boundaries, return-signal rules, and methodological decisions.

- [**Analysis Log**](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/notes/analysis_log.md)  
  Main SQL observations, qualitative follow-up, robustness checks, interpretations, and analytical guardrails.

---

## SQL Analysis

The cleaned SQL workflow is organized into four stages:

- [`01_data_validation.sql`](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/sql/01_data_validation.sql)
- [`02_return_theme_analysis.sql`](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/sql/02_return_theme_analysis.sql)
- [`03_return_resilience_analysis.sql`](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/sql/03_return_resilience_analysis.sql)
- [`04_rating_tier_robustness_check.sql`](https://github.com/milaargo/austin-cafe-return-intent-analysis/blob/main/sql/04_rating_tier_robustness_check.sql)

Aggregate analytical outputs are available in the [`outputs`](https://github.com/milaargo/austin-cafe-return-intent-analysis/tree/main/outputs) folder.

Working files containing full review text were intentionally excluded from the public repository.

---

## Tools

- Excel
- DuckDB
- SQL
- DBeaver
- ChatGPT-assisted qualitative coding and SQL learning/support

Visualization will be developed separately from the analytical workflow.

---

## Project Status

**Qualitative coding, QA, Excel exploration, and SQL analysis complete.**

Current phase:

**Visualization and final portfolio case-study development.**
