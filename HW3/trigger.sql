-- Table to log book price changes
CREATE TABLE BookPriceHistory (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    OldPrice DECIMAL(10, 2),
    NewPrice DECIMAL(10, 2),
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ChangePercentage DECIMAL(10, 2),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

DELIMITER //

CREATE TRIGGER before_book_price_update
BEFORE UPDATE ON Books
FOR EACH ROW
BEGIN

    DECLARE price_change_pct DECIMAL(10, 2);

    IF NEW.Price != OLD.Price THEN
        SET price_change_pct = ((NEW.Price - OLD.Price) / OLD.Price) * 100;

        IF price_change_pct > 50 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price increase cannot exceed 50%';
        END IF;

        INSERT INTO BookPriceHistory (BookID, OldPrice, NewPrice, ChangePercentage)
        VALUES (OLD.BookID, OLD.Price, NEW.Price, price_change_pct);
    END IF;
END //

DELIMITER ;



UPDATE Books
SET Price = Price * 1.25
WHERE BookID = 1;

-- зафейлиться
UPDATE Books
SET Price = Price * 2
WHERE BookID = 1;

--  price change
SELECT
    b.Title,
    h.OldPrice,
    h.NewPrice,
    h.ChangePercentage,
    h.ChangeDate
FROM BookPriceHistory h
JOIN Books b ON h.BookID = b.BookID
ORDER BY h.ChangeDate DESC;