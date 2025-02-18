-- Note: The following queries are based off the code in the sqlCreateTables.SQL file in this repository.

-- This query is used to retrieve the employee hierarchy.

SELECT e1.empID, e1.firstname, e1.lastname, 
       e2.empID AS managerID, e2.firstname AS manager_firstname, e2.lastname AS manager_lastname
FROM Employees e1
LEFT JOIN Employees e2 ON e1.mgrid = e2.empID;

-- This query is used to retrieve the top 5 customers by their total order value.

SELECT c.custID, c.companyname, SUM(od.unitprice * od.qty * (1 - od.discount)) AS total_spent
FROM Customers c
JOIN Orders o ON c.custID = o.custID
JOIN OrderDetails od ON o.orderID = od.orderID
GROUP BY c.custID, c.companyname
ORDER BY total_spent DESC
LIMIT 5;

-- This query is used to retrieve the top 5 most popular products.

SELECT p.productID, p.productname, SUM(od.qty) AS total_quantity_sold
FROM OrderDetails od
JOIN Products p ON od.productID = p.productID
GROUP BY p.productID, p.productname
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- This query ranks employees based on the amount of orders they've handled.

SELECT e.empID, e.firstname, e.lastname, COUNT(o.orderID) AS total_orders,
       RANK() OVER (ORDER BY COUNT(o.orderID) DESC) AS rank
FROM Employees e
JOIN Orders o ON e.empID = o.empID
GROUP BY e.empID, e.firstname, e.lastname
ORDER BY total_orders DESC;

-- This query is used to retrieve the monthly sales revenue.

SELECT YEAR(orderdate) AS order_year, MONTH(orderdate) AS order_month,
       SUM(od.unitprice * od.qty * (1 - od.discount)) AS monthly_revenue
FROM Orders o
JOIN OrderDetails od ON o.orderID = od.orderID
GROUP BY YEAR(orderdate), MONTH(orderdate)
ORDER BY order_year DESC, order_month DESC;
