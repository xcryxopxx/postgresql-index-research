-- Generate 1,000,000 synthetic transactions
-- Approximately uniform data distribution

BEGIN;

-- Remove existing synthetic data to avoid duplicates
TRUNCATE TABLE transactions_normal;

-- Set a seed for reproducibility
SELECT setseed(0.42);

-- Generate synthetic transactions
INSERT INTO transactions_normal (
    id,
    created_at,
    customer_id,
    category_code,
    amount,
    payload
)
SELECT
    gs,
    TIMESTAMP '2025-01-01'
        + random() * INTERVAL '365 days',
    1 + floor(random() * 10000)::INTEGER,
    1 + floor(random() * 20)::INTEGER,
    round((1 + random() * 999)::NUMERIC, 2),
    repeat(md5(gs::TEXT), 3)
FROM generate_series(1, 1000000) AS gs;

COMMIT;

-- Update PostgreSQL table statistics
ANALYZE transactions_normal;