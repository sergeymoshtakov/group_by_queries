SELECT p.name, MIN(s.price)
FROM Magazin.dbo.Product p JOIN Magazin.dbo.Sale s ON s.id_product = p.id
GROUP BY p.name

SELECT p.name
FROM Magazin.dbo.Product p JOIN Magazin.dbo.Sale s ON s.id_product = p.id
GROUP BY p.name
HAVING AVG(s.price) > 50

SELECT c.name AS 'категория', SUM(d.quantity) AS 'количество'
FROM Magazin.dbo.Product p JOIN Magazin.dbo.Category c ON c.id = p.id_category
JOIN Magazin.dbo.Delivery d ON d.id_product = p.id
GROUP BY c.name
HAVING AVG(d.price) > 100

SELECT p.name, SUM(s.price * s.quantity) AS 'сумма продаж'
FROM Magazin.dbo.Product p JOIN Magazin.dbo.Category c ON p.id_category = c.id
JOIN Magazin.dbo.Sale s ON s.id_product = p.id
WHERE c.name = 'Фрукты' OR c.name = 'Конфеты'
GROUP BY p.name

SELECT s.name, MIN(d.price)
FROM Magazin.dbo.Product p JOIN Magazin.dbo.Delivery d ON p.id = d.id_product
JOIN Magazin.dbo.Suplier s ON s.id = d.id_suplier
WHERE d.date_of_delivery > DATEADD(month, -2, GETDATE())
GROUP BY s.name
ORDER BY MIN(d.price) ASC

SELECT pr.name, CONCAT(co.name, ', ', r.name, ', ', c.name, ', ', a.street) AS 'full adress', COUNT(p.name) AS 'количество товаров'
FROM Magazin.dbo.Product p JOIN Magazin.dbo.Producer pr ON p.id_producer = pr.id
JOIN Magazin.dbo.Adress a ON a.id = pr.id_adress
JOIN Magazin.dbo.City c ON c.id = a.id_city
JOIN Magazin.dbo.Region r ON r.id = c.id_region
JOIN Magazin.dbo.Country co ON co.id = r.id_country
JOIN Magazin.dbo.Sale s ON s.id_product = p.id
GROUP BY pr.name, p.name, CONCAT(co.name, ', ', r.name, ', ', c.name, ', ', a.street)
HAVING SUM(s.price) > 500 AND SUM(s.price) < 2000

SELECT TOP 1 c.name
FROM Magazin.dbo.Category c JOIN Magazin.dbo.Product p ON p.id_category = c.id
GROUP BY c.name
ORDER BY SUM(p.quantity) ASC

SELECT c.name, SUM(p.quantity)
FROM Magazin.dbo.Category c JOIN Magazin.dbo.Product p ON p.id_category = c.id
JOIN Magazin.dbo.Delivery d ON d.id_product = p.id
JOIN Magazin.dbo.Suplier s ON s.id = d.id_suplier
GROUP BY c.name, p.name, s.name
HAVING SUM(d.price) > 400 AND (s.name = 'Повна чаша' OR s.name = 'Евротрейд' OR s.name = 'Казахтрейд')