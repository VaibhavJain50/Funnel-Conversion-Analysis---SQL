

/* Purpose:
    - To analyze which devices (e.g., Mobile, Desktop) contribute the most to total revenue.
    - To identify high-performing locations in terms of sales volume and revenue.
    - To support targeted marketing, UI optimization, and region-specific strategies based on sales behavior.

SQL Functions Used:
    - Aggregate Functions: SUM() to calculate total quantity sold and total revenue.
    - Joins: JOIN between user_events and purchase tables on user_id to combine user and transaction data.
    - Grouping: GROUP BY device and GROUP BY location to analyze revenue by category.
*/
        
 -- ----------------------------------------------------------------
        
	-- By Device  
    
	select device,
    sum(quantity) total_quantity,
    sum(amount) total_revenue
    from user_events u join purchase p
    on u.user_id  = p.user_id
    group by device;
    
    -- ---------------------------------------------------------------
    
    -- By Location
    
    
    select location,
    sum(quantity) total_quantity,
    sum(amount) total_revenue
    from user_events u join purchase p
    on u.user_id  = p.user_id
    group by location
    