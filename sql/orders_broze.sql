create table if not exists orders_bronze(
    order_id varchar(20),
    user_id varchar(20),
    order_status varchar(20),
    order_amount numeric(10,2),
    order_ts timestamp,
    updated_ts timestamp,
    src_sym varchar(20),
    ingestion_ts timestamp default current_timestamp

)