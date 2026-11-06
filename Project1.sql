CREATE DATABASE Projects

USE Projects

CREATE TABLE customers
(
customer_id INT IDENTITY(1,1) PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
gender VARCHAR(10),
date_of_birth DATE,
email VARCHAR(100) UNIQUE,
phone VARCHAR(15),
city VARCHAR(50),
state VARCHAR(50)
)


CREATE TABLE branches
(
branch_id INT IDENTITY(1,1) PRIMARY KEY,
branch_name VARCHAR(100) NOT NULL,
branch_code VARCHAR(20) UNIQUE NOT NULL,
city VARCHAR(50),
state VARCHAR(50),
branch_manager VARCHAR(100),
branch_status VARCHAR(20)
)

CREATE TABLE accounts
(
account_id INT IDENTITY(1,1) PRIMARY KEY,
customer_id INT NOT NULL,
account_number VARCHAR(20) UNIQUE NOT NULL,
account_type VARCHAR(30) NOT NULL,
account_opening_date DATE NOT NULL,
account_status VARCHAR(20) NOT NULL,
currency VARCHAR(10) NOT NULL,

CONSTRAINT FK_accounts_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
)



CREATE TABLE transactions
(
transaction_id INT IDENTITY(1,1) PRIMARY KEY,
account_id INT NOT NULL,
customer_id INT NOT NULL,

transaction_date DATETIME NOT NULL,
transaction_type VARCHAR(50) NOT NULL,

amount DECIMAL(18,2) NOT NULL,
balance_after_transaction DECIMAL(18,2) NOT NULL,

payment_channel VARCHAR(50) NOT NULL,

branch_id INT NOT NULL,

reference_number INT NOT NULL,

transaction_status VARCHAR(50) NOT NULL,

currency VARCHAR(50),
descriptions VARCHAR(200),
merchant_name VARCHAR(50),
is_international BIT,

CONSTRAINT FK_transactions_accounts
    FOREIGN KEY (account_id)
    REFERENCES accounts(account_id),

CONSTRAINT FK_transactions_customers
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),

CONSTRAINT FK_transactions_branches
    FOREIGN KEY (branch_id)
    REFERENCES branches(branch_id)
);



;WITH CustomerData AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM CustomerData
    WHERE n < 100
)
INSERT INTO customers
(
    first_name, last_name, gender, date_of_birth,
    email, phone, city, state
)
SELECT
    CASE n % 20
        WHEN 0 THEN 'Aarav'
        WHEN 1 THEN 'Priya'
        WHEN 2 THEN 'Rahul'
        WHEN 3 THEN 'Sneha'
        WHEN 4 THEN 'Arjun'
        WHEN 5 THEN 'Neha'
        WHEN 6 THEN 'Rohan'
        WHEN 7 THEN 'Ananya'
        WHEN 8 THEN 'Vikram'
        WHEN 9 THEN 'Pooja'
        WHEN 10 THEN 'Karan'
        WHEN 11 THEN 'Meera'
        WHEN 12 THEN 'Aditya'
        WHEN 13 THEN 'Kavita'
        WHEN 14 THEN 'Ishaan'
        WHEN 15 THEN 'Riya'
        WHEN 16 THEN 'Sanjay'
        WHEN 17 THEN 'Divya'
        WHEN 18 THEN 'Amit'
        ELSE 'Nisha'
    END,

    CASE (n * 7) % 20
        WHEN 0 THEN 'Sharma'
        WHEN 1 THEN 'Patel'
        WHEN 2 THEN 'Verma'
        WHEN 3 THEN 'Mehta'
        WHEN 4 THEN 'Gupta'
        WHEN 5 THEN 'Shah'
        WHEN 6 THEN 'Joshi'
        WHEN 7 THEN 'Desai'
        WHEN 8 THEN 'Reddy'
        WHEN 9 THEN 'Nair'
        WHEN 10 THEN 'Iyer'
        WHEN 11 THEN 'Singh'
        WHEN 12 THEN 'Kumar'
        WHEN 13 THEN 'Malhotra'
        WHEN 14 THEN 'Kapoor'
        WHEN 15 THEN 'Rao'
        WHEN 16 THEN 'Mishra'
        WHEN 17 THEN 'Chauhan'
        WHEN 18 THEN 'Pandey'
        ELSE 'Saxena'
    END,

    CASE WHEN n % 2 = 0 THEN 'Male' ELSE 'Female' END,

    DATEADD(DAY, -(7000 + (n * 137) % 12000),
        CAST('2025-01-01' AS DATE)),

    CONCAT('customer', n, '@example.com'),

    CONCAT('9', RIGHT(CONCAT('000000000', 100000000 + n * 137), 9)),

    CASE n % 10
        WHEN 0 THEN 'Ahmedabad'
        WHEN 1 THEN 'Mumbai'
        WHEN 2 THEN 'Delhi'
        WHEN 3 THEN 'Pune'
        WHEN 4 THEN 'Bangalore'
        WHEN 5 THEN 'Hyderabad'
        WHEN 6 THEN 'Jaipur'
        WHEN 7 THEN 'Surat'
        WHEN 8 THEN 'Chennai'
        ELSE 'Kolkata'
    END,

    CASE n % 10
        WHEN 0 THEN 'Gujarat'
        WHEN 1 THEN 'Maharashtra'
        WHEN 2 THEN 'Delhi'
        WHEN 3 THEN 'Maharashtra'
        WHEN 4 THEN 'Karnataka'
        WHEN 5 THEN 'Telangana'
        WHEN 6 THEN 'Rajasthan'
        WHEN 7 THEN 'Gujarat'
        WHEN 8 THEN 'Tamil Nadu'
        ELSE 'West Bengal'
    END

