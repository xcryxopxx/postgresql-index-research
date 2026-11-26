-- Preliminary selectivity experiments
-- Dataset: 1,000,000 transactions

-- Test 1: approximately 0.01%
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM transactions_normal
WHERE customer_id = 42;

-- Test 2: approximately 1%
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM transactions_normal
WHERE customer_id <= 100;

-- Test 3: approximately 10%
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM transactions_normal
WHERE customer_id <= 1000;

-- Test 4: approximately 25%
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM transactions_normal
WHERE customer_id <= 2500;

-- Test 5: approximately 50%
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM transactions_normal
WHERE customer_id <= 5000;

-- Test 6: 100%
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM transactions_normal
WHERE customer_id <= 10000;

-- Experiment 3: Index storage overhead

-- Total relation sizes
SELECT
    pg_size_pretty(
        pg_relation_size('transactions_normal')
    ) AS table_size,
    pg_size_pretty(
        pg_indexes_size('transactions_normal')
    ) AS indexes_size,
    pg_size_pretty(
        pg_total_relation_size('transactions_normal')
    ) AS total_size;

-- Individual index sizes
SELECT
    indexrelname AS index_name,
    pg_size_pretty(
        pg_relation_size(indexrelid)
    ) AS index_size
FROM pg_stat_user_indexes
WHERE schemaname = 'public'
  AND relname = 'transactions_normal'
ORDER BY indexrelname;

-- Exact sizes and relative storage overhead
SELECT
    pg_relation_size(
        'transactions_normal'
    ) AS table_bytes,
    pg_indexes_size(
        'transactions_normal'
    ) AS indexes_bytes,
    pg_total_relation_size(
        'transactions_normal'
    ) AS total_bytes,
    ROUND(
        100.0 *
        pg_indexes_size('transactions_normal') /
        pg_relation_size('transactions_normal'),
        2
    ) AS index_overhead_percent;