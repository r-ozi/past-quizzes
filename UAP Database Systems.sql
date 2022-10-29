USE [LugiOh]

--1.	Display CustomerName, CustomerGender, CustomerPhone, CustomerAddress, and CustomerDOB data on Customer table for every Customer whose name contains letter ‘l’.
SELECT
	CustomerName,
	CustomerGender,
	CustomerPhone,
	CustomerAddress,
	CustomerDOB
FROM
	Customer
WHERE
	CustomerName LIKE '%i%'

--2
SELECT
	CustomerName,
	CustomerGender,
	CustomerPhone,
	CustomerAddress,
	DATENAME(MONTH, TransactionDate)
FROM
	 HeaderTransaction ht
	 JOIN Customer c ON ht.CustomerID = c.CustomerID
WHERE
	c.CustomerID LIKE 'CU002'

--3
SELECT
	LOWER(CardName) AS [CardName],
	CardElement,
	CardLevel,
	CardAttack,
	CardDefense,
	CONCAT(CAST(COUNT(DISTINCT ht.TransactionID) AS VARCHAR), ' time(s)')
FROM
	HeaderTransaction ht
	JOIN DetailTransaction dt ON ht.TransactionID = dt.TransactionID
	JOIN Cards cr ON dt.CardsID = cr.CardsID
WHERE
	CardElement LIKE 'Dark'
GROUP BY
	CardName, CardElement,CardLevel, CardAttack, CardDefense

--4
SELECT
	CardName,
	CardElement,
	SUM(CardPrice) AS [Total Price],
	CONCAT(COUNT(DISTINCT ht.TransactionID), ' time(s)') AS [Total Transaction]
FROM
	HeaderTransaction ht
	JOIN DetailTransaction dt ON ht.TransactionID = dt.TransactionID
	JOIN Cards cr ON dt.CardsID = cr.CardsID
WHERE
	DATEDIFF(MONTH, 2017-12-31, TransactionDate) < -8
GROUP BY CardName, CardElement
UNION
SELECT
	CardName,
	CardElement,
	SUM(CardPrice) AS [Total Price],
	CONCAT(COUNT(DISTINCT ht.TransactionID), ' time(s)') AS [Total Transaction]
FROM
	HeaderTransaction ht
	JOIN DetailTransaction dt ON ht.TransactionID = dt.TransactionID
	JOIN Cards cr ON dt.CardsID = cr.CardsID
WHERE
	CardPrice > 500000
GROUP BY CardName, CardElement

--5
SELECT
	CustomerName,
	CustomerGender,
	CONVERT(VARCHAR, CustomerDOB, 107) AS CustomerDOB
FROM
	HeaderTransaction ht
	JOIN Customer c ON ht.CustomerID = c.CustomerID
WHERE
	DATEPART(WEEKDAY, TransactionDate) IN('5')

--6
SELECT
	CardName,
	UPPER(CardTypeName) AS [Type],
	CardElement,
	CONCAT(Quantity, ' Cards') AS [Total Card],
	(CardPrice * Quantity) AS [Total Price]
FROM
	Cards cr
	JOIN DetailTransaction dt ON cr.CardsID = dt.CardsID
	JOIN CardType ct ON cr.CardTypeID = ct.CardTypeID
WHERE
	CardPrice <=(
		SELECT AVG(CardPrice)
		FROM Cards)
	AND CardElement LIKE 'Dark'
GROUP BY
	CardName, CardElement, CardTypeName, CardPrice, Quantity
ORDER BY Quantity

--7
CREATE VIEW [DragonDeck] AS
SELECT
	SUBSTRING(CardName, 1, CHARINDEX(' ', CardName, 1)) AS [Monster Card],
	CardTypeName,
	CardElement,
	CardLevel,
	CardAttack,
	CardDefense
FROM
	Cards cr
	JOIN CardType ct ON cr.CardTypeID = ct.CardTypeID
WHERE
	CardTypeName LIKE 'Dragon'

SELECT * FROM DragonDeck



    
--8
CREATE VIEW [MayTransaction] AS
SELECT
	CustomerName,
	REPLACE(CustomerPhone, '8', 'x') AS [CustomerPhone],
	StaffName,
	StaffPhone,
	TransactionDate,
	SUM(DISTINCT Quantity) AS [Sold Card]
FROM
	HeaderTransaction ht
	JOIN DetailTransaction dt ON ht.TransactionID = dt.TransactionID
	JOIN Customer c ON ht.CustomerID = C.CustomerID
	JOIN Staff s ON ht.StaffID = s.StaffID
WHERE
	MONTH(TransactionDate) LIKE '5'
	AND CustomerGender LIKE 'Female'
GROUP BY StaffName, CustomerName, StaffPhone, CustomerPhone, TransactionDate

SELECT * FROM MayTransaction

--9
ALTER TABLE Staff
ADD StaffSalary INT
CHECK(StaffSalary > 100000

--10
UPDATE Cards
SET
	CardPrice = CardPrice + 200000
WHERE
	 CardTypeName=(
	 SELECT CardTypeName
	 FROM CardType
	 WHERE CardTypeName like 'Divine-Beast')
	 AND Quantity > 10
	

