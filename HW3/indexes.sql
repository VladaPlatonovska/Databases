-- Indexes for Authors table
CREATE INDEX idx_author_name ON Authors(LastName, FirstName);  -- For searching authors by name
CREATE INDEX idx_author_birthdate ON Authors(BirthDate);  -- For age-related queries

-- Indexes for Books table
CREATE INDEX idx_book_title ON Books(Title);  -- For searching books by title
CREATE INDEX idx_book_price ON Books(Price);  -- For price range queries
CREATE INDEX idx_book_publication ON Books(PublicationYear);  -- For year-based searches
CREATE INDEX idx_book_stock ON Books(StockQuantity);  -- For inventory management
-- Composite index for common book search patterns
CREATE INDEX idx_book_author_year ON Books(AuthorID, PublicationYear);

-- Indexes for Sales table
CREATE INDEX idx_sale_date ON Sales(SaleDate);  -- For date-based sales queries
CREATE INDEX idx_sale_amount ON Sales(TotalAmount);  -- For revenue analysis

-- Indexes for SaleItems table
CREATE INDEX idx_saleitem_book ON SaleItems(BookID, Quantity);  -- For book sales analysis
CREATE INDEX idx_saleitem_sale ON SaleItems(SaleID, UnitPrice);  -- For sale details
-- Composite index for sales analysis
CREATE INDEX idx_saleitem_complete ON SaleItems(SaleID, BookID, Quantity, UnitPrice);

-- Indexes for Publishers table
CREATE INDEX idx_publisher_name ON Publishers(Name);  -- For publisher searches
CREATE INDEX idx_publisher_year ON Publishers(FoundedYear);  -- For historical queries

-- Indexes for BookPublishers table
CREATE INDEX idx_bookpub_date ON BookPublishers(PublicationDate);  -- For publication timeline
-- Composite index for book-publisher relationship
CREATE INDEX idx_bookpub_complete ON BookPublishers(BookID, PublisherID, PublicationDate);

-- Indexes for Employees table
CREATE INDEX idx_employee_name ON Employees(LastName, FirstName);  -- For employee searches
CREATE INDEX idx_employee_email ON Employees(Email);  -- For login/authentication
CREATE INDEX idx_employee_hire ON Employees(HireDate);  -- For employment duration queries

-- Indexes for EmployeeDetails table
CREATE INDEX idx_empdetails_phone ON EmployeeDetails(PhoneNumber);  -- For contact information searches