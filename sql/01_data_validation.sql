-- Austin Cafe Return Intent Analysis
-- 01_data_validation.sql
-- Database: DuckDB
-- Purpose: Confirm row counts, join coverage, return-signal distribution,
-- and uniqueness assumptions before analysis.

-- Review-level table: expected 300 reviews
SELECT
    COUNT(*) AS sample_reviews
FROM sample_reviews;

-- Theme-level table: expected 1,069 coded theme rows
SELECT
    COUNT(*) AS coded_theme_rows,
    COUNT(DISTINCT review_id) AS unique_review_ids
FROM coded_themes;

-- Confirm all sampled reviews are represented in coded_themes
SELECT
    COUNT(DISTINCT r.review_id) AS reviews_with_coded_themes
FROM sample_reviews AS r
JOIN coded_themes AS t
    ON r.review_id = t.review_id;

-- Return-signal distribution
SELECT
    return_signal,
    COUNT(*) AS reviews
FROM sample_reviews
GROUP BY return_signal
ORDER BY reviews DESC;

-- Rating-tier distribution
SELECT
    rating_tier,
    COUNT(*) AS reviews
FROM sample_reviews
GROUP BY rating_tier
ORDER BY rating_tier;

-- Check for duplicate review-theme pairs.
-- A clean result returns zero rows.
SELECT
    review_id,
    theme,
    COUNT(*) AS duplicate_rows
FROM coded_themes
GROUP BY review_id, theme
HAVING COUNT(*) > 1
ORDER BY duplicate_rows DESC, review_id, theme;
