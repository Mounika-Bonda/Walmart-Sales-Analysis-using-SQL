select * from walmartsalesdata

-- Number of cities --
select 
distinct city,
		 branch from walmartsalesdata

-- the most selling product line --
SELECT
	SUM(quantity) as TotalQuantity,
    `Product line`
FROM walmartsalesdata
GROUP BY `Product line`
ORDER BY TotalQuantity DESC;

-- If there are many reecords then we can use cte(temporary tables) to get the results--
with cte1 as 
(SELECT
	SUM(quantity) as TotalQuantity,
    `Product line` as Productline
FROM walmartsalesdata
GROUP BY Productline)
select max(TotalQuantity) as Max_quantity, Productline  from cte1
group by Productline
order by Max_quantity desc

-- Most Common PaymentMethod--
select max(maxpayment),payment from 
	(select count(payment) as maxpayment, 
			payment from walmartsalesdata group by payment) W
group by payment

-- Total Revenue by Month--
select ceil(sum(total)) as Total_revenue,
	   month_name from walmartsalesdata 
group by month_name

-- Largest COGS--
select max(cogs) as LargestCOGS,
	   month_name from walmartsalesdata 
group by month_name 
order by largestcogs desc

-- Product Line with Largest Revenue--
select round(sum(total),2) as total_revenue,`Product line` from walmartsalesdata
group by `Product line`
order by 1 desc;

-- City with Largest Revenue--
select city,round(sum(total),2) as total_city_revenue from walmartsalesdata 
group by city 
order by 2 desc;

-- Product with Largest VAT --
select `Product line`,round(sum(`Tax 5%`),2) as productVAT from walmartsalesdata
group by `Product line`
order by 2 desc; 

-- Good and Bad Product lines--
select `Product line`,round(sum(total),2) as total_sales,
case 
	when sum(total) > avg(total) then 'Good'
	else 'Bad'
end as rating
from walmartsalesdata
group by `Product line`
ORDER BY 2 DESC;

-- Average rating of each Product line--
select `Product line`,round(avg(rating),2) from walmartsalesdata 
group by `Product line`

-- Most common product line by gender--
select `Product line`,gender,count(`Product line`) as No_of_sales from walmartsalesdata 
group by 1,2
order by 3 desc

-- Sales made in each time of the day in all weekdays--
select time_of_day,count(total),
dense_rank() over(order by count(total) desc) as rnk
from walmartsalesdata
where day_name not in ('Saturday','Sunday') 
group by 1
order by 2 desc

-- Customer types brings more revenue --
select `Customer type`,ceil(sum(total)) as total_revenue 
from walmartsalesdata
group by `Customer type`
order by total_revenue desc



										