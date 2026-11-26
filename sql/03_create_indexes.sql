-- Create B-Tree indexes for experimental analysis

CREATE INDEX IF NOT EXISTS idx_normal_customer
ON transactions_normal USING BTREE (customer_id);

CREATE INDEX IF NOT EXISTS idx_normal_created_at
ON transactions_normal USING BTREE (created_at);

-- Update table statistics
ANALYZE transactions_normal;