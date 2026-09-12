# Review Coding Codebook

This codebook was developed to transform unstructured café review language into structured customer-experience data while preserving the complexity of mixed experiences.

The framework was developed through human review before AI-assisted coding was introduced.

## Codebook Status

- **Version:** 1.0
- **Frozen:** August 23, 2026
- **Human pilot:** 11 manually coded reviews across Low, Mixed, and High rating tiers
- **Formal themes:** 13
- **Coding grain:** One unique theme per review
- **Theme sentiment:** Positive / Negative / Mixed / Neutral
- **Return signal:** Yes / No / None

Repeated comments about the same theme within one review are consolidated into a single theme-level observation so that verbose reviewers do not receive additional analytical weight.

---

## How the Codebook Was Developed

Before using AI for classification, I manually explored reviews across the raw Yelp dataset, moving across rating levels and different parts of the corpus rather than relying on a single contiguous sample.

During this discovery phase, I used a thinking-out-loud process to identify recurring customer-experience concepts, challenge whether apparent patterns were genuinely distinct, and refine the boundaries between them.

ChatGPT was used as a structured thought partner during this stage to help articulate and test emerging categories, but the framework itself was grounded in patterns I observed directly in the customer language.

Because I did not record an exact review count for this exploratory phase, I treat it as qualitative discovery rather than a quantified sample.

# Primary Experience Themes

## 1. Product Quality

**What it means:**  
Evaluation of the drinks or food themselves.

**Include:**
- taste
- preparation
- freshness
- quality
- badly made coffee
- the reviewer's direct experience
- explicitly reported experience of someone in the reviewer's immediate visit party

**Do not include:**
- price
- staff behavior
- general hearsay or reputation

---

## 2. Service / Treatment

**What it means:**  
How staff treated or served the customer.

**Include:**
- friendly
- rude
- dismissive
- helpful
- staff attitude

**Do not include:**
- deeper personal recognition or individualized hospitality

---

## 3. Hospitality / Recognition

**What it means:**  
Feeling personally welcomed, known, or cared for.

**Include:**
- "knew my usual"
- owner interaction
- personal attention
- feeling special

**Do not include:**
- merely saying that staff were nice

---

## 4. Atmos / Aesthetic

**What it means:**  
How the café looks or feels.

**Include:**
- beautiful
- cozy
- artsy
- décor
- vibe
- view

**Do not include:**
- Wi-Fi or seating functionality

---

## 5. Functional Environment

**What it means:**  
Whether the space works for what the customer wants to do.

**Include:**
- seating
- Wi-Fi
- outlets
- noise
- studying
- working

**Do not include:**
- aesthetics alone

---

## 6. Value / Price

**What it means:**  
Whether the experience or product feels worth the cost.

**Include:**
- overpriced
- worth it
- portion-to-price value

**Do not include:**
- a price being mentioned without an evaluation of value

---

## 7. Speed / Process Friction

**What it means:**  
Ease or difficulty of getting served.

**Include:**
- waits
- lines
- iPad ordering
- ordering process

**Do not include:**
- parking or location

---

## 8. Convenience / Access

**What it means:**  
Practical ease of using the café.

**Include:**
- hours
- parking
- location

**Do not include:**
- waiting after arriving

---

## 9. Expectation / Reliability

**What it means:**  
Whether what customers expected was delivered.

**Include:**
- repeat consistency
- whether the product matched expectations
- expected wait
- expectation violations

**Do not include:**
- assumptions inferred from a single visit without evidence from the reviewer

---

## 10. Distinctiveness

**What it means:**  
Memorable or signature elements that make the experience stand out.

**Include:**
- signature drinks
- unusual presentation
- special details
- unique concepts

**Do not include:**
- generic praise such as "good coffee"

---

## 11. Cleanliness / Maintenance

**What it means:**  
Customer evaluation of the cleanliness, upkeep, or physical maintenance of the café environment or equipment.

**Include:**
- dirty or sticky tables
- dust
- bathrooms
- visibly clean spaces
- poor upkeep

**Do not include:**
- aesthetics or design unless the issue specifically concerns cleanliness or maintenance

---

## 12. Product Options / Accommodation

