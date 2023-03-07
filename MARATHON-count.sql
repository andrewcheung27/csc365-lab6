-- Lab 6 - MARATHON
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `MARATHON`;
-- Q1
SELECT AgeGroup, Sex, COUNT(*) AS NumRunners,
    MIN(Place) AS BestPlace, MAX(Place) AS WorstPlace
FROM marathon
GROUP BY AgeGroup, Sex
ORDER BY AgeGroup, Sex;


USE `MARATHON`;
-- Q2
SELECT COUNT(*)
FROM marathon AS m1, marathon AS m2
WHERE m1.AgeGroup = m2.AgeGroup AND m1.Sex = m2.Sex
    AND m1.GroupPlace = 1
    AND m2.GroupPlace = 2
    AND m1.State = m2.State;


USE `MARATHON`;
-- Q3
SELECT TIME_FORMAT(Pace, '%i'), COUNT(*) AS NumRunners
FROM marathon
GROUP BY TIME_FORMAT(Pace, '%i');


USE `MARATHON`;
-- Q4
SELECT State, COUNT(*) AS GroupTop10
FROM marathon
WHERE GroupPlace <= 10
GROUP BY State
ORDER BY COUNT(*) DESC;
