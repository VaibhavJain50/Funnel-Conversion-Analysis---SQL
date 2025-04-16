
        
/*
Purpose:
    - To track daily trends in sales quantity and revenue.
    - To monitor cumulative (running) sales performance over time.
    - To support time-series analysis and identify peaks, dips, and growth patterns.

SQL Functions Used:
    - Window Functions:
    • SUM() OVER(PARTITION BY event_time) to calculate total daily sales and revenue.
    • SUM() OVER(ORDER BY event_time) to compute running totals (cumulative metrics).
*/
        select event_time,
        sum(quantity) over(partition by event_time) as total_quantity,
        sum(amount) over(partition by event_time) as total_revenue,
        sum(quantity) over(order by event_time) as running_quantity,
        sum(amount) over(order by event_time) as running_revenue
        from purchase;