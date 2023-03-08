-- Lab 6 - INN
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `INN`;
-- Q1
SELECT rooms.RoomName, SUM(Rate * DATEDIFF(CheckOut, CheckIn)) AS Revenue,
    AVG(Rate * DATEDIFF(CheckOut, CheckIn)) AS AvgRevenue
FROM rooms, reservations
WHERE rooms.RoomCode = reservations.Room
    AND MONTH(CheckIn) IN(6, 7, 8)
GROUP BY rooms.RoomCode
ORDER BY SUM(Rate * DATEDIFF(CheckOut, CheckIn)) DESC;


USE `INN`;
-- Q2
SELECT COUNT(*) AS NumReservations, SUM(Rate * DATEDIFF(CheckOut, CheckIn)) AS Revenue
FROM reservations
WHERE YEAR(CheckIn) = 2010 AND YEAR(CheckOut) = 2010
    AND WEEKDAY(CheckIn) = 0  -- monday
    AND WEEKDAY(CheckOut) = 5;  -- saturday;


USE `INN`;
-- Q3
SELECT DATE_FORMAT(CheckIn, '%W') AS Day, COUNT(*) AS Stays,
    SUM(Rate * DATEDIFF(CheckOut, CheckIn)) AS Revenue
FROM reservations
WHERE DATEDIFF(CheckOut, CheckIn) > 5
GROUP BY DATE_FORMAT(CheckIn, '%W')
ORDER BY GROUP_CONCAT(WEEKDAY(CheckIn));


USE `INN`;
-- Q4
SELECT rooms.RoomName, SUM(Adults + Kids) AS TotalPeople
FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
    AND YEAR(reservations.CheckIn) = 2010
GROUP BY rooms.RoomCode
ORDER BY SUM(Adults + Kids) DESC;


USE `INN`;
-- Q5
SELECT rooms.RoomCode, rooms.RoomName,
    SUM(
        CASE
            -- all before 2010
            WHEN YEAR(CheckIn) < 2010 AND YEAR(CheckOut) < 2010
                THEN 0
            -- subtract time before 2010
            WHEN YEAR(CheckIn) < 2010 AND YEAR(CheckOut) = 2010
                THEN DATEDIFF(CheckOut, CheckIn)
                    - DATEDIFF('2010-01-01', CheckIn)
            -- subtract time before and after 2010
            WHEN YEAR(CheckIn) < 2010 AND YEAR(CheckOut) > 2010
                THEN DATEDIFF(CheckOut, CheckIn)
                    - DATEDIFF('2010-01-01', CheckIn)
                    - DATEDIFF(CheckOut, '2011-01-01')
            -- entire duration in 2010
            WHEN YEAR(CheckIn) = 2010 AND YEAR(CheckOut) = 2010
                THEN DATEDIFF(CheckOut, CheckIn)
            -- subtract time after 2010, also subtract 1 for 2010-12-31???
            WHEN YEAR(CheckIn) = 2010 AND YEAR(CheckOut) > 2010
                THEN DATEDIFF(CheckOut, CheckIn) - 1
                    - DATEDIFF(CheckOut, '2011-01-01')
            -- all after 2010
            WHEN YEAR(CheckIn) > 2010
                THEN 0
            END
    )
    AS 2010Nights

FROM reservations, rooms
WHERE reservations.Room = rooms.RoomCode
GROUP BY rooms.RoomCode
ORDER BY 2010Nights DESC;
