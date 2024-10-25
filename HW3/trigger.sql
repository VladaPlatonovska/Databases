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

-- Trigger to log price changes and validate them
DELIMITER //

CREATE TRIGGER before_book_price_update
BEFORE UPDATE ON Books
FOR EACH ROW
BEGIN
    -- Calculate price change percentage
    DECLARE price_change_pct DECIMAL(10, 2);

    IF NEW.Price != OLD.Price THEN
        -- Calculate percentage change
        SET price_change_pct = ((NEW.Price - OLD.Price) / OLD.Price) * 100;

        -- If price increase is more than 50%, prevent the update
        IF price_change_pct > 50 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Price increase cannot exceed 50%';
        END IF;

        -- Log the price change
        INSERT INTO BookPriceHistory (BookID, OldPrice, NewPrice, ChangePercentage)
        VALUES (OLD.BookID, OLD.Price, NEW.Price, price_change_pct);
    END IF;
END //

DELIMITER ;


-- Valid price update (less than 50% increase)
UPDATE Books
SET Price = Price * 1.25
WHERE BookID = 1;

-- This will fail (more than 50% increase)
UPDATE Books
SET Price = Price * 2
WHERE BookID = 1;

-- View price change history
SELECT
    b.Title,
    h.OldPrice,
    h.NewPrice,
    h.ChangePercentage,
    h.ChangeDate
FROM BookPriceHistory h
JOIN Books b ON h.BookID = b.BookID
ORDER BY h.ChangeDate DESC;