-- количество уникальных пользователей и общая сумма ТО в исходной базе
select count(distinct user_id) users,  ROUND(sum(price),2) `TO`
  from orders;

-- сортируем пользователей по RFM

create or replace view tmp_RFM as
SELECT user_id, price, id_o,
  CASE WHEN TIMESTAMPDIFF(DAY,o_date,date('2018-01-01')) < 30 THEN "3"
       WHEN TIMESTAMPDIFF(DAY,o_date,date('2018-01-01')) >= 30 AND TIMESTAMPDIFF(DAY,o_date,date('2018-01-01')) < 60 THEN "2"
  ELSE "1" end  AS r
  FROM orders
  ORDER BY r;

create or replace view RFM as
select user_id, ROUND(SUM(price),2) summ, COUNT(id_o) `kol-vo`, max(r) r,
    CASE WHEN COUNT(id_o) >= 4 THEN "3"
         WHEN COUNT(id_o) > 1 AND COUNT(id_o) < 4 THEN "2"
    ELSE "1" end AS f,
    CASE WHEN ROUND(SUM(price),2) < 1000 THEN "1"
         WHEN ROUND(SUM(price),2) >= 1000 AND ROUND(SUM(price),2) < 5000 THEN "2"
    ELSE "3" end  AS m
FROM tmp_RFM
GROUP BY user_id ORDER BY count(id_o);


-- группируем VIP, REG, LOST

create or replace view TYPE_USER as
select user_id, summ, CONCAT(r, f, m) rfm, 
  case when (r = 2 and f = 3 and m = 3) or (r = 3 and f = 3 and m = 3) then "VIP"
       when r = 1 then "LOST"
  else "REGULAR" end as type_of_user
  from RFM
order BY type_of_user;


  -- количество пользователей по группам и ТО
select count(user_id), ROUND(sum(summ),2) `TO`
  from TYPE_USER where type_of_user = "VIP"
UNION
select count(user_id), ROUND(sum(summ),2) `TO`
  from TYPE_USER where type_of_user = "REGULAR"
UNION
  select count(user_id), ROUND(sum(summ),2) `TO`
  from TYPE_USER where type_of_user = "LOST";

