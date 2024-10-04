CREATE INDEX idx_books_publicationyear ON Books(PublicationYear);
CREATE INDEX idx_sales_saledate ON Sales(SaleDate);

WITH RecentSales AS (
    SELECT
        b.BookID,
        SUM(Quantity) AS TotalSold,
        SUM(Quantity * Price) AS TotalRevenue
    FROM
        Sales s
    JOIN
        Books b ON s.BookID = b.BookID
    WHERE
        s.SaleDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
        AND b.PublicationYear >= 2000
    GROUP BY
        s.BookID
    HAVING
        TotalSold > 10
)
SELECT
    a.FirstName,
    a.LastName,
    b.Title,
    b.PublicationYear,
    rs.TotalSold,
    rs.TotalRevenue
FROM
    RecentSales rs
JOIN
    Books b ON rs.BookID = b.BookID
JOIN
    Authors a ON b.AuthorID = a.AuthorID
ORDER BY
    rs.TotalRevenue DESC
LIMIT 100;