FROM CustomerData
OPTION (MAXRECURSION 100);
GO


-- =============================================
-- 2. ACCOUNTS TABLE - 200 RECORDS
-- =============================================

;WITH AccountData AS
(
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM AccountData
    WHERE n < 200
)
INSERT INTO accounts
(
    customer_id,
    account_number,
    account_type,
    account_opening_date,
    account_status,
    currency
)
SELECT
    ((n - 1) % 100) + 1,

    CONCAT('BANK2024', RIGHT(CONCAT('000000', n), 6)),

    CASE n % 4
        WHEN 0 THEN 'Savings'
        WHEN 1 THEN 'Current'
        WHEN 2 THEN 'Salary'
        ELSE 'Fixed Deposit'
    END,

    DATEADD(DAY, (n * 17) % 1800,
        CAST('2020-01-01' AS DATE)),

    CASE
        WHEN n % 20 = 0 THEN 'Inactive'
        WHEN n % 25 = 0 THEN 'Frozen'
        ELSE 'Active'
    END,

    'INR'

FROM AccountData
OPTION (MAXRECURSION 200);
GO


-- =============================================
-- 3. BRANCHES TABLE - 20 RECORDS
-- =============================================

INSERT INTO branches
(
    branch_name,
    branch_code,
    city,
    state,
    branch_manager,
    branch_status
)
VALUES
('National Bank Ahmedabad Main', 'BR0001', 'Ahmedabad', 'Gujarat', 'Rajesh Sharma', 'Active'),
('National Bank Mumbai Central', 'BR0002', 'Mumbai', 'Maharashtra', 'Amit Patel', 'Active'),
('National Bank Delhi Main', 'BR0003', 'Delhi', 'Delhi', 'Neha Mehta', 'Active'),
('National Bank Pune Branch', 'BR0004', 'Pune', 'Maharashtra', 'Priya Shah', 'Active'),
('National Bank Bangalore Main', 'BR0005', 'Bangalore', 'Karnataka', 'Vikram Singh', 'Active'),
('National Bank Hyderabad Branch', 'BR0006', 'Hyderabad', 'Telangana', 'Anjali Verma', 'Active'),
('National Bank Jaipur Branch', 'BR0007', 'Jaipur', 'Rajasthan', 'Rahul Gupta', 'Active'),
('National Bank Surat Main', 'BR0008', 'Surat', 'Gujarat', 'Sneha Joshi', 'Active'),
('National Bank Chennai Central', 'BR0009', 'Chennai', 'Tamil Nadu', 'Karan Desai', 'Active'),
('National Bank Kolkata Main', 'BR0010', 'Kolkata', 'West Bengal', 'Pooja Rao', 'Active'),
('National Bank Vadodara Branch', 'BR0011', 'Vadodara', 'Gujarat', 'Manish Shah', 'Active'),
('National Bank Nashik Branch', 'BR0012', 'Nashik', 'Maharashtra', 'Ritu Mehta', 'Active'),
('National Bank Indore Branch', 'BR0013', 'Indore', 'Madhya Pradesh', 'Suresh Patel', 'Active'),
('National Bank Lucknow Branch', 'BR0014', 'Lucknow', 'Uttar Pradesh', 'Kavita Singh', 'Active'),
('National Bank Bhopal Branch', 'BR0015', 'Bhopal', 'Madhya Pradesh', 'Deepak Verma', 'Active'),
('National Bank Kochi Branch', 'BR0016', 'Kochi', 'Kerala', 'Meera Nair', 'Active'),
('National Bank Chandigarh Branch', 'BR0017', 'Chandigarh', 'Chandigarh', 'Rohan Kapoor', 'Active'),
('National Bank Nagpur Branch', 'BR0018', 'Nagpur', 'Maharashtra', 'Divya Joshi', 'Active'),
('National Bank Rajkot Branch', 'BR0019', 'Rajkot', 'Gujarat', 'Aakash Desai', 'Active'),
('National Bank Coimbatore Branch', 'BR0020', 'Coimbatore', 'Tamil Nadu', 'Nisha Iyer', 'Active');



