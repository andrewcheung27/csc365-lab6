-- Lab 6 - KATZENJAMMER
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `KATZENJAMMER`;
-- Q1
SELECT b.Firstname, COUNT(v.Song)
FROM Vocals AS v, Band AS b
WHERE v.Bandmate = b.Id
    AND v.VocalType = 'lead'
GROUP BY b.Id
ORDER BY COUNT(v.Song) DESC;


USE `KATZENJAMMER`;
-- Q2
SELECT b.Firstname, COUNT(DISTINCT i.Instrument)
FROM Songs AS s, Albums AS a, Tracklists AS t, Instruments AS i, Band AS b
WHERE t.Song = s.SongId
    AND t.Album = a.AId
    AND i.Song = s.SongId
    AND i.Bandmate = b.Id
    AND a.Title = 'Rockland'
GROUP BY b.Id
ORDER BY b.Firstname;


USE `KATZENJAMMER`;
-- Q3
SELECT p.StagePosition, COUNT(DISTINCT p.Song) AS Times
FROM Performance AS p, Band AS b
WHERE p.Bandmate = b.Id
    AND b.Firstname = 'Solveig'
GROUP BY p.StagePosition
ORDER BY COUNT(DISTINCT p.Song);


USE `KATZENJAMMER`;
-- Q4
SELECT b.Firstname, COUNT(DISTINCT i.Song) AS Times
FROM Performance AS anne_p, Band AS anne_b, Instruments AS i, Band AS b
WHERE anne_p.Bandmate = anne_b.Id
    AND i.Bandmate = b.Id
    AND anne_p.Song = i.Song
    AND anne_b.Firstname = 'Anne-Marit'
    AND anne_p.StagePosition = 'left'
    AND b.Firstname != 'Anne-Marit'
    AND i.Instrument = 'bass balalaika'
GROUP BY b.Id
ORDER BY b.Firstname;


USE `KATZENJAMMER`;
-- Q5
SELECT i.Instrument
FROM Instruments AS i, Band AS b
WHERE i.Bandmate = b.Id
GROUP BY i.Instrument
HAVING COUNT(DISTINCT i.Bandmate) = 4
ORDER BY i.Instrument;


USE `KATZENJAMMER`;
-- Q6
SELECT b.Firstname, COUNT(DISTINCT i1.Song) AS MultipleInstruments
FROM Instruments AS i1, Instruments AS i2, Songs AS s, Band AS b
WHERE i1.Song = s.SongId
    AND i2.Song = s.SongId
    AND i1.Bandmate = b.Id
    AND i2.Bandmate = b.Id
    AND i1.Instrument != i2.Instrument
GROUP BY b.Id
ORDER BY b.Firstname;
