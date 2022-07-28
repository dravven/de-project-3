create table mart.f_customer_retention (
    new_customers_count bigint,
    returning_customers_count bigint,
    refunded_customer_count bigint,
    period_name text,
    period_id int,
    item_id int,
    new_customers_revenue numeric(14,2),
    returning_customers_revenue numeric(14,2),
    customers_refunded numeric(14,2),

    foreign key (item_id) references mart.d_item(item_id)
);

insert into mart.f_customer_retention
with shipped as(
select count(case when number = 1 then 1 end) as new_customers_count, count(case when number > 1 then 1 end) as returning_customers_count, item_id, week_id,
       sum(case when number = 1 then revenue end) as new_customers_revenue ,  sum(case when number > 1 then revenue end) as returning_customers_revenue
from
(SELECT count(id) as number, customer_id, item_id, DATE_PART('week',date(date_id::TEXT)) as week_id, sum(payment_amount) as revenue
FROM   mart.f_sales
where status = 'shipped'
group by customer_id, week_id, item_id)t
group by week_id, item_id),
refunded as(
SELECT count(id) as number, item_id, DATE_PART('week',date(date_id::TEXT)) as week_id, sum(payment_amount) as refund
FROM   mart.f_sales
where status = 'refunded'
group by week_id, item_id)
select new_customers_count, returning_customers_count , coalesce(refunded.number, 0) as refunded_customer_coun, 'weekly' as period_name, shipped.week_id as period_id, shipped.item_id, new_customers_revenue, returning_customers_revenue, refund from shipped left join refunded on shipped.item_id = refunded.item_id and shipped.week_id = refunded.week_id;
