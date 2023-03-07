-- Lab 6 - BAKERY
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `BAKERY`;
-- Q1
SELECT customers.FirstName, customers.LastName,
    COUNT(DISTINCT receipts.RNumber) AS Purchases
FROM receipts, customers
WHERE receipts.Customer = customers.CId
GROUP BY customers.CId
HAVING COUNT(DISTINCT receipts.RNumber) > 10
ORDER BY customers.LastName;


USE `BAKERY`;
-- Q2
SELECT goods.Flavor, COUNT(items.Item) AS TimesPurchased,
    COUNT(DISTINCT customers.CId) AS UniqueCustomers,
    COUNT(items.Item) * goods.PRICE AS TotalRevenue
FROM items, goods, receipts, customers
WHERE items.Item = goods.GId
    AND items.Receipt = receipts.RNumber
    AND receipts.Customer = customers.CId
    AND goods.Food = 'Cookie'
GROUP BY items.Item
ORDER BY goods.Flavor;


USE `BAKERY`;
-- Q3
SELECT DATE_FORMAT(receipts.SaleDate, '%W') AS Day,
    GROUP_CONCAT(DISTINCT receipts.SaleDate) AS Date,
    COUNT(DISTINCT receipts.RNumber) AS NumPurchases,
    COUNT(*) AS NumPastries,
    SUM(goods.PRICE) AS Revenue
FROM items, receipts, goods
WHERE items.Receipt = receipts.RNumber
    AND items.Item = goods.GId
    AND receipts.SaleDate >= '2007-10-15'
    AND receipts.SaleDate <= '2007-10-21'
GROUP BY DATE_FORMAT(receipts.SaleDate, '%W')
ORDER BY GROUP_CONCAT(DISTINCT WEEKDAY(receipts.SaleDate));


USE `BAKERY`;
-- Q4
SELECT customers.FirstName, customers.LastName, receipts.RNumber,
    SUM(goods.PRICE) AS TotalPrice
FROM items, receipts, goods, customers
WHERE items.Receipt = receipts.RNumber
    AND items.Item = goods.GId
    AND receipts.Customer = customers.CId
GROUP BY receipts.RNumber
HAVING SUM(goods.PRICE) >= 25
ORDER BY SUM(goods.PRICE) DESC;


USE `BAKERY`;
-- TODO: Q5
SELECT customers.LastName, customers.FirstName,
    COUNT(DISTINCT receipts.RNumber) AS FiveItemPurchases
FROM items, receipts, customers
WHERE items.Receipt = receipts.RNumber
    AND receipts.Customer = customers.CId
    AND items.Ordinal = 5
GROUP BY customers.CId
ORDER BY MAX(receipts.SaleDate), customers.LastName;
