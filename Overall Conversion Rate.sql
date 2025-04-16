
/* 
Purpose:
    - To calculate conversion rates at each stage of the funnel.
    - To understand how many users successfully move from one funnel step to the next.
    - To measure total conversion rate from the first step (e.g., Visit) to other steps.

SQL Functions Used:
    - Window Functions: LAG() to access previous funnel step counts.
    - Aggregate Functions: COUNT() to count unique users per step.
    - Mathematical Functions: ROUND() for rounding conversion rates.
    - Null Handling: IFNULL() to avoid errors in percentage calculation.
    - String Functions: CONCAT() to display results as percentages.


*/
with funnel_step as (
select event_type,
count(user_id) as users_reached
from user_events
group by event_type
)
select event_type,
users_reached,
concat(ifnull((round((users_reached/lag(users_reached) over()),1))*100,100),"%")
as conversion_percentage_by_funnel,
concat(ifnull((round((users_reached/(select users_reached from funnel_step where event_type='Visit')),1))*100,0),"%")
as conversion_percentage_by_total
from funnel_step