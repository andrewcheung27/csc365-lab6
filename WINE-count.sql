-- Lab 6 - WINE
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `WINE`;
-- Q1
SELECT Score, AVG(Price) AS AvgPrice, MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice, COUNT(*) AS NumWines, SUM(Cases) AS NumCases
FROM wine
WHERE Score > 88
GROUP BY Score
ORDER BY Score;


USE `WINE`;
-- Q2
SELECT wine.Grape, MAX(wine.Price * 12) AS MaxPrice
FROM wine, grapes
WHERE wine.Grape = grapes.Grape
    AND grapes.Color = 'Red'
GROUP BY wine.Grape
HAVING COUNT(*) > 10
ORDER BY MAX(wine.Price * 12) DESC;


USE `WINE`;
-- Q3
SElECT wine.Winery, GROUP_CONCAT(DISTINCT wine.Name SEPARATOR ', ') AS Wine
FROM wine, grapes
WHERE wine.Grape = grapes.Grape
    AND wine.Grape = 'Zinfandel'
    AND wine.Appellation = 'Sonoma Valley'
GROUP BY wine.Winery
ORDER BY wine.Winery;


USE `WINE`;
-- Q4
SELECT a.County, MAX(w.Score) AS BestScore
FROM wine AS w, appellations AS a, grapes AS g
WHERE w.Appellation = a.Appellation
    AND w.Grape = g.Grape
    AND w.Vintage = 2009
    AND g.Color = 'Red'
    AND a.County != 'N/A'
GROUP BY a.County
ORDER BY MAX(w.Score) DESC;
