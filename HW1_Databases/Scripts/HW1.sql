CREATE DATABASE HomeWork_1;
USE HomeWork_1;

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Shops (
    ShopID INT PRIMARY KEY,
    ShopName VARCHAR(100) NOT NULL,
    Description TEXT
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ShopID INT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    FOREIGN KEY (ShopID) REFERENCES Shops(ShopID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert data
INSERT INTO Users (UserID, Username, Email, RegistrationDate) VALUES
(1, 'john_doe', 'john@example.com', '2023-01-15'),
(2, 'jane_smith', 'jane@example.com', '2023-02-20'),
(3, 'bob_johnson', 'bob@example.com', '2023-03-10'),
(4, 'alice_brown', 'alice@example.com', '2023-04-05'),
(5, 'charlie_davis', 'charlie@example.com', '2023-05-01');

INSERT INTO Shops (ShopID, ShopName, Description) VALUES
(1, 'Electronics Emporium', 'Your one-stop shop for all things electronic'),
(2, 'Fashion Forward', 'Trendy clothes and accessories'),
(3, 'Home Essentials', 'Everything you need for your home'),
(4, 'Sports World', 'Gear up for your favorite sports'),
(5, 'Book Nook', 'A paradise for book lovers');

INSERT INTO Products (ProductID, ShopID, ProductName, Price, Stock) VALUES
(1, 1, 'Smartphone', 599.99, 50),
(2, 1, 'Laptop', 999.99, 30),
(3, 2, 'T-Shirt', 19.99, 100),
(4, 2, 'Jeans', 49.99, 75),
(5, 3, 'Coffee Maker', 79.99, 40),
(6, 3, 'Toaster', 29.99, 60),
(7, 4, 'Tennis Racket', 89.99, 25),
(8, 4, 'Basketball', 24.99, 50),
(9, 5, 'Mystery Novel', 14.99, 80),
(10, 5, 'Cookbook', 29.99, 35);

INSERT INTO Orders (OrderID, UserID, OrderDate, TotalAmount) VALUES
(1, 1, '2023-06-01', 649.98),
(2, 2, '2023-06-15', 69.98),
(3, 3, '2023-07-01', 114.98),
(4, 4, '2023-07-15', 1029.98),
(5, 5, '2023-08-01', 44.98);

INSERT INTO Orders (OrderID, UserID, OrderDate, TotalAmount) VALUES
(6, 1, '2023-09-01', 79.99),  
(7, 1, '2023-09-20', 24.99),
(8, 1, '2023-10-01', 49.99), 
(9, 2, '2023-09-05', 124.96),
(10, 2, '2023-10-01', 89.99),
(11, 3, '2023-09-10', 144.97), 
(12, 4, '2023-09-15', 154.96),
(13, 5, '2023-09-20', 919.98);


INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 1, 1, 1),
(2, 1, 3, 1),
(3, 2, 4, 1),
(4, 2, 9, 1),
(5, 3, 7, 1),
(6, 3, 10, 1),
(7, 4, 2, 1),
(8, 4, 5, 1),
(9, 5, 8, 1),
(10, 5, 9, 2);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(11, 6, 5, 1),
(12, 7, 8, 1),
(13, 8, 4, 1),
(14, 9, 4, 1),
(15, 9, 7, 1), 
(16, 10, 7, 1),
(17, 11, 8, 1),
(18, 11, 9, 1), 
(19, 12, 3, 1), 
(20, 12, 10, 1),
(21, 13, 2, 1); 


WITH OrderSummary AS (
    SELECT 
        o.OrderID,
        u.Username,
        SUM(p.Price * od.Quantity) AS OrderTotal
    FROM 
        Orders o
    JOIN Users u ON o.UserID = u.UserID
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY 
        o.OrderID, u.Username
)
SELECT 
    os.Username,
    COUNT(os.OrderID) AS OrderCount,
    SUM(os.OrderTotal) AS TotalSpent
FROM 
    OrderSummary os
WHERE 
    os.OrderTotal > 10
and os.Username
GROUP BY
    os.Username
ORDER BY 
    TotalSpent DESC;


SELECT 'High Stock' AS StockStatus, ProductName, Stock
FROM Products
WHERE Stock > 50
UNION
SELECT 'Low Stock' AS StockStatus, ProductName, Stock
FROM Products
WHERE Stock <= 50
ORDER BY Stock DESC;