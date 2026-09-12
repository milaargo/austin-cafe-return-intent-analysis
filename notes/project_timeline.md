# Project Decision Timeline

This document records the major analytical and methodological decisions made throughout the project.

The project began as a broad customer-experience analysis and evolved as exploratory work revealed a more useful business question: the distinction between customer satisfaction and signals of continued patronage.

The purpose of this timeline is to make the reasoning behind the final methodology transparent.

---

## 1. Define the Initial Business Question
**Date:** August 23, 2026

I scoped the project as a short Consumer/Customer Insights take-home rather than another large UX research case study.

The initial question was:

**Which aspects of the café experience distinguish highly positive, mixed, and highly negative customer experiences, and what should operators prioritize to improve the experience?**

I intentionally focused on unstructured consumer feedback, coding, analysis, visualization, and business implications rather than interviews or competitive research.

---

## 2. Start From Raw Review Text

The source dataset contained previously generated sentiment outputs, but I chose to work from the raw Yelp review text instead.

The goal was to make my own analytical decisions rather than reproduce the original dataset creator's conclusions.

---

## 3. Conduct Human Discovery Before Using AI

Before introducing AI, I manually read reviews across Low, Mixed, and High rating tiers.

Recurring concepts included:

- Product Quality
- Service / Treatment
- Hospitality / Recognition
- Atmosphere / Aesthetics
- Functional Environment
- Value / Price
- Speed / Process Friction
- Convenience / Access
- Expectation / Reliability
- Distinctiveness

This human discovery phase became the basis for the first version of the coding framework.

---

## 4. Build and Refine the Codebook

I converted recurring customer concepts into operationally defined themes.

I also separated:

- overall star rating;
- theme-level sentiment;
- and return behavior.

Theme sentiment was coded independently as:

**Positive / Negative / Mixed / Neutral**

This allowed a review to contain, for example, positive Product Quality and negative Service / Treatment at the same time.

During pilot coding, recurring issues led to the addition of:

- Cleanliness / Maintenance
- Product Options / Accommodation

The codebook was then frozen before scaling.

---

## 5. Add a Return / Loyalty Signal

I introduced a separate review-level variable to capture evidence about whether the customer intended to continue or discontinue the relationship with the café.

Initial labels were:

**Yes / No / None**

This was intentionally separated from star rating because a customer could report a poor experience while still indicating they would return, or report a positive experience without giving any evidence of future patronage.

---

## 6. Structure the Data for Analysis

I maintained two related datasets:

### `sample_reviews`
One row per customer review.

### `coded_themes`
One row per unique review-theme combination.

This preserved the complexity of reviews containing multiple experience dimensions while allowing theme-level analysis.

For review-level questions, unique `review_id` values are counted so that reviews containing many themes do not receive extra weight.

---

## 7. Pilot, Calibrate, and Scale AI-Assisted Coding

I first manually coded a small pilot to test whether the codebook could consistently represent real customer language.

After freezing the framework, I tested AI-assisted coding on nine unseen reviews across Low, Mixed, and High rating tiers.

The AI was evaluated on:

- theme selection;
- theme-level sentiment;
- supporting evidence;
- and return-signal classification.

The calibration also clarified an important boundary: strong enthusiasm or a desire to remain in the café is not automatically evidence of future return.

After calibration, the framework was applied across the full 300-review analytical sample.

AI classifications were treated as assisted coding rather than ground truth.

---

## 8. Conduct Data Quality Checks

During coding, I discovered five exact duplicate review pairs in the analytical sample.

The later duplicate in each pair was replaced using the next unique review from the same rating tier while preserving the existing randomized sample order.

This ensured that individual customer experiences were not unintentionally counted more than once.

---

## 9. Explore the Coded Data in Excel

I used PivotTables to test whether the structured dataset could support meaningful comparison.

Initial exploration included:

- theme prevalence across Low, Mixed, and High ratings;
- theme sentiment across rating tiers;
- themes across Yes / No / None return signals;
- and positive or negative themes within return-signal groups.

This confirmed that the dataset was analytically usable.

It also showed that theme presence alone was not enough. Some themes appeared frequently across both positive and negative experiences, meaning the way customers evaluated those themes was more informative than simple frequency.

---

## 10. Reconsider the Analytical Focus

Exploratory analysis revealed that descriptive frequencies were useful for orientation but were not the most interesting part of the data.

