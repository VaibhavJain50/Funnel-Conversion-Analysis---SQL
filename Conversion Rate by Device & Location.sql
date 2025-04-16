
/*
Purpose:
    - To analyze conversion rates across different devices (Mobile, Desktop, Tablet).
    - To identify which locations have the highest user conversion rates.
    - To support targeted optimization strategies based on user behavior by device and region.

SQL Functions Used:
    - Aggregate Functions: COUNT() to get user counts per event.
    - Window Functions: LEAD() to access the next funnel step (i.e., Purchase after Visit).
    - Mathematical Functions: ROUND() to format conversion percentages.
    - String Functions: CONCAT() to append percentage symbols to results.
*/

with cte as (
select device,
event_type,
count(user_id) user_count
from user_events
where event_type in ('Visit','Purchase')
group by device,
event_type
order by device,event_type desc
)
select * from (
select device,
concat(round((lead(user_count) over(partition by device))/user_count,1)*100,"%") as conversion_rate
from cte
)t
where conversion_rate is not null
order by conversion_rate desc;

-- ----------------------------------------

with cte as (
select location,
event_type,
count(user_id) user_count
from user_events
where event_type in ('Visit','Purchase')
group by location,
event_type
order by location,event_type desc
)
select * from (
select location,
concat(round((lead(user_count) over(partition by location))/user_count,1)*100,"%") as conversion_rate
from cte
)t
where conversion_rate is not null
order by conversion_rate desc