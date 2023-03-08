-- Lab 6 - STUDENTS
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `STUDENTS`;
-- Q1
SELECT t.Last, t.First
FROM teachers AS t, list AS s
WHERE s.classroom = t.classroom
GROUP BY t.classroom
HAVING COUNT(*) = 2 OR COUNT(*) = 3
ORDER BY t.Last;


USE `STUDENTS`;
-- Q2
SELECT s.grade, GROUP_CONCAT(DISTINCT s.classroom SEPARATOR ', ') AS Classrooms
FROM teachers AS t, list AS s
WHERE t.classroom = s.classroom
GROUP BY s.grade
ORDER BY s.grade;


USE `STUDENTS`;
-- Q3
SELECT t.classroom, COUNT(*) AS NumStudents
FROM list AS s, teachers AS t
WHERE s.classroom = t.classroom
    AND s.grade = 0
GROUP BY t.classroom
ORDER BY COUNT(*) DESC;


USE `STUDENTS`;
-- Q4
SELECT s.classroom, MIN(s.LastName) AS FirstStudent
FROM list AS s, teachers AS t
WHERE s.classroom = t.classroom
    AND s.grade = 1
GROUP BY s.classroom
ORDER BY s.classroom;
