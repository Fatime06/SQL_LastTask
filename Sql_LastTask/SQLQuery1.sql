CREATE DATABASE RestaurantDB
USE RestaurantDB


CREATE TABLE Meals(
ID INT PRIMARY KEY IDENTITY,
Name VARCHAR(70),
Price INT
)


CREATE TABLE Tables(
ID INT PRIMARY KEY IDENTITY,
Numbers INT
)


CREATE TABLE Orders(
MealID INT FOREIGN KEY REFERENCES Meals(ID),
TableID INT FOREIGN KEY REFERENCES Tables(ID)
PRIMARY KEY(MealID, TableID),
CreateDate DATETIME2
)



INSERT INTO Meals (Name, Price)
VALUES ('Pizza', 12),
       ('Burger', 8),
       ('Dolma', 10),
       ('Kabab', 15),
       ('Sushi', 20)


INSERT INTO Tables (Numbers)
VALUES (1),
       (2),
       (3)




INSERT INTO Orders (MealID, TableID, CreateDate)
VALUES (1, 1, GETDATE()),
       (5, 1, GETDATE()),
       (2, 2, GETDATE()),
       (4, 2, GETDATE()),
       (3, 3, GETDATE())


SELECT t.Numbers AS TableNumber, COUNT(*) AS OrderCount FROM Tables t
JOIN Orders o
ON 
t.ID = o.TableID
GROUP BY t.Numbers


SELECT m.Name AS MealName, COUNT(*) AS MealCount FROM Meals m
JOIN Orders o
ON
m.ID = o.MealID
GROUP BY m.Name



SELECT  m.Name AS MealName, o.CreateDate AS Dates FROM Orders O
JOIN Meals m
ON
o.MealID=m.ID
GROUP BY  o.CreateDate, m.Name;


SELECT t.Numbers AS TableNumber, m.Name AS MealName, o.CreateDate AS Dates FROM Orders O
JOIN Meals m
ON
o.MealID=m.ID
JOIN Tables t
ON
o.TableID=t.ID
GROUP BY t.Numbers, o.CreateDate, m.Name;



SELECT t.Numbers AS TableNumber, SUM(Price) AS SumOfPrice FROM Tables t
JOIN Orders o
ON
t.ID = o.TableID
JOIN Meals m
ON
m.ID = o.MealID
GROUP BY t.Numbers



SELECT DATEDIFF(DAY, MIN(o.CreateDate), MAX(o.CreateDate)) AS TimeDifferenceInMinutes
FROM Orders o
WHERE o.TableID = 1;


SELECT DATEADD(MINUTE, -30, GETDATE()) AS Last30MinuteAgo;


SELECT *
FROM Tables t
WHERE NOT EXISTS (SELECT * FROM Orders o WHERE o.TableID = t.ID
)




SELECT t.ID AS TableID, t.Numbers FROM Tables t
WHERE NOT EXISTS (
SELECT * FROM Orders o WHERE o.TableID=t.ID AND o.CreateDate >= DATEADD(MINUTE, -60, GETDATE())
)