The richer insights were appearing in:

- contradictions;
- trade-offs;
- expectation violations;
- tolerated friction;
- compensating strengths;
- and explicit explanations of why customers would or would not return.

This shifted the project away from a generic "what do customers like and dislike?" analysis.

---

## 11. Reframe the Project Around Satisfaction vs. Loyalty
**Date:** September 9, 2026

A more useful business problem emerged:

**A positive customer experience is not necessarily the same thing as a customer relationship strong enough to generate continued patronage.**

Some reviews contain strong praise without any evidence that the customer intends to return.

Other reviews describe meaningful problems while also showing explicit future return intent or continued repeat patronage.

The refined business question became:

**Which café experience factors are associated with customers' stated intent to return, and which positive experience factors appear to preserve return intent despite negative experiences?**

### Return-signal rule

**Yes**  
Explicit future return or clear evidence of ongoing/repeated patronage.

**No**  
Explicit intention to discontinue patronage or take future business elsewhere.

**None**  
No clear evidence of future or continued patronage.

Strong enthusiasm, recommendations to others, or a desire to remain in the café during the current visit are not sufficient on their own to establish a return signal.

---

## 12. Conduct Final Human QA Spot-Check
**Date:** September 9, 2026

Before moving into SQL, I conducted a stratified manual QA spot-check across:

- Yes
- No
- None

Each audited review was checked against the original full review text for:

- theme assignment;
- theme-level sentiment;
- return-signal classification.

All reviews in the final QA spot-check passed without requiring correction.

This was treated as a consistency check rather than a formal statistical estimate of AI accuracy.

---

## 13. Move Into SQL Analysis

With the coding framework and QA complete, the analytical dataset was frozen.

The next phase uses SQL to compare:

1. experience themes associated with Yes vs. No return signals;
2. theme sentiment within those groups;
3. reviews containing both negative experiences and continued return signals;
4. positive experience factors that appear to distinguish retained from lost customers.

The final goal is to move from customer language to actionable insight about the difference between **satisfaction and retention**.

---

## 14. Isolate Return Resilience

**Date:** September 12, 2026

I narrowed the analysis to reviews containing at least one negatively coded theme:

- 52 reviews with a Yes return signal
- 41 reviews with a No return signal

This created a more direct comparison between customers who experienced friction but still indicated continued patronage and customers who experienced friction and indicated non-return.

For each theme, I compared positive-theme prevalence as a potential return buffer and negative-theme prevalence as a potential relationship breaker.

Service / Treatment and Distinctiveness showed the clearest two-sided differences, while several operational themes appeared more tolerable.

---

## 15. Return to the Customer Language

Aggregate differences were treated as signals for further investigation rather than findings on their own.

I retrieved the underlying reviews for Service / Treatment and Distinctiveness.

Service cases suggested a meaningful contrast between ordinary interpersonal warmth among customers who still returned and language describing dismissal, condescension, or feeling unwelcome among customers who withdrew future business.

Distinctiveness cases suggested another possible mechanism: customers who continued patronage often described a specific reason the café remained worth choosing, while non-return reviews more often framed the café as replaceable or undifferentiated.

These interpretations remain exploratory and non-causal.

---

## 16. Test Rating Severity as a Confound

The No-return group was disproportionately concentrated in Low-rating reviews, so I tested whether the Service pattern persisted within comparable rating tiers.

Among Low-rating reviews containing a negative experience:

- positive Service appeared in 23.5% of Yes reviews vs. 6.1% of No reviews;
- negative Service appeared in 35.3% of Yes reviews vs. 63.6% of No reviews.

The pattern therefore remained visible even among customers who were similarly dissatisfied overall.

The Mixed-rating subgroup did not reproduce the same pattern clearly and contained only eight No reviews, so the result is treated cautiously rather than as evidence of an independent causal effect.

---

## 17. Freeze the SQL Analysis

The SQL phase was stopped once the primary business question had been addressed and the strongest pattern had been stress-tested.

The final analysis package includes:

- data validation;
- return-signal theme comparison;
- return-resilience analysis;
- rating-tier robustness checks;
- aggregate analytical outputs for visualization.

The strongest exploratory finding is that interpersonal treatment appears more closely associated with stated relationship continuation than several other forms of friction in this sample.

SQL scripts and aggregate outputs are available in the `/sql` and `/outputs` folders.
