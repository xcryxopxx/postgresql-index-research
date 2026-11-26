-- Validate the synthetic dataset

-- 1. Total number of transactions
SELECT COUNT(*) AS total_transactions
FROM transactions_normal;

-- 2. Sample transactions
SELECT *
FROM transactions_normal
ORDER BY id
LIMIT 10;

-- 3. Dataset integrity
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT id) AS unique_ids,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT category_code) AS unique_categories,
    MIN(created_at) AS first_transaction,
    MAX(created_at) AS last_transaction,
    MIN(amount) AS min_amount,
    MAX(amount) AS max_amount
FROM transactions_normal;

-- 4. Monthly distribution
SELECT
    date_trunc('month', created_at)::DATE AS month,
    COUNT(*) AS transactions
FROM transactions_normal
GROUP BY 1
ORDER BY 1;

-- 5. Storage size
SELECT
    pg_size_pretty(
        pg_relation_size('transactions_normal')
    ) AS table_size,
    pg_size_pretty(
        pg_total_relation_size('transactions_normal')
    ) AS total_size;

-- 6. Selectivity validation
SELECT
    COUNT(*) AS matching_rows,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM transactions_normal),
        4
    ) AS selectivity_percent
FROM transactions_normal
WHERE customer_id <= 100;