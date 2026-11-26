-- Create the unpartitioned transactions table

CREATE TABLE IF NOT EXISTS transactions_normal (
    id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    customer_id INTEGER NOT NULL,
    category_code INTEGER NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payload TEXT NOT NULL
);