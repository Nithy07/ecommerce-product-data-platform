CREATE TABLE IF NOT EXISTS products_bronze (
    product_id        VARCHAR(50),
    product_name      VARCHAR(200),
    category           VARCHAR(100),
    price             NUMERIC(10,2),
    available_stock   INTEGER,
    updated_at        TIMESTAMP,

    -- metadata
    source_system     VARCHAR(50),
    ingestion_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
