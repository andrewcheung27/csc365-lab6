-- Lab 6 - CSU
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `CSU`;
-- Q1
SELECT campuses.Campus, AVG(enrollments.FTE) AS AvgEnrollment
FROM campuses, fees, enrollments
WHERE fees.CampusId = campuses.Id
    AND enrollments.CampusId = campuses.Id
    AND fees.Year >= 2000
    AND fees.Year <= 2004
    AND enrollments.Year = fees.Year
GROUP BY campuses.Id
HAVING AVG(fees.fee) > 2300
ORDER BY AVG(enrollments.FTE) DESC;


USE `CSU`;
-- Q2
SELECT c.Campus, MIN(e.Enrolled) AS Min, AVG(e.Enrolled) AS Avg,
    MAX(e.Enrolled) AS Max, STD(e.Enrolled) AS StDev
FROM enrollments AS e, campuses AS c
WHERE e.CampusId = c.Id
GROUP BY c.Id
HAVING MAX(e.Year) - MIN(e.Year) > 60
ORDER BY AVG(e.Enrolled) DESC;


USE `CSU`;
-- Q3
SELECT c.Campus, SUM(f.Fee * e.Enrolled) AS Revenue
FROM campuses AS c, fees AS f, enrollments AS e
WHERE f.CampusId = c.Id
    AND e.CampusId = c.Id
    AND f.Year = e.Year
    AND c.County IN('Los Angeles', 'Orange')
    AND f.Year >= 2001
GROUP BY c.Id
ORDER BY SUM(f.Fee * e.Enrolled) DESC;


USE `CSU`;
-- Q4
SELECT c.Campus, COUNT(DISTINCT de.Discipline) AS Disciplines
FROM campuses AS c, enrollments AS e, discEnr AS de
WHERE e.CampusId = c.Id
    AND de.CampusId = c.Id
    AND e.Enrolled > 20000
    AND e.Year = de.Year
    AND de.Year = 2004
    AND de.Gr > 0
GROUP BY c.Id
ORDER BY c.Campus;
