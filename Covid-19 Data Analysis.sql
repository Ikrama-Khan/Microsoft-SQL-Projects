select * from CovidDataTable;

--Shows likelihood of a person would be died in case of one has been infected?

--Shows likelihood of a person would be died in case of one has been vaccinated?

--Shows likelihood of a person would be infected in case of one has been vaccinated?

--which country has the highest death rate as compare to population ?

--which coountry has the highest infection rate as compare to population ?

------------------------------------------------------------------------------------

--Shows likelihood of a person would be died in case of one has been infected?
select * from CovidDataTable;

select location ,SUM(dead) as SUM_OF_DEATH,SUM(infected) AS SUM_OF_INFECTED,
LEFT((1.0*sum(dead)/SUM(infected)*100),6) AS DEATHS_INFECTED_LIKELIHOOD
from CovidDataTable
GROUP BY location
ORDER BY location;


--Shows likelihood of a person would be died in case of one has been vaccinated?

select location ,SUM(dead) as SUM_OF_DEATH,SUM(vaccinated) AS SUM_OF_VACCINATED,
LEFT((1.0*sum(dead)/SUM(vaccinated)*100),6) AS DEAD_VACCINATED_LIKELIHOOD
from CovidDataTable
GROUP BY location
ORDER BY DEAD_VACCINATED_LIKELIHOOD desc;

--Shows likelihood of a person would be infected in case of one has been vaccinated?

select location ,SUM(infected) as SUM_OF_INFECTED,SUM(vaccinated) AS SUM_OF_VACCINATED,
LEFT((1.0*sum(infected)/SUM(vaccinated)*100),6) AS INFECTED_VACCINATED_LIKELIHOOD
from CovidDataTable
GROUP BY location
ORDER BY INFECTED_VACCINATED_LIKELIHOOD asc;

--which country has the highest death rate as compare to population ?

select location, [population],SUM(dead) as SUM_OF_DEAD, 
LEFT((1.0*sum(dead)/[population]*100),6) AS HIGHEST_DEATH_RATE 
from CovidDataTable
GROUP BY location,[population]
ORDER BY HIGHEST_DEATH_RATE DESC;


--which country has the highest infection rate as compare to population ?

select location, [population],SUM(infected) as SUM_OF_INFECTED, 
LEFT((1.0*sum(infected)/[population]*100),6) AS HIGHEST_INFECTED_RATE 
from CovidDataTable
GROUP BY location,[population]
ORDER BY HIGHEST_INFECTED_RATE DESC;













