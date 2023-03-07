-- Lab 6 - AIRLINES
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `AIRLINES`;
-- Q1
SELECT airports.Code, airports.Name
FROM flights, airports
WHERE flights.Source = airports.Code
GROUP BY flights.Source
HAVING COUNT(flights.Source) = 19
ORDER BY flights.Source;


USE `AIRLINES`;
-- Q2
SELECT COUNT(DISTINCT f1.Source)
FROM flights AS f1, flights AS f2
WHERE f1.Destination = f2.Source
    AND f2.Destination = 'LTS'
    AND f1.Source != 'LTS';  -- exclude LTS


USE `AIRLINES`;
-- Q3
SELECT COUNT(DISTINCT f1.Source)
FROM flights AS f1, flights AS f2
WHERE f1.Destination = 'LTS'
    OR (f1.Destination = f2.Source
        AND f2.Destination = 'LTS'
        AND f1.Source != 'LTS');


USE `AIRLINES`;
-- Q4
SELECT airlines.Name, COUNT(DISTINCT airports.Code) AS Airports
FROM flights AS f1, flights AS f2, airlines, airports
WHERE f1.Airline = airlines.Id
    AND f2.Airline = airlines.Id
    AND f1.Source = airports.Code
    AND f2.Source = airports.Code
    AND f1.Source = f2.Source
    AND f1.Destination != f2.Destination
GROUP BY airlines.Id
ORDER BY COUNT(DISTINCT airports.Code) DESC, airlines.Name;
