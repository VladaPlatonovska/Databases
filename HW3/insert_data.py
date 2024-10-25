import mysql.connector
from faker import Faker
from dotenv import load_dotenv
import random
from datetime import date
import os

# Load environment variables
load_dotenv()

# Connection settings
HOST = os.getenv('host')
USER = os.getenv('user')
PASSWORD = os.getenv('password')
DATABASE = os.getenv('DATABASE')

# Connect to the MySQL database
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="123456789",
    database="BookstoreDB"
)

cursor = connection.cursor()

fake = Faker()

# Insert 500,000 rows into Authors
print("Inserting into Authors...")
author_insert_query = """
INSERT INTO Authors (FirstName, LastName, BirthDate)
VALUES (%s, %s, %s)
"""
authors_data = [
    (fake.first_name(), fake.last_name(), fake.date_of_birth(minimum_age=20, maximum_age=100))
    for _ in range(500000)
]
cursor.executemany(author_insert_query, authors_data)
connection.commit()
print("Inserted into Authors.")

# Insert 500,000 rows into Books
print("Inserting into Books...")
book_insert_query = """
INSERT INTO Books (Title, AuthorID, PublicationYear, Price, StockQuantity)
VALUES (%s, %s, %s, %s, %s)
"""
books_data = [
    (fake.catch_phrase(), random.randint(1, 500000), random.randint(1900, 2024),
     round(random.uniform(5.99, 99.99), 2), random.randint(0, 1000))
    for _ in range(500000)
]
cursor.executemany(book_insert_query, books_data)
connection.commit()
# print("Inserted into Books.")

# Insert 10000 rows into Publishers
print("Inserting into Publishers...")
publisher_insert_query = """
INSERT INTO Publishers (Name, FoundedYear, Website)
VALUES (%s, %s, %s)
"""

# Create a set to keep track of used names
used_names = set()


def generate_unique_publisher_name(fake):
    while True:
        name = fake.company()
        if name not in used_names:
            used_names.add(name)
            return name


publishers_data = [
    (generate_unique_publisher_name(fake), random.randint(1800, 2024), fake.url())
    for _ in range(10000)
]
cursor.executemany(publisher_insert_query, publishers_data)
connection.commit()
print("Inserted into Publishers.")

# Insert 500,000 rows into BookPublishers
print("Inserting into BookPublishers...")
book_publisher_insert_query = """
INSERT INTO BookPublishers (BookID, PublisherID, PublicationDate)
VALUES (%s, %s, %s)
"""
book_publishers_data = [
    (random.randint(1, len(used_names)), random.randint(1, len(used_names)),
     fake.date_between(start_date='-50y', end_date='today'))
    for _ in range(len(used_names))
]
cursor.executemany(book_publisher_insert_query, book_publishers_data)
connection.commit()
print("Inserted into BookPublishers.")

# Insert 500,000 rows into Sales
print("Inserting into Sales...")
sale_insert_query = """
INSERT INTO Sales (SaleDate, TotalAmount)
VALUES (%s, %s)
"""
sales_data = [
    (fake.date_between(start_date='-2y', end_date='today'),
     round(random.uniform(10, 500), 2))
    for _ in range(500000)
]
cursor.executemany(sale_insert_query, sales_data)
connection.commit()
print("Inserted into Sales.")

# Insert 500,000 rows into SaleItems
print("Inserting into SaleItems...")
sale_item_insert_query = """
INSERT INTO SaleItems (SaleID, BookID, Quantity, UnitPrice)
VALUES (%s, %s, %s, %s)
"""
sale_items_data = [
    (random.randint(1, 500000), random.randint(1, 500000),
     random.randint(1, 10), round(random.uniform(5.99, 99.99), 2))
    for _ in range(500000)
]
cursor.executemany(sale_item_insert_query, sale_items_data)
connection.commit()
print("Inserted into SaleItems.")

# Set the end date for hire dates
end_date = date(2024, 10, 20)

# Insert 500,000 rows into Employees
print("Inserting into Employees...")
employee_insert_query = """
INSERT INTO Employees (FirstName, LastName, Email, HireDate)
VALUES (%s, %s, %s, %s)
"""
employees_data = [
    (fake.first_name(), fake.last_name(), f"emp_{i}_{fake.email()}",
     fake.date_between(start_date='-20y', end_date=end_date))
    for i in range(1, 500001)
]
cursor.executemany(employee_insert_query, employees_data)
connection.commit()
print("Inserted into Employees.")


def generate_valid_phone():
    """Generate a phone number that fits within VARCHAR(20)"""
    return f"{random.randint(100, 999)}-{random.randint(100, 999)}-{random.randint(1000, 9999)}"


# Insert 500,000 rows into EmployeeDetails
print("Inserting into EmployeeDetails...")
employee_details_insert_query = """
INSERT INTO EmployeeDetails (EmployeeID, Address, PhoneNumber, EmergencyContact)
VALUES (%s, %s, %s, %s)
"""
employee_details_data = [
    (i,
     fake.street_address()[:255],  # Limit address length to VARCHAR(255)
     generate_valid_phone(),
     fake.name()[:100])  # Limit emergency contact name to VARCHAR(100)
    for i in range(1, 500001)
]
cursor.executemany(employee_details_insert_query, employee_details_data)
connection.commit()
print("Inserted into EmployeeDetails.")

# Close the cursor and connection
cursor.close()
connection.close()

print("Data insertion complete.")
