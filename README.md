# Austin Café Return Intent Analysis

## Overview

This customer insights project examines the gap between **customer satisfaction and customer retention** using Austin café Yelp reviews.

The project began as a broader analysis of café experience themes. During exploratory analysis, I found a more useful business question: a customer can leave a highly positive review without indicating any intention to return, while another customer can describe meaningful friction and still show evidence of continued patronage.

That distinction became the focus of the analysis.

## Business Question

**Which café experience factors are associated with customers' stated intent to return, and which positive experience factors appear to preserve return intent despite negative experiences?**

## Why This Matters

Star ratings measure how customers evaluate an experience, but they do not necessarily explain whether that experience is strong enough to sustain the customer relationship.

For a business with strong reviews but weaker-than-expected repeat behavior, understanding the difference between **satisfaction and loyalty** may reveal:

- which parts of the experience encourage continued patronage;
- which failures appear to drive customers away;
- which strengths customers are willing to tolerate friction for;
- and which highly praised experiences may still fail to create loyalty.

## Dataset

- 7,616 Austin-area café Yelp reviews in the source dataset
- 300-review analytical sample
- Balanced across Low, Mixed, and High rating tiers
- 13-theme qualitative coding framework
- Theme-level sentiment: Positive, Negative, Mixed, Neutral
- Review-level return signal: Yes, No, None
- 1,069 coded review-theme observations

## Method

1. Human review of raw customer feedback
2. Development of a structured qualitative codebook
3. Human pilot coding
4. AI-assisted coding using the frozen framework
5. Manual calibration and post-coding QA
6. Exploratory analysis in Excel
7. SQL analysis of return and non-return patterns
8. Qualitative interpretation of customer trade-offs
9. Business recommendations and visualization

## Return Signal Definition

**Yes**  
Explicit future return or clear evidence of ongoing/repeated patronage.

**No**  
Explicit intention to stop patronizing the business or take future business elsewhere.

**None**  
No clear evidence of future or continued patronage.

Strong enthusiasm, recommendation to others, or desire to remain at the café during the current visit are not sufficient on their own to establish a return signal.

## QA

AI-assisted coding was not treated as ground truth.

The coding framework was developed and tested manually before scaling. After AI-assisted coding, I conducted an additional stratified human QA spot-check across Yes, No, and None return-signal categories, reviewing theme assignment, theme sentiment, and return-signal classification.

All reviews included in the final QA spot-check passed without requiring correction.

## Tools

- Excel
- SQL
- Power BI
- ChatGPT-assisted qualitative coding

## Project Status

**Coding and QA complete. SQL analysis in progress.**
