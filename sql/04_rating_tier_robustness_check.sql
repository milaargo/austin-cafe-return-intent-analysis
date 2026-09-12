-- Austin Cafe Return Intent Analysis
-- 04_rating_tier_robustness_check.sql
-- Purpose: Test whether the return-resilience patterns are partly explained
-- by rating severity.
--
-- The No-return group is concentrated in Low ratings, so this script checks
-- whether key patterns remain when comparing customers within the same tier.
--
-- These checks are exploratory. Small subgroup sizes, especially Mixed-No,
-- limit confidence.

-- ============================================================
-- A. Negative-experience cohort by rating tier and return signal
-- ============================================================

WITH negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal,
        r.rating_tier
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND t.theme_sentiment = 'Negative'
)
SELECT
    rating_tier,
    return_signal,
    COUNT(DISTINCT review_id) AS reviews
FROM negative_experience
GROUP BY rating_tier, return_signal
ORDER BY rating_tier, return_signal;


-- ============================================================
-- B. Service / Treatment within Low and Mixed rating tiers
-- ============================================================

WITH negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal,
        r.rating_tier
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND t.theme_sentiment = 'Negative'
),
group_sizes AS (
    SELECT
        rating_tier,
        return_signal,
        COUNT(DISTINCT review_id) AS total_reviews
    FROM negative_experience
    WHERE rating_tier IN ('Low', 'Mixed')
    GROUP BY rating_tier, return_signal
),
service_counts AS (
    SELECT
        n.rating_tier,
        n.return_signal,

        COUNT(DISTINCT CASE
            WHEN t.theme = 'Service / Treatment'
             AND t.theme_sentiment = 'Positive'
            THEN n.review_id
        END) AS positive_service_reviews,

        COUNT(DISTINCT CASE
            WHEN t.theme = 'Service / Treatment'
             AND t.theme_sentiment = 'Negative'
            THEN n.review_id
        END) AS negative_service_reviews

    FROM negative_experience AS n
    JOIN coded_themes AS t
        ON n.review_id = t.review_id
    WHERE n.rating_tier IN ('Low', 'Mixed')
    GROUP BY n.rating_tier, n.return_signal
)
SELECT
    s.rating_tier,
    s.return_signal,
    g.total_reviews,

    s.positive_service_reviews,
    ROUND(
        100.0 * s.positive_service_reviews / g.total_reviews,
        1
    ) AS positive_service_pct,

    s.negative_service_reviews,
    ROUND(
        100.0 * s.negative_service_reviews / g.total_reviews,
        1
    ) AS negative_service_pct

FROM service_counts AS s
JOIN group_sizes AS g
    ON s.rating_tier = g.rating_tier
   AND s.return_signal = g.return_signal
ORDER BY s.rating_tier, s.return_signal;


-- ============================================================
-- C. Full theme comparison within Low-rating negative experiences
-- ============================================================

WITH low_negative_experience AS (
    SELECT DISTINCT
        r.review_id,
        r.return_signal
    FROM sample_reviews AS r
    JOIN coded_themes AS t
        ON r.review_id = t.review_id
    WHERE r.return_signal IN ('Yes', 'No')
      AND r.rating_tier = 'Low'
      AND t.theme_sentiment = 'Negative'
),
group_sizes AS (
    SELECT
        return_signal,
        COUNT(DISTINCT review_id) AS total_reviews
    FROM low_negative_experience
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

    FROM low_negative_experience AS n
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
ORDER BY negative_breaker_gap_pp DESC;