;WITH TransactionData AS
(
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM TransactionData
    WHERE n < 5000
)
INSERT INTO transactions
(
    account_id,
    customer_id,
    transaction_date,
    transaction_type,
    amount,
    balance_after_transaction,
    payment_channel,
    branch_id,
    reference_number,
    transaction_status,
    currency,
    descriptions,
    merchant_name,
    is_international
)
SELECT
    ((n - 1) % 200) + 1,

    (((n - 1) % 200) % 100) + 1,

    DATEADD(
        SECOND,
        (n * 137) % 86400,
        DATEADD(
            DAY,
            (n * 7) % 730,
            CAST('2024-01-01' AS DATETIME)
        )
    ),

    CASE n % 8
        WHEN 0 THEN 'Deposit'
        WHEN 1 THEN 'Withdrawal'
        WHEN 2 THEN 'Transfer'
        WHEN 3 THEN 'Payment'
        WHEN 4 THEN 'Refund'
        WHEN 5 THEN 'ATM Withdrawal'
        WHEN 6 THEN 'Bill Payment'
        ELSE 'Online Purchase'
    END,

    CAST(
        100 + (n * 137) % 49900
        + (n * 37) % 100 / 100.0
        AS DECIMAL(18,2)
    ),

    CAST(
        5000 + (n * 347) % 95000
        + (n * 19) % 100 / 100.0
        AS DECIMAL(18,2)
    ),

    CASE n % 7
        WHEN 0 THEN 'UPI'
        WHEN 1 THEN 'NEFT'
        WHEN 2 THEN 'IMPS'
        WHEN 3 THEN 'Debit Card'
        WHEN 4 THEN 'Credit Card'
        WHEN 5 THEN 'Net Banking'
        ELSE 'ATM'
    END,

    ((n - 1) % 20) + 1,

    900000000 + n,

    CASE
        WHEN n % 20 = 0 THEN 'Pending'
        WHEN n % 23 = 0 THEN 'Failed'
        WHEN n % 17 = 0 THEN 'Reversed'
        ELSE 'Completed'
    END,

    CASE n % 20
        WHEN 0 THEN 'USD'
        WHEN 1 THEN 'EUR'
        WHEN 2 THEN 'GBP'
        ELSE 'INR'
    END,

    CASE n % 12
        WHEN 0 THEN 'Monthly salary credited'
        WHEN 1 THEN 'Online shopping transaction'
        WHEN 2 THEN 'Electricity bill payment'
        WHEN 3 THEN 'Money transferred to beneficiary'
        WHEN 4 THEN 'Cash withdrawal from ATM'
        WHEN 5 THEN 'Restaurant payment'
        WHEN 6 THEN 'Refund processed'
        WHEN 7 THEN 'Mobile recharge'
        WHEN 8 THEN 'Grocery shopping payment'
        WHEN 9 THEN 'Insurance premium payment'
        WHEN 10 THEN 'Education fee payment'
        ELSE 'Bank account deposit'
    END,

    CASE n % 12
        WHEN 0 THEN 'Amazon'
        WHEN 1 THEN 'Flipkart'
        WHEN 2 THEN 'Reliance Retail'
        WHEN 3 THEN 'Walmart'
        WHEN 4 THEN 'Uber'
        WHEN 5 THEN 'Swiggy'
        WHEN 6 THEN 'Zomato'
        WHEN 7 THEN 'BigBasket'
        WHEN 8 THEN 'Paytm'
        WHEN 9 THEN 'Netflix'
        WHEN 10 THEN 'Google Services'
        ELSE 'Local Merchant'
    END,

    CASE
        WHEN n % 15 = 0 THEN 1
        ELSE 0
    END

FROM TransactionData
OPTION (MAXRECURSION 5000);


SELECT * FROM transactions
SELECT * FROM customers
SELECT * FROM accounts
SELECT * FROM branches
-----------------------------------------------------------------------------------------------------------------------------------------------


SELECT * FROM transactions

SELECT * FROM transactions WHERE amount > 20000

SELECT * FROM transactions ORDER BY transaction_date

SELECT transaction_type,SUM(amount) AS Total_amount FROM transactions GROUP BY transaction_type

SELECT branch_id,SUM(amount) AS Total_Amount FROM transactions GROUP BY branch_id

SELECT TOP 10 * FROM transactions ORDER BY amount DESC

SELECT t.transaction_id,a.account_number,c.first_name,c.last_name,t.amount,t.merchant_name,t.transaction_status
FROM transactions t
JOIN customers c
ON t.customer_id = c.customer_id
JOIN accounts a
ON t.account_id = a.account_id


SELECT t.customer_id,c.first_name,c.last_name,c.email FROM (
SELECT customer_id,COUNT(*) Total_Transections FROM transactions GROUP BY customer_id) t
JOIN customers c
ON t.customer_id = c.customer_id
WHERE Total_Transections > 10


SELECT Month(transaction_date)AS Month,SUM(amount) AS Total_Amounth,
    SUM(CASE WHEN transaction_type IN ('Withdrawal','ATM Withdrawal') THEN amount ELSE 0 END) AS Total_Withdrawal,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN Amount ELSE 0 END) AS Total_Deposite
FROM Transactions
GROUP BY MONTH(transaction_date)
ORDER BY Month
