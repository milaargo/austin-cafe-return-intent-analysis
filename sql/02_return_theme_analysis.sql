-- Austin Cafe Return Intent Analysis
-- 02_return_theme_analysis.sql
-- Purpose: Compare theme prevalence and theme sentiment between reviews
-- with explicit Yes and No return signals.
--
-- Important: These are exploratory associations, not causal effects.
-- Percentages use distinct review_id so multi-theme reviews are not over-counted.

-- ============================================================
-- A. Theme prevalence by return signal
-- ============================================================

WITH explicit_return AS (
    SELECT
        review_id,
        return_signal
    FROM sample_reviews
    WHERE return_signal IN ('Yes', 'No')
),
group_sizes AS (
    SELECT
        return_signal,
        COUNT(DISTINCT review_id) AS total_reviews
    FROM explicit_return
    GROUP BY return_signal
),
theme_counts AS (
    SELECT
        t.theme,
        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'Yes' THEN r.review_id
        END) AS yes_reviews,
        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'No' THEN r.review_id
        END) AS no_reviews
    FROM explicit_return AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    GROUP BY t.theme
)
SELECT
    theme,
    yes_reviews,
    no_reviews,
    ROUND(
        100.0 * yes_reviews /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS yes_pct,
    ROUND(
        100.0 * no_reviews /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS no_pct,
    ROUND(
        100.0 * yes_reviews /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes')
        -
        100.0 * no_reviews /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS yes_minus_no_gap_pp
FROM theme_counts
ORDER BY ABS(yes_minus_no_gap_pp) DESC;


-- ============================================================
-- B. Theme sentiment by return signal
-- Denominator = reviews in each return group that mention the theme
-- ============================================================

WITH explicit_return AS (
    SELECT
        review_id,
        return_signal
    FROM sample_reviews
    WHERE return_signal IN ('Yes', 'No')
),
theme_summary AS (
    SELECT
        t.theme,

        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'Yes'
            THEN r.review_id
        END) AS yes_theme_reviews,

        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'No'
            THEN r.review_id
        END) AS no_theme_reviews,

        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'Yes'
             AND t.theme_sentiment = 'Positive'
            THEN r.review_id
        END) AS yes_positive,

        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'No'
             AND t.theme_sentiment = 'Positive'
            THEN r.review_id
        END) AS no_positive,

        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'Yes'
             AND t.theme_sentiment = 'Negative'
            THEN r.review_id
        END) AS yes_negative,

        COUNT(DISTINCT CASE
            WHEN r.return_signal = 'No'
             AND t.theme_sentiment = 'Negative'
            THEN r.review_id
        END) AS no_negative

    FROM explicit_return AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    GROUP BY t.theme
)
SELECT
    theme,
    yes_theme_reviews,
    no_theme_reviews,

    ROUND(100.0 * yes_positive / NULLIF(yes_theme_reviews, 0), 1)
        AS yes_positive_pct,
    ROUND(100.0 * no_positive / NULLIF(no_theme_reviews, 0), 1)
        AS no_positive_pct,
    ROUND(
        100.0 * yes_positive / NULLIF(yes_theme_reviews, 0)
        -
        100.0 * no_positive / NULLIF(no_theme_reviews, 0),
        1
    ) AS positive_gap_pp,

    ROUND(100.0 * yes_negative / NULLIF(yes_theme_reviews, 0), 1)
        AS yes_negative_pct,
    ROUND(100.0 * no_negative / NULLIF(no_theme_reviews, 0), 1)
        AS no_negative_pct,
    ROUND(
        100.0 * no_negative / NULLIF(no_theme_reviews, 0)
        -
        100.0 * yes_negative / NULLIF(yes_theme_reviews, 0),
        1
    ) AS negative_gap_toward_no_pp

FROM theme_summary
ORDER BY positive_gap_pp DESC;
