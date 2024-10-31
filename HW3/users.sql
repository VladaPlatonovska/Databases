-- full access
CREATE USER IF NOT EXISTS 'bookstore_admin'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'bookstore_admin'@'localhost';

-- read/write access to all tables
CREATE USER IF NOT EXISTS 'bookstore_manager'@'localhost' IDENTIFIED BY 'manager_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.* TO 'bookstore_manager'@'localhost';

-- read access to all tables, write access to Books and Sales
CREATE USER IF NOT EXISTS 'bookstore_clerk'@'localhost' IDENTIFIED BY 'clerk_password';
GRANT SELECT, INSERT ON BookstoreDB.Books TO 'bookstore_clerk'@'localhost';
GRANT SELECT, INSERT ON BookstoreDB.Sales TO 'bookstore_clerk'@'localhost';

FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;

SHOW GRANTS FOR 'bookstore_admin'@'localhost';
SHOW GRANTS FOR 'bookstore_manager'@'localhost';
SHOW GRANTS FOR 'bookstore_clerk'@'localhost';
