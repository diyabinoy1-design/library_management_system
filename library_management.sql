
-- ==========================================
-- COLLEGE LIBRARY MANAGEMENT PROJECT
-- DATABASE SETUP
-- ==========================================

CREATE DATABASE IF NOT EXISTS librarydb;

USE librarydb;

-- Remove old tables if this setup is being
-- executed again. This resets the sample data.

DROP TABLE IF EXISTS issues;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;

-- ==========================================
-- 1. MEMBERS TABLE
-- ==========================================

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    member_type ENUM('Student', 'Faculty') NOT NULL,
    joined_date DATE
);

-- ==========================================
-- 2. BOOKS TABLE
-- ==========================================

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    copies_available INT
);

-- ==========================================
-- 3. ISSUES TABLE
-- ==========================================

CREATE TABLE issues (
    issue_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE NULL,

    FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);

-- ==========================================
-- INSERT MEMBERS
-- ==========================================

INSERT INTO members VALUES
(1, 'Diya Binoy', 'Student', '2025-06-10'),
(2, 'Ananya Sharma', 'Student', '2025-06-12'),
(3, 'Rahul Kumar', 'Student', '2025-07-01'),
(4, 'Priya Nair', 'Student', '2025-07-05'),
(5, 'Arjun Rao', 'Student', '2025-08-10'),
(6, 'Dr. Meera', 'Faculty', '2024-06-01'),
(7, 'Prof. Joseph', 'Faculty', '2024-06-05'),
(8, 'Sneha Reddy', 'Student', '2025-09-01');

-- ==========================================
-- INSERT BOOKS
-- ==========================================

INSERT INTO books VALUES
(101, 'Database Management Systems', 'Raghu Ramakrishnan', 'Computer', 500, 3),
(102, 'SQL Basics', 'John Smith', 'Computer', 350, 0),
(103, 'Python Programming', 'Guido Rossum', 'Computer', 600, 2),
(104, 'Java Programming', 'Herbert Schildt', 'Computer', 550, 1),
(105, 'Data Structures', 'Seymour Lipschutz', 'Computer', 450, 4),
(106, 'English Literature', 'William Shakespeare', 'Literature', 300, 5),
(107, 'Indian History', 'Bipin Chandra', 'History', 400, 0),
(108, 'Mathematics', 'R.D. Sharma', 'Academic', 250, 2),
(109, 'Artificial Intelligence', 'Stuart Russell', 'Computer', 700, 0),
(110, 'Computer Networks', 'Andrew Tanenbaum', 'Computer', 500, 3);

-- ==========================================
-- INSERT ISSUE RECORDS
-- ==========================================

INSERT INTO issues VALUES
(1001, 1, 101, '2026-10-01', '2026-10-08', '2026-10-07'),
(1002, 1, 102, '2026-10-30', '2026-11-06', NULL),
(1003, 2, 103, '2026-10-01', '2026-10-10', '2026-10-13'),
(1004, 2, 101, '2026-10-05', '2026-10-15', '2026-10-17'),
(1005, 3, 104, '2026-11-03', '2026-11-15', NULL),
(1006, 3, 105, '2026-10-10', '2026-10-17', '2026-10-16'),
(1007, 4, 103, '2026-10-12', '2026-10-19', '2026-10-21'),
(1008, 4, 106, '2026-10-01', '2026-10-08', '2026-10-08'),
(1009, 5, 102, '2026-11-01', '2026-11-08', NULL),
(1010, 5, 107, '2026-11-02', '2026-11-09', NULL),
(1011, 6, 109, '2026-11-01', '2026-11-08', NULL),
(1012, 6, 101, '2026-10-15', '2026-10-22', '2026-10-20'),
(1013, 7, 105, '2026-10-20', '2026-10-27', '2026-10-26'),
(1014, 7, 110, '2026-10-01', '2026-10-08', '2026-10-11');

-- ==========================================
-- CHECK DATABASE
-- ==========================================

SHOW TABLES;

SELECT * FROM members;
SELECT * FROM books;
SELECT * FROM issues;
#C2
USE librarydb;

SELECT COUNT(*) AS Total_Members FROM members;

SELECT COUNT(*) AS Total_Books FROM books;

SELECT COUNT(*) AS Total_Issues FROM issues;

#C3
SELECT
    category,
    COUNT(*) AS Total_Titles,
    SUM(copies_available) AS Total_Copies
FROM books
GROUP BY category;

#C4
SELECT
    b.book_id,
    b.title,
    COUNT(i.issue_id) AS Times_Borrowed
FROM books b
JOIN issues i
    ON b.book_id = i.book_id
GROUP BY b.book_id, b.title
ORDER BY Times_Borrowed DESC
LIMIT 5;

#C5
SELECT
    m.member_id,
    m.member_name
FROM members m
LEFT JOIN issues i
    ON m.member_id = i.member_id
WHERE i.issue_id IS NULL;

#C6
SELECT
    m.member_name,
    b.title,
    i.due_date
FROM issues i
JOIN members m
    ON i.member_id = m.member_id
JOIN books b
    ON i.book_id = b.book_id
WHERE i.return_date IS NULL;

#C7
SELECT
    i.issue_id,
    m.member_name,
    b.title,
    i.due_date,
    i.return_date,
    DATEDIFF(i.return_date, i.due_date) AS Days_Late,
    DATEDIFF(i.return_date, i.due_date) * 2 AS Fine
FROM issues i
JOIN members m
    ON i.member_id = m.member_id
JOIN books b
    ON i.book_id = b.book_id
WHERE i.return_date > i.due_date;

#C8
SELECT
    m.member_id,
    m.member_name,
    SUM(DATEDIFF(i.return_date, i.due_date) * 2) AS Total_Fine
FROM members m
JOIN issues i
    ON m.member_id = i.member_id
WHERE i.return_date > i.due_date
GROUP BY m.member_id, m.member_name
HAVING Total_Fine > 0;

#C9
SELECT
    m.member_type,
    COUNT(i.issue_id) AS Total_Books_Borrowed
FROM members m
JOIN issues i
    ON m.member_id = i.member_id
GROUP BY m.member_type;

#C10
SELECT
    member_id,
    member_name,
    Total_Borrowed,
    RANK() OVER (
        ORDER BY Total_Borrowed DESC
    ) AS Member_Rank
FROM (
    SELECT
        m.member_id,
        m.member_name,
        COUNT(i.issue_id) AS Total_Borrowed
    FROM members m
    LEFT JOIN issues i
        ON m.member_id = i.member_id
    GROUP BY m.member_id, m.member_name
) AS Borrowing_Count;

#C11
SELECT
    b.category,
    COUNT(i.issue_id) AS Total_Issues
FROM books b
JOIN issues i
    ON b.book_id = i.book_id
GROUP BY b.category
ORDER BY Total_Issues DESC;

#C12
SELECT
    book_id,
    title,
    category,
    copies_available
FROM books
WHERE copies_available = 0
AND book_id IN (
    SELECT book_id
    FROM issues
    WHERE return_date IS NULL
);

#C13
DELIMITER //

CREATE PROCEDURE member_history(IN p_member_id INT)
BEGIN
    SELECT
        m.member_id,
        m.member_name,
        b.title,
        b.author,
        i.issue_date,
        i.due_date,
        i.return_date
    FROM members m
    JOIN issues i
        ON m.member_id = i.member_id
    JOIN books b
        ON i.book_id = b.book_id
    WHERE m.member_id = p_member_id;
END //

DELIMITER ;

CALL member_history(1);


