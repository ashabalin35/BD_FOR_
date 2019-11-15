USE base1;
-- Задание 2
SELECT (select o_date from orders order by o_date limit 1) as `from`, (select o_date from orders order by o_date desc limit 1) as `to`; -- период в базе

-- Задание 3
SELECT COUNT(*) line from orders; -- количество строк

SELECT COUNT(id_o) `orders` from orders; -- количество заказов

SELECT COUNT(DISTINCT user_id) unic_user from orders; -- уникальные пользователи

SELECT DISTINCT user_id unic_user from orders ORDER BY user_id; -- сами уникальные пользователи

-- Задание 4
SELECT COUNT(id_o) count_orders, ROUND(AVG(price),2) AVG_price, year(o_date) From_Year from orders GROUP BY year(o_date); -- количество заказов и средний прайс по году увеличились

SELECT COUNT(DISTINCT user_id) unic_user, year(o_date) from orders GROUP BY year(o_date); -- уникальные пользователи по году увеличились

SELECT (COUNT(id_o)/count(DISTINCT user_id)) as AVG_orders, year(o_date) from orders GROUP BY year(o_date); -- среднее количество заказов на пользователя по году уменьшилось

SELECT user_id, COUNT(id_o) from orders GROUP BY user_id ORDER BY count(id_o); -- пользователи и количество их заказов

-- Задание 5
SELECT user_id, year(o_date) from orders where year(o_date) LIKE '2016' and user_id not in (select user_id from orders where year(o_date) = '2017'); -- купили в одном а во второн нет

SELECT count(user_id), year(o_date) from orders where year(o_date) LIKE '2016' and user_id not in (select user_id from orders where year(o_date) = '2017'); -- количество таких пользователей

-- Задание 6
SELECT user_id ,count(id_o) from orders GROUP BY user_id ORDER BY count(id_o) DESC limit 1; -- самый активный пользователь

