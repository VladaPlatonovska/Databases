DROP DATABASE IF EXISTS BookstoreDB;
-- Use the existing database
CREATE DATABASE IF NOT EXISTS BookstoreDB;
USE BookstoreDB;

-- Recreate Authors table
DROP TABLE IF EXISTS Authors;
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL COMMENT 'Author''s first name',
    LastName VARCHAR(50) NOT NULL COMMENT 'Author''s last name',
    BirthDate DATE COMMENT 'Author''s date of birth'
) COMMENT = 'Stores information about book authors';

-- Recreate Books table
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL COMMENT 'Book title',
    AuthorID INT NOT NULL COMMENT 'Foreign key referencing Authors table',
    PublicationYear INT NOT NULL COMMENT 'Year the book was published',
    Price DECIMAL(10, 2) NOT NULL COMMENT 'Book price',
    CONSTRAINT chk_publicationyear CHECK (PublicationYear <= 2024),
    CONSTRAINT chk_price CHECK (Price >= 1),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
) COMMENT = 'Stores information about books';

ALTER TABLE Books
ADD COLUMN StockQuantity INT NOT NULL DEFAULT 0 COMMENT 'Current stock quantity of the book';

-- Modify the Sales table to represent transactions
DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    SaleDate DATE NOT NULL COMMENT 'Date of the sale transaction',
    TotalAmount DECIMAL(10, 2) NOT NULL COMMENT 'Total amount of the sale',
    CONSTRAINT chk_total_amount CHECK (TotalAmount >= 0)
) COMMENT = 'Stores information about sale transactions';

-- Create a new SaleItems table to store individual items in each sale
DROP TABLE IF EXISTS SaleItems;
CREATE TABLE SaleItems (
    SaleItemID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT NOT NULL COMMENT 'Foreign key referencing Sales table',
    BookID INT NOT NULL COMMENT 'Foreign key referencing Books table',
    Quantity INT NOT NULL COMMENT 'Number of books sold',
    UnitPrice DECIMAL(10, 2) NOT NULL COMMENT 'Price of the book at the time of sale',
    CONSTRAINT chk_quantity CHECK (Quantity > 0),
    CONSTRAINT chk_unit_price CHECK (UnitPrice >= 0),
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
) COMMENT = 'Stores information about individual items in each sale';

DROP TABLE IF EXISTS Publishers;
CREATE TABLE Publishers (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    FoundedYear INT,
    Website VARCHAR(255),
    CONSTRAINT chk_foundedyear CHECK (FoundedYear <= 2024),
    CONSTRAINT uq_publisher_name UNIQUE (Name)
) COMMENT = 'Stores information about book publishers';

-- many:many relationships
DROP TABLE IF EXISTS BookPublishers;
CREATE TABLE BookPublishers (
    BookPublisherID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT NOT NULL,
    PublisherID INT NOT NULL,
    PublicationDate DATE NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID),
    CONSTRAINT chk_publicationdate CHECK (PublicationDate <= '2024-10-25')
) COMMENT = 'Represents the many-to-many relationship between Books and Publishers';

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    HireDate DATE NOT NULL,
    CONSTRAINT chk_hiredate CHECK (HireDate <= '2024-10-20'),
    CONSTRAINT uq_employee_email UNIQUE (Email)
) COMMENT = 'Stores information about bookstore employees';

DROP TABLE IF EXISTS EmployeeDetails;
CREATE TABLE EmployeeDetails (
    EmployeeID INT PRIMARY KEY,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(20),
    EmergencyContact VARCHAR(100),
    CONSTRAINT EmployeeDetails_ibfk_1 FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    ON DELETE CASCADE
) COMMENT = 'Stores additional details about employees (1:1 relationship with Employees)';

# SHOW FULL COLUMNS FROM Sales;

# SHOW TABLE STATUS WHERE Name = 'Sales';

