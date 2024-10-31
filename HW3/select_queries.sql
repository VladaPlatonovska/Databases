
-- books by author and year range
SELECT b.Title, b.PublicationYear, a.FirstName, a.LastName
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
WHERE a.LastName LIKE 'Smith%'
AND b.PublicationYear BETWEEN 2000 AND 2024;

-- sales by date range with book details
SELECT s.SaleDate, si.Quantity, si.UnitPrice, b.Title
FROM Sales s
JOIN SaleItems si ON s.SaleID = si.SaleID
JOIN Books b ON si.BookID = b.BookID
WHERE s.SaleDate BETWEEN '2024-01-01' AND '2024-12-31';

SELECT b.Title, b.StockQuantity, p.Name as Publisher
FROM Books b
JOIN BookPublishers bp ON b.BookID = bp.BookID
JOIN Publishers p ON bp.PublisherID = p.PublisherID
WHERE b.StockQuantity < 10;

SELECT e.FirstName, e.LastName, e.HireDate, ed.PhoneNumber
FROM Employees e
JOIN EmployeeDetails ed ON e.EmployeeID = ed.EmployeeID
WHERE e.HireDate >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);