create table if not exists events_bronze(
    event_id varchar(20),
    user_id varchar(20),
    session_id varchar(20),
    event_type varchar(20),
    event_ts timestamp,
    ingestion_ts timestamp default current_timestamp,
    device varchar(20)
)