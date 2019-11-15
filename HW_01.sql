USE base1;
-- ������� 2
SELECT (select o_date from orders order by o_date limit 1) as `from`, (select o_date from orders order by o_date desc limit 1) as `to`; -- ������ � ����

-- ������� 3
SELECT COUNT(*) line from orders; -- ���������� �����

SELECT COUNT(id_o) `orders` from orders; -- ���������� �������

SELECT COUNT(DISTINCT user_id) unic_user from orders; -- ���������� ������������

SELECT DISTINCT user_id unic_user from orders ORDER BY user_id; -- ���� ���������� ������������

-- ������� 4
SELECT COUNT(id_o) count_orders, ROUND(AVG(price),2) AVG_price, year(o_date) From_Year from orders GROUP BY year(o_date); -- ���������� ������� � ������� ����� �� ���� �����������

SELECT COUNT(DISTINCT user_id) unic_user, year(o_date) from orders GROUP BY year(o_date); -- ���������� ������������ �� ���� �����������

SELECT (COUNT(id_o)/count(DISTINCT user_id)) as AVG_orders, year(o_date) from orders GROUP BY year(o_date); -- ������� ���������� ������� �� ������������ �� ���� �����������

SELECT user_id, COUNT(id_o) from orders GROUP BY user_id ORDER BY count(id_o); -- ������������ � ���������� �� �������

-- ������� 5
SELECT user_id, year(o_date) from orders where year(o_date) LIKE '2016' and user_id not in (select user_id from orders where year(o_date) = '2017'); -- ������ � ����� � �� ������ ���

SELECT count(user_id), year(o_date) from orders where year(o_date) LIKE '2016' and user_id not in (select user_id from orders where year(o_date) = '2017'); -- ���������� ����� �������������

-- ������� 6
SELECT user_id ,count(id_o) from orders GROUP BY user_id ORDER BY count(id_o) DESC limit 1; -- ����� �������� ������������

