--A
SELECT DISTINCT '18-25' as age, avg(sum(i.price)) OVER () as average FROM
(SELECT userid FROM Users WHERE age BETWEEN 18 AND 25) as u
LEFT JOIN purchases as p ON u.userid = p.userid
LEFT JOIN items as i ON p.itemid = i.itemid
GROUP BY date_trunc('month', p.date)
UNION ALL
SELECT DISTINCT '26-35' as age, avg(sum(i.price)) OVER () as average FROM
(SELECT userid FROM Users WHERE age BETWEEN 26 AND 35) as u
LEFT JOIN purchases as p ON u.userid = p.userid
LEFT JOIN items as i ON p.itemid = i.itemid
GROUP BY date_trunc('month', p.date);

--B
SELECT mon FROM (
  SELECT 
      sum(i.price) as summ, 
      max(sum(i.price)) OVER () as average, 
      EXTRACT(month FROM p.date) as mon
  FROM
  (SELECT userid FROM Users WHERE age >= 35 ) as u
  LEFT JOIN purchases as p ON u.userid = p.userid
  LEFT JOIN items as i ON p.itemid = i.itemid
  GROUP by mon
) as a 
WHERE a.summ = a.average;

--C
SELECT y.itemid, sum(i.price) as summ FROM 
	(SELECT itemid FROM purchases
		WHERE EXTRACT(year FROM date) = EXTRACT(year FROM CURRENT_DATE)
    ) as y
LEFT JOIN items i ON y.itemid = i.itemid
GROUP by y.itemid
ORDER by summ DESC
LIMIT 1

--D
select p.itemid, ROUND(sum(i.price)/(sum(sum(i.price)) over()) * 100, 2) as perc 
from purchases P
LEft JOIN items i ON p.itemid = i.itemid
GROUP by p.itemid
ORDER by sum(i.price) DESC
LIMIT 3
