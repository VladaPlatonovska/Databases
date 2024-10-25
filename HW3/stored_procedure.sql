DELIMITER //

CREATE PROCEDURE GetBooksByAuthor(IN authorLastName VARCHAR(50))
BEGIN
    SELECT
        b.BookID,
        b.Title,
        b.PublicationYear,
        b.Price
    FROM
        Books b
        JOIN Authors a ON b.AuthorID = a.AuthorID
    WHERE
        a.LastName = authorLastName
    ORDER BY
        b.PublicationYear DESC;
END //

DELIMITER ;

set @authorLastName = 'Miranda';
call GetBooksByAuthor(@authorLastName);