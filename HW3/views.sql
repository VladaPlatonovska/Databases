CREATE OR REPLACE VIEW TopSellingBooks AS
SELECT
    b.BookID,
    b.Title,
    a.FirstName AS AuthorFirstName,
    a.LastName AS AuthorLastName,
    SUM(si.Quantity) AS TotalSold
FROM
    Books b
    JOIN Authors a ON b.AuthorID = a.AuthorID
    JOIN SaleItems si ON b.BookID = si.BookID
GROUP BY
    b.BookID, b.Title, a.FirstName, a.LastName
ORDER BY
    TotalSold DESC
LIMIT 10;


CREATE OR REPLACE VIEW LowStockAlert AS
SELECT
    BookID,
    Title,
    StockQuantity
FROM
    Books
WHERE
    StockQuantity < 10
ORDER BY
    StockQuantity ASC;