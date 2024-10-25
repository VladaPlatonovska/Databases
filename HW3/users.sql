-- full access
CREATE USER IF NOT EXISTS 'bookstore_admin'@'172.23.0.92' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'bookstore_admin'@'172.23.0.92';

-- read/write access to all tables
CREATE USER IF NOT EXISTS 'bookstore_manager'@'172.23.0.92' IDENTIFIED BY 'manager_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.* TO 'bookstore_manager'@'172.23.0.92';

-- read access to all tables, write access to Books and Sales
CREATE USER IF NOT EXISTS 'bookstore_clerk'@'172.23.0.92' IDENTIFIED BY 'clerk_password';
GRANT SELECT, INSERT ON BookstoreDB.Books TO 'bookstore_clerk'@'172.23.0.92';
GRANT SELECT, INSERT ON BookstoreDB.Sales TO 'bookstore_clerk'@'172.23.0.92';

FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;

SHOW GRANTS FOR 'bookstore_admin'@'172.23.0.92';
SHOW GRANTS FOR 'bookstore_manager'@'172.23.0.92';
SHOW GRANTS FOR 'bookstore_clerk'@'172.23.0.92';
