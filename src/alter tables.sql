
alter table staging.user_order_log add status text;
alter table mart.f_sales add status text;

alter table if exists staging.user_order_log alter column status set default 'shipped';