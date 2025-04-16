
/*
Purpose:
    - To calculate the total revenue generated across all purchases.
    - To identify top-selling items based on quantity and revenue.
    - To compute Average Order Value (AOV) for overall purchase performance analysis.

SQL Functions Used:
    - Aggregate Functions: SUM() to calculate quantity sold and revenue per item.
    - Window Functions: SUM() OVER() to calculate total revenue across all items.
*/


        
        select item_id,
        sum(quantity) Quantity_sold,
        sum(amount) Revenue_generated,
        sum(sum(amount)) over() as Total_Revenue,
        round(sum(sum(amount)) over()/sum(sum(quantity)) over(),2) as AOV
        from purchase
        group by item_id
        order by item_id;
        