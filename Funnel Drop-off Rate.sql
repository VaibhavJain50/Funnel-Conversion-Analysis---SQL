

/* Purpose:
    - To measure user drop-off at each stage of a conversion funnel.
    - To identify which funnel steps have the highest abandonment rates.
    - To optimize user experience and increase overall conversion by analyzing behavior trends.

SQL Functions Used:
    - Window Functions: LAG() to compare users between funnel steps.
    - Aggregate Functions: COUNT() to count users at each step.
    - Conditional Logic: IFNULL() to handle null values in calculations.
    - Mathematical Functions: ROUND() for percentage formatting.
    - String Functions: CONCAT() to format drop-off percentages.

*/

with funnel_step as (
select event_type,
count(user_id) as users_reached
from user_events
group by event_type
)
select event_type,
users_reached,
concat(ifnull((round(1-(users_reached/lag(users_reached) over()),1))*100,0),"%")
as Drop_percentage_by_funnel,
concat(ifnull((round(1-(users_reached/(select users_reached from funnel_step where event_type='Visit')),1))*100,0),"%")
as Drop_percentage_by_total
from funnel_step