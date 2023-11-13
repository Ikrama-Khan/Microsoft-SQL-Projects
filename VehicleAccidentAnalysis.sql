select * 
from accident;
select * 
from vehicle;


-- Question1: How many accidents have occurred in urden areas verses rural Areas ?

select Area, count(AccidentIndex) AS Total_Accidents
from accident
group by(Area);

--Question2: Which day of the week has the highest number of Accidents?

select [Day], COUNT(AccidentIndex) as Number_of_Accidents
from accident
group by [Day]
order by Number_of_Accidents desc;

--Question3: What is the Average age of vehicles involved in accidents based on their types? 

select * from vehicle;

SELECT VehicleType,
COUNT([AccidentIndex]) AS 'Total Accidents',
AVG(AgeVehicle) AS 'Average Vehicle Age'
FROM vehicle
WHERE AgeVehicle IS NOT NULL
GROUP BY VehicleType
ORDER BY 2 DESC;


--Question4: Can we Identify any trends in accidents based on the age vehicles involved?

select * from vehicle;

SELECT 
AgeGroup,
COUNT(AccidentIndex) AS 'Total Accident',
AVG(AgeVehicle) AS 'Average Vehicle Age'
FROM
(SELECT AccidentIndex,AgeVehicle,
CASE
WHEN AgeVehicle BETWEEN 0 AND 5 THEN 'NEW'
WHEN AgeVehicle BETWEEN 6 AND 10 THEN 'REGULAR'
ELSE 'OLD'
END 
AS 'AgeGroup'
from vehicle) as subquery
GROUP BY AgeGroup;

--Question5: Are there any specific weather conditions which contribute to severe accidents ?

select * from accident;

DECLARE @SEVERITY AS VARCHAR(100)
SET @SEVERITY  = 'Fatal' 
SELECT WeatherConditions,
COUNT(Severity) AS 'Total Accidents' 
FROM accident
WHERE
Severity = @SEVERITY
GROUP BY WeatherConditions
ORDER BY 'Total Accidents' desc;

--Question6: Do accidents often invole impacts on the left-hand side of vehicles ?
select * from vehicle;

select COUNT(AccidentIndex) AS TotalDeaths,LeftHand
from vehicle
group by LeftHand
having LeftHand is not null;

--Question7: Are there any relationship between journey purposes and the severity of accidents?

select * from accident;
select * from vehicle;

select v.JourneyPurpose, count(a.Severity) AS 'Total Accident',
CASE
WHEN count(a.Severity) between 0 and 1000 then 'LOW'
WHEN count(a.Severity) between 1001 and 3000 then 'MODERATE'
ELSE 'HIGH' 
END 
AS 'LEVEL'
from accident as a
inner join vehicle as v
on a.AccidentIndex = v.AccidentIndex
group by v.JourneyPurpose
order by 'Total Accident' desc ;

--Question8: Calculate the AVG age of vehicle involved in accidents, considering daylight and point of impact.
select * from accident;
select * from vehicle;

DECLARE @impact varchar(100)
DECLARE @light varchar(100)
SET @impact = 'Offside'
SET @light = 'Daylight'

select A.LightConditions, V.PointImpact,
AVG(V.AgeVehicle) AS 'Average Vehicle Age'
from vehicle as V
inner join accident as A
on V.AccidentIndex = A.AccidentIndex
GROUP BY A.LightConditions, V.PointImpact
HAVING V.PointImpact = @impact AND A.LightConditions = @light




 






























































