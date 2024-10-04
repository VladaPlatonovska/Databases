import mysql.connector
from faker import Faker
from dotenv import load_dotenv
import random
from datetime import datetime, timedelta
import os

# Load environment variables
load_dotenv()

# Connection settings
HOST = os.getenv('host')
USER = os.getenv('user')
PASSWORD = os.getenv('password')
DATABASE = 'BookstoreDB'

# Connect to the MySQL database
connection = mysql.connector.connect(
    host=HOST,
    user="root",
    password="123456789",
    database=DATABASE
)

cursor = connection.cursor()

fake = Faker()

# Insert 100000 rows into Authors
print("Inserting into Authors...")
author_insert_query = """
INSERT INTO Authors (AuthorID, FirstName, LastName, BirthDate)
VALUES (%s, %s, %s, %s)
"""
authors_data = [
    (i, fake.first_name(), fake.last_name(), fake.date_of_birth(minimum_age=20, maximum_age=100))
    for i in range(1, 100001)
]
cursor.executemany(author_insert_query, authors_data)
connection.commit()
print("Inserted into Authors.")

# Insert 200000 rows into Books
print("Inserting into Books...")
book_insert_query = """
INSERT INTO Books (BookID, Title, AuthorID, PublicationYear, Price)
VALUES (%s, %s, %s, %s, %s)
"""
books_data = [
    (i, fake.catch_phrase(), random.randint(1, 100000), random.randint(1900, 2023), round(random.uniform(5.99, 29.99), 2))
    for i in range(1, 200001)
]
cursor.executemany(book_insert_query, books_data)
connection.commit()
print("Inserted into Books.")

# Insert 300000 rows into Sales
print("Inserting into Sales...")
sale_insert_query = """
INSERT INTO Sales (SaleID, BookID, SaleDate, Quantity)
VALUES (%s, %s, %s, %s)
"""
sale_date_start = datetime.now() - timedelta(days=365)
sales_data = [
    (i, random.randint(1, 200000), sale_date_start + timedelta(days=random.randint(0, 365)), random.randint(1, 5))
    for i in range(1, 300001)
]
cursor.executemany(sale_insert_query, sales_data)
connection.commit()
print("Inserted into Sales.")

# Close the cursor and connection
cursor.close()
connection.close()

print("Data insertion complete.")
