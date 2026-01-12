CREATE TABLE IF NOT EXISTS payments_bronze (
    payment_id        VARCHAR(50),
    order_id          VARCHAR(50),
    payment_status    VARCHAR(20),   -- SUCCESS, FAILED, REFUNDED
    payment_amount    NUMERIC(10,2),
    payment_method    VARCHAR(30),
    payment_ts        TIMESTAMP,

    -- metadata
    source_system     VARCHAR(50),
    ingestion_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
