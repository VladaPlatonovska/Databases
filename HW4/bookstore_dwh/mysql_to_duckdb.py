import pandas as pd
from sqlalchemy import create_engine
import duckdb
from urllib.parse import quote_plus

# Create SQLAlchemy engine with mysql-connector-python
mysql_engine = create_engine(
    'mysql+mysqlconnector://root:%s@localhost/BookstoreDB' % quote_plus('123456789')
)

# Create DuckDB connection
duck_conn = duckdb.connect('bookstore.db')

# List of tables to transfer
tables = ['Authors', 'Books', 'Sales', 'SaleItems', 'Publishers',
          'BookPublishers', 'Employees', 'EmployeeDetails']

# Transfer each table
for table in tables:
    print(f"Transferring {table}...")
    # Read MySQL table into pandas DataFrame
    df = pd.read_sql_table(table, mysql_engine)

    # Create table in DuckDB and insert data
    duck_conn.execute(f"CREATE TABLE IF NOT EXISTS {table} AS SELECT * FROM df")

duck_conn.close()
print("Data transfer complete!")