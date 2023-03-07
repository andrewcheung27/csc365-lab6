-- Lab 6 - CARS
-- Name: Andrew Cheung
-- Email: acheun29@calpoly.edu


USE `CARS`;
-- Q1
SELECT carmakers.Maker, AVG(cardata.MPG) AS AvgMPG, STD(cardata.MPG) AS StdMPG
FROM makes, models, carmakers, cardata, countries, continents
WHERE makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND makes.Id = cardata.Id
    AND carmakers.Country = countries.Id
    AND countries.Continent = continents.Id
    AND continents.Name = 'europe'
    AND cardata.MPG IS NOT NULL
GROUP BY carmakers.Id
ORDER BY MAX(cardata.MPG);


USE `CARS`;
-- Q2
SELECT carmakers.Maker, COUNT(makes.Id) AS FastCars
FROM makes, models, carmakers, cardata, countries
WHERE makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND makes.Id = cardata.Id
    AND carmakers.Country = countries.Id
    AND countries.Name = 'usa'
    AND cardata.Cylinders = 4
    AND cardata.Weight < 4000
    AND cardata.Accelerate < 14
GROUP BY carmakers.Id
ORDER BY COUNT(makes.Id) DESC;


USE `CARS`;
-- Q3
SELECT cardata.Year, MAX(t_data.MPG), MIN(t_data.MPG), AVG(t_data.MPG)
FROM makes, cardata, models, carmakers,
    makes AS t_makes, models AS t_models, cardata AS t_data
WHERE makes.Id = cardata.Id
    AND makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Maker = 'honda'

    AND t_makes.Model = t_models.Model
    AND t_makes.Id = t_data.Id
    AND t_models.Model = 'toyota'
    AND t_data.Year = cardata.Year
GROUP BY cardata.Year
HAVING COUNT(DISTINCT makes.Id) > 2;


USE `CARS`;
-- Q4
SELECT cardata.Year, COUNT(*) AS NumCars
FROM makes, models, carmakers, cardata, countries
WHERE makes.Id = cardata.Id
    AND makes.Model = models.Model
    AND models.Maker = carmakers.Id
    AND carmakers.Country = countries.Id
    AND countries.Name = 'japan'
    AND cardata.Year >= 1975 AND cardata.Year <= 1979
    AND cardata.Horsepower < 150
GROUP BY cardata.Year;
