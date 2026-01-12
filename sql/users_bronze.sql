CREATE TABLE IF NOT EXISTS users_bronze (
    user_id           VARCHAR(50),
    name              VARCHAR(100),
    email             VARCHAR(150),
    phone             VARCHAR(20),
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP,
    -- metadata
    source_system     VARCHAR(50),
    ingestion_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
