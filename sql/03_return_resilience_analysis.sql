-- Austin Cafe Return Intent Analysis
-- 03_return_resilience_analysis.sql
-- Purpose: Compare customers who experienced at least one negative theme
-- but still expressed Yes return intent versus those who expressed No.
--
-- "Buffer" and "breaker" are working analytical labels:
--   positive buffer gap = positive theme more common among Yes reviews
--   negative breaker gap = negative theme more common among No reviews
--
-- These are exploratory associations, not causal effects.

-- ============================================================
-- A. Negative-experience cohort size
-- ============================================================

WITH negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND t.theme_sentiment = 'Negative'
)
SELECT
    return_signal,
    COUNT(DISTINCT review_id) AS reviews
FROM negative_experience
GROUP BY return_signal
ORDER BY return_signal;


-- ============================================================
-- B. Positive themes among customers with a negative experience
-- ============================================================

WITH negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND t.theme_sentiment = 'Negative'
),
group_sizes AS (
    SELECT
        return_signal,
        COUNT(DISTINCT review_id) AS total_reviews
    FROM negative_experience
    GROUP BY return_signal
),
theme_counts AS (
    SELECT
        t.theme,
        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'Yes'
             AND t.theme_sentiment = 'Positive'
            THEN n.review_id
        END) AS yes_positive,
        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'No'
             AND t.theme_sentiment = 'Positive'
            THEN n.review_id
        END) AS no_positive
    FROM negative_experience AS n
    JOIN coded_themes AS t
        ON n.review_id = t.review_id
    GROUP BY t.theme
)
SELECT
    theme,
    yes_positive,
    no_positive,
    ROUND(
        100.0 * yes_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS yes_positive_pct,
    ROUND(
        100.0 * no_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS no_positive_pct,
    ROUND(
        100.0 * yes_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes')
        -
        100.0 * no_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS positive_buffer_gap_pp
FROM theme_counts
ORDER BY positive_buffer_gap_pp DESC;


-- ============================================================
-- C. Negative themes among customers with a negative experience
-- ============================================================

WITH negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND t.theme_sentiment = 'Negative'
),
group_sizes AS (
    SELECT
        return_signal,
        COUNT(DISTINCT review_id) AS total_reviews
    FROM negative_experience
    GROUP BY return_signal
),
theme_counts AS (
    SELECT
        t.theme,
        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'Yes'
             AND t.theme_sentiment = 'Negative'
            THEN n.review_id
        END) AS yes_negative,
        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'No'
             AND t.theme_sentiment = 'Negative'
            THEN n.review_id
        END) AS no_negative
    FROM negative_experience AS n
    JOIN coded_themes AS t
        ON n.review_id = t.review_id
    GROUP BY t.theme
)
SELECT
    theme,
    yes_negative,
    no_negative,
    ROUND(
        100.0 * yes_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS yes_negative_pct,
    ROUND(
        100.0 * no_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS no_negative_pct,
    ROUND(
        100.0 * no_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No')
        -
        100.0 * yes_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS negative_breaker_gap_pp
FROM theme_counts
ORDER BY negative_breaker_gap_pp DESC;


-- ============================================================
-- D. Combined return-resilience theme summary
-- ============================================================

WITH negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND t.theme_sentiment = 'Negative'
),
group_sizes AS (
    SELECT
        return_signal,
        COUNT(DISTINCT review_id) AS total_reviews
    FROM negative_experience
    GROUP BY return_signal
),
theme_summary AS (
    SELECT
        t.theme,

        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'Yes'
             AND t.theme_sentiment = 'Positive'
            THEN n.review_id
        END) AS yes_positive,

        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'No'
             AND t.theme_sentiment = 'Positive'
            THEN n.review_id
        END) AS no_positive,

        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'Yes'
             AND t.theme_sentiment = 'Negative'
            THEN n.review_id
        END) AS yes_negative,

        COUNT(DISTINCT CASE
            WHEN n.return_signal = 'No'
             AND t.theme_sentiment = 'Negative'
            THEN n.review_id
        END) AS no_negative

    FROM negative_experience AS n
    JOIN coded_themes AS t
        ON n.review_id = t.review_id
    GROUP BY t.theme
)
SELECT
    theme,

    ROUND(
        100.0 * yes_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS yes_positive_pct,

    ROUND(
        100.0 * no_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS no_positive_pct,

    ROUND(
        100.0 * yes_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes')
        -
        100.0 * no_positive /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS positive_buffer_gap_pp,

    ROUND(
        100.0 * yes_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS yes_negative_pct,

    ROUND(
        100.0 * no_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No'),
        1
    ) AS no_negative_pct,

    ROUND(
        100.0 * no_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'No')
        -
        100.0 * yes_negative /
        (SELECT total_reviews FROM group_sizes WHERE return_signal = 'Yes'),
        1
    ) AS negative_breaker_gap_pp

FROM theme_summary
ORDER BY positive_buffer_gap_pp DESC;
