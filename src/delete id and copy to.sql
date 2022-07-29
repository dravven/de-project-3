create table if not exists user_order_log_2(

)

create table if not exists pre_user_order_log
(
    id             serial    not null
        constraint user_order_log_pkey
            primary key,
    date_time      timestamp not null,
    city_id        integer   not null,
    city_name      varchar(100),
    customer_id    integer   not null,
    first_name     varchar(100),
    last_name      varchar(100),
    item_id        integer   not null,
    item_name      varchar(100),
    quantity       bigint,
    payment_amount numeric(10, 2),
    status         text
);

