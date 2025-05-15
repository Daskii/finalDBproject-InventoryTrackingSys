# Inventory Tracking System

## Description

This project provides a relational database schema for a comprehensive Inventory Tracking System. It is designed to manage various aspects of inventory, including suppliers, products, categories, warehouses, stock levels, customer orders, and purchase orders. The system allows for tracking stock movements, managing product information, and handling sales and procurement processes.

## Setup and Usage

To use this database schema, you will need a MySQL server instance.

1.  **Save the SQL Schema**: The `inventory_tracking.sql` file contains all the `CREATE TABLE` statements required to set up the database structure. Download this file.
2.  **Import the SQL File**: You can import the `inventory_tracking.sql` file into your MySQL database using a MySQL client or tool such as MySQL Workbench, phpMyAdmin, or the command-line interface.

    Using the MySQL command-line client:
    ```bash
    mysql -u YOUR_USERNAME -p YOUR_DATABASE_NAME < /path/to/inventory_tracking.sql
    ```
    Replace `YOUR_USERNAME` with your MySQL username, `YOUR_DATABASE_NAME` with the name of the database you want to create or use, and `/path/to/inventory_tracking.sql` with the actual path to the downloaded SQL file.

3.  **Verify Setup**: After importing, you can connect to your database and verify that all tables have been created successfully by listing the tables or querying their structure.

## Entity Relationship Diagram (ERD)

An Entity Relationship Diagram (ERD) visually represents the database schema, including tables, columns, and relationships.

The ERD for this Inventory Tracking System can be found below:

![Inventory Tracking System ERD](https://private-us-east-1.manuscdn.com/sessionFile/JhtbiBW4Ouqqryo4tNDHmJ/sandbox/sUPv6Pf322V56o37IhuZd7-images_1747335923658_na1fn_L2hvbWUvdWJ1bnR1L2ludmVudG9yeV9lcmRfZnVsbC0x.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvSmh0YmlCVzRPdXFxcnlvNHROREhtSi9zYW5kYm94L3NVUHY2UGYzMjJWNTZvMzdJaHVaZDctaW1hZ2VzXzE3NDczMzU5MjM2NThfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwybHVkbVZ1ZEc5eWVWOWxjbVJmWm5Wc2JDMHgucG5nIiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNzY3MjI1NjAwfX19XX0_&Key-Pair-Id=K2HSFNDJXOU9YS&Signature=WpZyXuYVF1hS9gIlkJmAinuVmq5couFvYq4~lhRb2xPwl3l42~8KnQ926TMAnQOuxJvQT5CwYpw-R4tnya1XgXh4PXAH5zesV3VT4~Rv89yow1zFSkC-aglkNs0gqaarSKewpS~NZNDefOgWEsJ4cmTE63bOtL1nCknnUq8MFZMaF3fZ0zZ6~TVslwCot9ID1x~i-rOk6mwrPk76uPgWuEc~o1auyuL-f7FkKa6C2c5NmZXTvK~Yov7vYhskqDFdxFggBU4GxsHHsmLw8lRRAPRwoJ0OjcOVRed3CtBjjIm2Vyhe~hvxVu86ncYPdDmUlUuuNMIBPUs6tcblTbkPtw__)



