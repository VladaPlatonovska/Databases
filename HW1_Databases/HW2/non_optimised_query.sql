SELECT
    a.FirstName,
    a.LastName,
    b.Title,
    b.PublicationYear,
    SUM(s.Quantity) AS TotalSold,
    SUM(s.Quantity * b.Price) AS TotalRevenue
FROM
    Authors a
JOIN
    Books b ON a.AuthorID = b.AuthorID
JOIN
    Sales s ON b.BookID = s.BookID
WHERE
    b.PublicationYear >= 2000
    AND s.SaleDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY
    a.AuthorID, b.BookID
HAVING
    TotalSold > 10
ORDER BY
    TotalRevenue DESC
LIMIT 100;

-- Dropping indexes
ALTER TABLE Books DROP INDEX idx_books_publicationyear;
ALTER TABLE Sales DROP INDEX idx_sales_saledate;