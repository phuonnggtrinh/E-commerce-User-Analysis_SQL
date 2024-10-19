-- Query 01: calculate total visit, pageview, transaction for Jan, Feb and March 2017 (order by month)
select format_date('%Y%m' ,parse_date ('%Y%m%d', date) )as month				
      , count(totals.visits) as visits				
      , sum(totals.pageviews) as pageviews				
      , sum(totals.transactions) as transactions				
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`				
where _table_suffix between '0101' and '0331'				
group by month				
order by month;	

-- Query 02: Bounce rate per traffic source in July 2017
select  trafficSource.source as source 		
      ,count(totals.visits) as total_visits				
      ,count(totals.bounces) as total_no_of_bounces
      ,round(100.00 * count(totals.bounces) / count(totals.visits), 3) as bounce_rate
from `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`	
group by trafficSource.source	
order by total_visits desc;

-- Query 3: Revenue by traffic source by week, by month in June 2017
with week_revenue as (
      select distinct trafficSource.source as source
            ,format_date('%Y%W' ,parse_date ('%Y%m%d', date) )as time  
            ,round(sum(product.productRevenue) / 1000000, 4) as revenue
      FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
        UNNEST (hits) hits,	
        UNNEST (hits.product) product	
      group by 1,2
      order by 3 desc )
, month_revenue as ( 
      select distinct trafficSource.source as source
            ,format_date('%Y%m' ,parse_date ('%Y%m%d', date) )as time
            ,round(sum(product.productRevenue) / 1000000, 4) as revenue
      FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
        UNNEST (hits) hits,	
        UNNEST (hits.product) product	
      group by 1,2
      order by 3 desc) 
select 'month' as time_type, time, source, revenue
from month_revenue 
UNION ALL 
select 'week' as time_type, time, source, revenue
from week_revenue 
order by revenue desc;

--Query 04: Average number of product pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017

with purchaser_data as(
    select
        format_date("%Y%m",parse_date("%Y%m%d",date)) as month,
        (sum(totals.pageviews)/count(distinct fullvisitorid)) as avg_pageviews_purchase,
    from `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
      ,unnest(hits) hits
      ,unnest(product) product
    where _table_suffix between '0601' and '0731'
    and totals.transactions>=1
    and product.productRevenue is not null
    group by month)
,non_purchaser_data as(
    select
        format_date("%Y%m",parse_date("%Y%m%d",date)) as month,
        sum(totals.pageviews)/count(distinct fullvisitorid) as avg_pageviews_non_purchase,
    from `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
        ,unnest(hits) hits
      ,unnest(product) product
    where _table_suffix between '0601' and '0731'
    and totals.transactions is null
    and product.productRevenue is null
    group by month)
select pd.*,
      avg_pageviews_non_purchase
from purchaser_data pd
full join non_purchaser_data using(month)
order by pd.month;

--Query 05: Average number of transactions per user that purchased in July 2017
select format_date('%Y%m' ,parse_date ('%Y%m%d', date) )as month
      ,sum(totals.transactions) / count(distinct fullVisitorId) as avg_total_transactions_per_user
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST (hits) hits,	
  UNNEST (hits.product) product	
where totals.transactions >=1 
  and product.productRevenue is not null 
group by 1;

--Query 06: Average amount of money spent per session. Only include purchaser data in July 2017
select format_date('%Y%m' ,parse_date ('%Y%m%d', date) )as month
      ,(sum(product.productRevenue)/1000000) / count(totals.visits) as avg_revenue_by_user_per_visit
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
  UNNEST (hits) hits,	
  UNNEST (hits.product) product	
where totals.transactions is not null 
  and product.productRevenue is not null 
group by 1;

--Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered.

with buyer_list as(
    SELECT
        distinct fullVisitorId
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
    , UNNEST(hits) AS hits
    , UNNEST(hits.product) as product
    WHERE product.v2ProductName = "YouTube Men's Vintage Henley"
    AND totals.transactions>=1
    AND product.productRevenue is not null)

SELECT
  product.v2ProductName AS other_purchased_products,
  SUM(product.productQuantity) AS quantity
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
, UNNEST(hits) AS hits
, UNNEST(hits.product) as product
JOIN buyer_list using(fullVisitorId)
WHERE product.v2ProductName != "YouTube Men's Vintage Henley"
 and product.productRevenue is not null
GROUP BY other_purchased_products
ORDER BY quantity DESC;

-- Query 08: Calculate cohort map from product view to add to cart to purchase in Jan, Feb and March 2017.
with product_data as(
    select
        format_date('%Y%m', parse_date('%Y%m%d',date)) as month,
        count(CASE WHEN eCommerceAction.action_type = '2' THEN product.v2ProductName END) as num_product_view,
        count(CASE WHEN eCommerceAction.action_type = '3' THEN product.v2ProductName END) as num_add_to_cart,
        count(CASE WHEN eCommerceAction.action_type = '6' and product.productRevenue is not null THEN product.v2ProductName END) as num_purchase
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
    ,UNNEST(hits) as hits
    ,UNNEST (hits.product) as product
    where _table_suffix between '20170101' and '20170331'
    and eCommerceAction.action_type in ('2','3','6')
    group by month
    order by month)
select
    *,
    round(num_add_to_cart/num_product_view * 100, 2) as add_to_cart_rate,
    round(num_purchase/num_product_view * 100, 2) as purchase_rate
from product_data;
