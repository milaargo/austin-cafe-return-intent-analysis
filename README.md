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

## Data Source

The source data comes from [**Yelp Coffee Reviews**](https://www.kaggle.com/datasets/sripaadsrinivasan/yelp-coffee-reviews), a publicly available Kaggle dataset created by **Sripaad Srinivasan** containing Yelp reviews of Austin-area coffee shops.

For this project, I used only the dataset's `raw_yelp_review_data` file as the analytical starting point. I did not use the dataset creator's pre-generated sentiment or attribute outputs because I wanted to develop an independent analytical approach from the original review text.

The sampling strategy, qualitative codebook, return-signal framework, AI-assisted coding workflow, QA process, analytical framing, and resulting findings are my own.

**Source:** Sripaad Srinivasan, *Yelp Coffee Reviews*, Kaggle.

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

Throughout the project, I treated **analytical restraint as part of the method**: emerging patterns were documented without automatically expanding the framework unless they met clear criteria for recurrence, distinctiveness, consistency, and relevance to the business question.

## Project Documentation

- [Project Decision Timeline](notes/project_timeline.md) :how the research question, methodology, and analytical focus evolved throughout the project.
- [Review Coding Codebook](notes/notes/codebook.md) :operational definitions, coding boundaries, return-signal rules, and methodological decisions.

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

The coding framework was developed and tested manually before scaling. After AI-assisted coding, I conducted a stratified human QA spot-check of 15 reviews across Yes, No, and None return-signal categories, reviewing theme assignment, theme sentiment, and return-signal classification.

No discrepancies were identified in the 15-review QA spot-check.

This QA step was used as a consistency check rather than as a formal statistical estimate of AI coding accuracy.

## Tools

- Excel
- SQL
- Power BI
- ChatGPT-assisted qualitative coding

## Project Status

**Coding and QA complete. SQL analysis in progress.**
