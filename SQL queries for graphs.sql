/*Modifed for graph #1*/
SELECT  
	c.name category, 
	COUNT(r.rental_id) rental_count
FROM 
	category AS c
	JOIN film_category AS fc
	ON c.category_id = fc.category_id
	JOIN film AS f
	ON fc.film_id = f.film_id
	JOIN inventory AS i
	ON f.film_id = i.film_id
	JOIN rental AS r
	ON r.inventory_id = i.inventory_id
	WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	GROUP BY 1
	ORDER BY category;

/*Graph # 2:*/

WITH t1 AS (SELECT 
	c.first_name || ' ' || c.last_name full_name, 
	SUM(p.amount) pay_amount, 
	p.customer_id customer_id
FROM 
	customer AS c
	JOIN payment AS p
	ON c.customer_id = p.customer_id
GROUP BY 
	full_name, 
	p.customer_id
ORDER BY 
	pay_amount DESC
	
LIMIT 
	10),
 
t2 AS (SELECT 
	DATE_TRUNC('month', p.payment_date) pay_month, 
	t1.full_name, 
	COUNT(p.payment_id) pay_countmonth, 
	SUM(p.amount) amount_month
FROM 
	payment AS p
	JOIN t1
	ON p.customer_id = t1.customer_id              
GROUP BY 
	full_name, 
	pay_month
ORDER BY 
	full_name, 
	pay_month, 
	pay_countmonth)
 
SELECT 
	t2.pay_month, 
	t2.full_name, 
	t2.pay_countmonth, 
	t2.amount_month
FROM 
	t2
	JOIN t1
	ON t2.full_name = t1.full_name
GROUP BY 
	t2.pay_month, 
	t2.full_name, 
	t2.pay_countmonth, 
	t2.amount_month
ORDER BY 
	full_name;



/*Graph # 3:*/

WITH t1 AS (SELECT 
	c.first_name || ' ' || c.last_name full_name, 
	SUM(p.amount) pay_amount, 
	p.customer_id customer_id
FROM 
	customer AS c
	JOIN payment AS p
	ON c.customer_id = p.customer_id
GROUP BY 
	full_name, 
	p.customer_id
ORDER BY 
	pay_amount DESC
LIMIT 
	10),
 
t2 AS (SELECT 
	DATE_TRUNC('month', p.payment_date) pay_month, 
	t1.full_name, 
	COUNT(p.payment_id) pay_countmonth, 
	SUM(p.amount) amount_month
FROM 
	payment AS p
	JOIN t1
	ON p.customer_id = t1.customer_id              
GROUP BY 
	full_name, 
	pay_month
ORDER BY 
	full_name, 
	pay_month, 
	pay_countmonth),
 
t3 AS (SELECT 
	t2.pay_month, 
	t2.full_name, 
	t2.pay_countmonth, 
	t2.amount_month
FROM 
	t2
	JOIN t1
	ON t2.full_name = t1.full_name
GROUP BY 
	t2.pay_month, 
	t2.full_name, 
	t2.pay_countmonth, 
	t2.amount_month
ORDER BY 
	full_name)
 
SELECT 
	t3.pay_month, 
	t3.full_name, 
	t3.pay_countmonth, t3.amount_month, 
	ABS((t3.amount_month - LAG(t3.amount_month) OVER (PARTITION BY t3.full_name ORDER BY t3.pay_month))) diff
FROM 
	t3;

/*Graph # 4:*/

WITH t1 AS (SELECT 
	c.first_name || ' ' || c.last_name full_name, 
	SUM(p.amount) pay_amount, 
	p.customer_id customer_id
FROM 
	customer AS c
	JOIN payment AS p
	ON c.customer_id = p.customer_id
GROUP BY 
	full_name, 
	p.customer_id
ORDER BY 
	pay_amount DESC
LIMIT 
	10),
 
t2 AS (SELECT 
	DATE_TRUNC('month', p.payment_date) pay_month, 
	t1.full_name, COUNT(p.payment_id) pay_countmonth, 
	SUM(p.amount) amount_month
FROM 
	payment AS p
	JOIN t1
	ON p.customer_id = t1.customer_id              
GROUP BY 
	full_name, 
	pay_month
ORDER BY 
	full_name, 
	pay_month, 
	pay_countmonth)
 
SELECT 
	t2.pay_month, 
	t2.full_name, 
	t2.pay_countmonth, 
	t2.amount_month
FROM 
	t2
	JOIN t1
	ON t2.full_name = t1.full_name
GROUP BY 
	t2.pay_month, 
	t2.full_name, 
	t2.pay_countmonth, 
	t2.amount_month
ORDER BY 
	full_name;

