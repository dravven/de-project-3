create table if not exists staging.pre_user_order_log
(
    id             int,
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
    status         text default 'shipped'
);

alter table staging.user_order_log add IF NOT EXISTS status text;
alter table mart.f_sales add IF NOT EXISTS status text;

alter table if exists staging.user_order_log alter column status set default 'shipped';
