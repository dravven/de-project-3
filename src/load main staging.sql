insert into staging.user_order_log(date_time,city_id,city_name,customer_id,first_name,last_name,item_id,item_name,quantity,payment_amount,status)
select date_time,city_id,city_name,customer_id,first_name,last_name,item_id,item_name,quantity,payment_amount,status
from staging.pre_user_order_log;

truncate table staging.pre_user_order_log;