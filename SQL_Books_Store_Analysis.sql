-- BOOKS STORE DATA

-- USING MyProjectDB DATABASE
USE MyProjectDB;
-- SEE ALL BOOKS DETAILS
SELECT * FROM Books;
-- SEE ALL CUSTOMERS DETAILS
SELECT * FROM Customers;
-- SEE ALL ORDERS DETAILS
SELECT * FROM Orders;

-- BASIC QUERY FOR SELECT,GROUP BY,ORDER BY,SUBQUERY
-- Q 1 FIND BOOKS PUBLISHED AFTER 1990
SELECT * FROM Books 
WHERE Published_Year > 1990;

-- Q 2 FIND BOOKS WHERE PRICE > 30 AND STOCK < 40
SELECT Title,Price,Stock FROM Books 
WHERE Price > 30 AND Stock < 40;

-- Q 3 LIST ALL THE CUSTOMERS FROM INDIA
SELECT * FROM Customers
WHERE Country LIKE 'India';

-- Q 4 FIND THE BOOKS WHERE AVERAGE PRICE IS GRAHER THAN NORMAL PRICE
SELECT * FROM Books 
WHERE Price > (SELECT AVG(Price) AS AVG_PRICE FROM Books);

-- Q 5 SHOW ORDER PLACED IN NOV 2023
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-31';

-- Q 6 FIND THE DEATILS OF MOST EXPENSIVE BOOK AVAILABLE 
SELECT * FROM Books 
ORDER BY Price DESC LIMIT 1;

-- Q 7 FIND THE TOTAL STOCK AVAILABLE IN Fantasy GENRE BOOK
SELECT SUM(Stock) AS Total_Stock FROM Books 
WHERE Genre LIKE 'Fantasy';

-- Q 8 SHOW CUSTOMERS WHO ORDERED MORE THAN 2 QUANTITY OF A BOOK
SELECT * FROM Orders
WHERE Quantity > 2
ORDER BY Quantity DESC;

-- Q 9 RETRIVE ALL ORDERS WHERE TOTAL AMOUNT EXCEEDS 400
SELECT * FROM Orders 
WHERE Total_Amount > 400;

-- Q 10 FIND THE AVG GENRE PRICE 
SELECT Genre,AVG(Price) AS AVG_PRICE FROM Books 
GROUP BY Genre;

-- Q 11 FIND THE DEATILS OF THE BOOKS AVAILABLE BOOKS
SELECT DISTINCT Genre FROM Books;




-- SQL QUERY RELETED TO JOIN  
-- Q 1 Retrieve the total number of books sold for each genre.
SELECT B.Genre,SUM(O.Quantity) AS Total_Books_Sold
FROM Orders O 
JOIN Books B
ON O.Book_ID = B.Book_ID
GROUP BY B.Genre
ORDER BY Total_Books_Sold DESC;

-- Q 2 Find the average price of books in the "Fantasy" genre.
SELECT AVG(Price) AS Avg_Price FROM Books
WHERE Genre = 'Fantasy';

-- Q 3 List customers who have placed at least 2 orders.
SELECT C.Name,COUNT(O.Quantity) AS Total_Orders FROM Customers C 
JOIN Orders O 
ON C.Customer_ID = O.Customer_ID
GROUP BY C.Name 
HAVING COUNT(O.Quantity) >= 2;

-- Q 4 Find the most frequently ordered book.
SELECT O.Book_ID,B.Title,COUNT(O.Order_ID) AS Order_Count FROM Orders O
JOIN Books B 
ON O.Book_ID = B.Book_ID
GROUP BY O.Book_ID,B.Title
ORDER BY Order_Count DESC LIMIT 1;

-- Q 5 Show the top 3 most expensive books of 'Fantasy' genre.
SELECT * FROM Books 
WHERE Genre LIKE 'Fantasy'
ORDER BY Price DESC LIMIT 3;

-- Q 6 Retrieve the total quantity of books sold by each author.
SELECT B.Author,SUM(O.Quantity) AS Total_Books_Sold FROM Books B 
JOIN Orders O 
ON B.Book_ID = O.Book_ID 
GROUP BY B.Author
ORDER BY Total_Books_Sold DESC;

-- Q 7  List the cities where customers who spent over $30 are located.
SELECT  DISTINCT C.City,O.Total_Amount FROM Customers C 
JOIN Orders O 
ON C.Customer_ID = O.Customer_ID
WHERE O.Total_Amount > 30;

-- Q 8  Find the customer who spent the most on orders.
SELECT C.Name,SUM(O.Total_Amount) AS Total_Spent FROM Customers C 
JOIN Orders O 
ON C.Customer_ID = O.Customer_ID 
GROUP BY C.Name
ORDER BY Total_Spent DESC LIMIT 1;

-- Q 9 Calculate the stock remaining after fulfilling all orders.
SELECT B.Book_ID,B.Title,B.Stock,COALESCE(SUM(O.Quantity),0) AS Order_Quantity,B.Stock - COALESCE(SUM(O.Quantity),0) AS Remaining_Quantity
FROM Books B
LEFT JOIN Orders O 
ON B.Book_ID = O.Book_ID 
GROUP BY B.Book_ID,B.Title,B.Stock;










