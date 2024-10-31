-- Books table
CREATE INDEX idx_book_title ON Books(Title);  -- books by title
CREATE INDEX idx_book_price ON Books(Price);  -- price range
CREATE INDEX idx_book_publication ON Books(PublicationYear);  -- year
-- Sales table
CREATE INDEX idx_sale_date ON Sales(SaleDate);  -- date sales