**What it means:**  
Customer evaluation of whether the menu provides options that suit their needs or circumstances.

**Include:**
- alternative milks
- dietary options
- child-friendly portions
- substitutions
- availability of expected options

**Do not include:**
- whether the product tastes good; this remains Product Quality

---

## 13. Other / Emerging

**What it means:**  
Something meaningful to the customer experience that does not fit the existing framework.

**Include:**
- potentially meaningful new or repeated ideas

**Do not include:**
- one-off trivia that does not affect the customer experience

---

# Theme-Level Sentiment

Each coded theme receives its own sentiment classification:

- **Positive**
- **Negative**
- **Mixed**
- **Neutral**

Theme sentiment is intentionally separate from the review's overall star rating.

A customer can, for example, give a low overall rating while praising Product Quality, or give a high overall rating while criticizing Functional Environment.

---

# Return / Loyalty Signal

Return signal is coded once at the **review level**, separately from theme-level coding.

The final rule used for analysis is:

### Yes

The review contains either:

- explicit future return intent; or
- clear evidence of ongoing or repeated patronage.

Examples of qualifying language include statements equivalent to:

- "I'll be back."
- "I'll give them another try."
- "I come here regularly."
- descriptions showing repeated continued visits.

### No

The reviewer explicitly indicates an intention to discontinue patronage or take future business elsewhere.

Examples include statements equivalent to:

- "I won't be coming back."
- "They lost my business."
- "I'll go somewhere else next time."

### None

There is no clear evidence of future return, continued patronage, or intended withdrawal.

Importantly, the following are **not sufficient on their own** to establish a Yes signal:

- strong enthusiasm
- recommending the business to others
- saying the reviewer could stay at the café all day
- general satisfaction
- historical product consumption without clear evidence of continued patronage

This distinction prevents satisfaction from being treated automatically as loyalty.

---

# Evidence Rules

`evidence_excerpt` supports the **theme assignment**, not the return signal.

For example, an excerpt attached to `Product Quality` should demonstrate why Product Quality was coded.

Return signal is evaluated separately using the **full review text**.

This separation allows a single review to simultaneously contain:

- a positive product experience;
- a negative service experience;
- and a Yes, No, or None return signal.

---

# Important Coding Boundaries

Several rules emerged during human pilot coding:

- A product being mentioned does not automatically qualify as Product Quality; the customer must evaluate it.
- A price being mentioned does not automatically qualify as Value / Price; the customer must evaluate whether the experience or product was worth the cost.
- Atmos / Aesthetic describes how the space looks or feels, while Functional Environment describes whether the space supports what the customer is trying to do.
- Basic friendliness belongs under Service / Treatment; personal recognition or individualized care belongs under Hospitality / Recognition.
- General enthusiasm does not automatically qualify as a return signal.

These boundaries were established before the framework was scaled through AI-assisted coding.

---

# Emerging Concept: Food Safety / Handling

Food-safety and handling concerns emerged repeatedly during scaled coding, including references to hygiene practices, allergens, cross-contamination, and sanitary behavior.

Because Codebook v1.0 had already been frozen, the framework was **not changed mid-analysis**.

These cases remained under `Other / Emerging` for later evaluation rather than being promoted retroactively to a new formal theme.

## Why It Was Not Promoted to a Formal Code

The emergence of a potentially important issue does not automatically justify adding a new analytical code.

Before promoting a concept to the formal codebook, I would want evidence that it:

- recurs enough to represent a meaningful pattern rather than isolated incidents;
- is conceptually distinct from existing themes;
- can be defined with clear inclusion and exclusion rules;
- can be applied consistently across the analytical sample;
- and materially improves the ability of the framework to answer the business question.

Food Safety / Handling appeared important enough to flag, but because it emerged after the codebook had been frozen and had not yet been systematically evaluated against these criteria, I chose not to promote it mid-analysis.

Instead, these cases remained under `Other / Emerging` and were documented as a candidate for future Codebook v2.0 evaluation.

---

# Coding Workflow

The framework followed this sequence:

**Human discovery → human pilot → codebook refinement → codebook freeze → AI calibration on unseen reviews → AI-assisted coding → human QA spot-check**

AI-assisted classifications were not treated as ground truth.
