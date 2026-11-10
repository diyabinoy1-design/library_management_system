
# Library Management System

## 1. Project Overview

The Library Management System is a Database Management System (DBMS) project developed using MySQL.

The main objective of this project is to manage library records efficiently. It stores information about books, library members, and book borrowing and returning activities.

The system also helps identify popular books, track late returns, and calculate fines.

## 2. Technologies Used

- MySQL
- MySQL Workbench
- SQL

## 3. Database Information

**Database Name:** librarydb

The database consists of three main tables:

### 3.1 Members Table

Stores information about library members.

| Column Name | Description |
|---|---|
| member_id (PK) | Unique member ID |
| member_name | Name of the member |
| member_type | Student or Faculty |
| joined_date | Date of joining |

### 3.2 Books Table

Stores information about books available in the library.

| Column Name | Description |
|---|---|
| book_id (PK) | Unique book ID |
| title | Book title |
| author | Author name |
| category | Book category |
| price | Price of the book |
| copies_available | Available copies |

### 3.3 Issues Table

Stores information about books borrowed by members.

| Column Name | Description |
|---|---|
| issue_id (PK) | Unique issue ID |
| member_id (FK) | References Members table |
| book_id (FK) | References Books table |
| issue_date | Date of issue |
| due_date | Expected return date |
| return_date | Actual return date |

## 4. Entity Relationship Diagram (ER Diagram)

The database contains three entities:

- Members
- Books
- Issues

### Relationships

1. One member can have multiple issue records (1:N).
2. One book can appear in multiple issue records (1:N).
3. The Issues table connects Members and Books using foreign keys.

**ER Diagram:** Refer to the `ERD.png` file uploaded in this repository.

![Library Management System ER Diagram](ERD.png)

## 5. SQL Concepts Implemented

The project covers the following SQL concepts:

1. Database creation
2. Table creation
3. Primary keys and foreign keys
4. Inserting records
5. SELECT statements
6. Aggregate functions
7. GROUP BY and HAVING
8. JOIN operations
9. Subqueries
10. Date calculations using DATEDIFF()
11. Window functions using RANK()
12. Stored procedures
13. Triggers

## 6. Project Analysis

The project uses SQL queries to answer important library management questions, such as:

- Total number of members, books and issue records.
- Most frequently borrowed books.
- Members who have never borrowed books.
- Books currently issued and not returned.
- Books returned after their due dates.
- Total fine amount for each member.
- Comparison of Student and Faculty borrowing activity.
- Most popular book categories.

## 7. Fine Calculation

The library follows a fine rule of ₹2 for every day a book is returned late.

**Fine = Number of Late Days × ₹2**

## 8. How to Run the Project

1. Clone or download this GitHub repository.
2. Open MySQL Workbench.
3. Connect to MySQL Server.
4. Open the `library_management.sql` file.
5. Execute the SQL script.
6. Refresh the Schemas panel.
7. Explore the database tables and execute the queries.

## 9. Conclusion

The Library Management System demonstrates the practical application of database management concepts using MySQL. It provides an organised way to maintain library records, monitor book transactions and analyse borrowing activities.

This project helped in understanding SQL queries, database relationships, joins, subqueries, stored procedures and triggers.
