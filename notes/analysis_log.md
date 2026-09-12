# Analysis Log

This document records the main analytical observations from the SQL phase of the project. Findings are exploratory associations based on stated return signals in a balanced 300-review sample and should not be interpreted as causal effects or population estimates.

## 1. Theme Prevalence by Return Signal

Initial SQL comparison showed that theme presence alone was not sufficient to explain return intent.

Several themes appeared more frequently among Yes-return reviews, including Functional Environment, Atmos / Aesthetic, Convenience / Access, and Product Options / Accommodation.

Service / Treatment, Value / Price, and Expectation / Reliability appeared more frequently among No-return reviews.

Because a theme can be discussed positively or negatively, prevalence was treated as a navigation step rather than a final finding.

## 2. Theme Sentiment Added More Separation

Comparing sentiment within themes revealed stronger differences.

Service / Treatment showed one of the clearest reversals:
- positive Service was much more common among Yes-return reviews;
- negative Service was substantially more common among No-return reviews.

Distinctiveness and Value / Price also showed notable differences.

Atmos / Aesthetic was positive in both groups, suggesting that customers can enjoy the environment without that necessarily distinguishing return from non-return.

## 3. Return Resilience Cohort

To examine what happens when customers experience friction, I isolated reviews containing at least one negative theme.

Cohort:
- 52 Yes-return reviews
- 41 No-return reviews

This allowed comparison between customers who experienced a problem but still indicated continued patronage and customers who experienced a problem and indicated non-return.

## 4. Potential Positive Buffers

Within the negative-experience cohort, positive themes with the largest Yes-side gaps included:

- Distinctiveness
- Atmos / Aesthetic
- Convenience / Access
- Service / Treatment
- Functional Environment

These are interpreted as potential buffers rather than causal retention drivers.

Positive Product Quality appeared at similar rates among Yes and No customers, suggesting that good product alone did not explain return resilience particularly well.

## 5. Potential Relationship Breakers

Negative Service / Treatment produced the strongest No-side difference.

Other themes with No-side negative gaps included:
- Distinctiveness
- Product Quality
- Value / Price

Negative Speed / Process Friction appeared at almost identical rates among Yes and No customers, suggesting that some process friction may be tolerated.

## 6. Qualitative Follow-Up: Service

Review-level follow-up showed that positive Service cases generally involved friendliness, kindness, politeness, helpfulness, and small interpersonal gestures.

Negative Service cases frequently involved dismissal, condescension, irritation, rushing, blame, or making customers feel unwelcome.

Several No-return customers still praised other aspects of the café but withdrew future business because of treatment.

Working interpretation:

Interpersonal treatment may influence whether other forms of friction remain tolerable or become relationship-ending.

## 7. Qualitative Follow-Up: Distinctiveness

Positive Distinctiveness cases often gave customers a specific reason to continue choosing the café despite another problem.

Examples included signature products, events, social or family use cases, community value, or memorable experience features.

Negative Distinctiveness cases frequently framed the café as generic, replaceable, or insufficiently differentiated from alternatives.

Working interpretation:

Distinctiveness may provide a reason to tolerate friction, but the smaller sample makes this a secondary exploratory finding.

## 8. Rating-Tier Robustness Check

The No-return group was disproportionately concentrated in Low ratings, creating a potential confound.

Within Low-rating reviews only:

- positive Service: 23.5% Yes vs 6.1% No
- negative Service: 35.3% Yes vs 63.6% No

The Service pattern therefore remained visible among customers who were similarly dissatisfied overall.

The Mixed-rating subgroup did not reproduce the pattern clearly and contained only eight No-return reviews, so the result should not be interpreted as independent evidence across all rating levels.

## 9. Current Evidence Hierarchy

### Strongest exploratory signal
Service / Treatment

### Secondary signal
Distinctiveness

### Possible relationship breaker
Value / Price

### More tolerable or weakly separating friction
Speed / Process Friction, Product Quality within Low ratings, and some Expectation / Reliability issues

## 10. Analytical Guardrails

The analysis does not establish causality.

Return signals represent stated intent or evidence of continued patronage rather than verified transactional retention.

The sample was balanced for comparison rather than population prevalence.

Some subgroups are small.

AI-assisted coding was used after human framework development and calibration and was followed by human QA.
