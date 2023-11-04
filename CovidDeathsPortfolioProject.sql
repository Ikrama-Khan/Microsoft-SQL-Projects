Select * 
from [dbo].[CovidDeath]
order by location;

--select * 
--from [dbo].[CovidVaccination];

select [location],[date],[total_cases],[new_cases],[total_deaths],[population]
From dbo.CovidDeath
order by 1,2;

--Looking at total cases VS total Deaths

select [location],[date],[total_cases],[total_deaths], (total_deaths/total_cases)*100 AS 'Death Percentage'
From dbo.CovidDeath
where location like '%pakistan%'
order by 1,2;


select [location],[date],[population],[total_cases], (total_cases/population)*100 AS 'Cases Percentage'
from dbo.CovidDeath
where location like '%states%'
order by 1,2;

--Looking at countries with highest infection rate compared to population.

select [location],[population],
MAX(total_cases) as 'highest infection rate',max(total_cases/population)*100 as PercentofPopulationInfected
from dbo.CovidDeath
group by location,population
order by PercentofPopulationInfected desc;



--Showing countries with highest death count

select [location],[population],
MAX(total_deaths) as 'highest Death rate',max(total_deaths/population)*100 as PercentofDeathperpopulation
from dbo.CovidDeath
group by location,population
order by PercentofDeathperpopulation desc;

select [location], MAX(total_deaths) as highestDeathCount
from dbo.CovidDeath
group by location
order by highestDeathCount desc;



select continent, MAX(total_deaths) as highestDeathCount
from dbo.CovidDeath
group by continent
order by highestDeathCount desc;


--Global Numbers by Date
select date,SUM(new_cases) as Total_Cases,SUM(new_deaths) as Total_Deaths,
SUM(new_deaths)/Nullif(SUM(new_cases)*100,0) as Death_Percentage
from CovidDeath
where continent is not null
group by date
order by 1,2;

--Global Numbers 
select SUM(cast(new_cases as bigint)) as Total_Cases,
SUM(cast(new_deaths as bigint)) as Total_Deaths,
SUM(cast(new_deaths as bigint))/SUM(cast(new_cases as bigint))*100 as Death_Percentage
from CovidDeath
where continent is not null
order by 1,2;


--looking at total population Vs Vaccination 

select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from CovidDeath as dea
inner join CovidVaccination as vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3;


--USEING CTE

with populationVSVaccination(continent,location,date,population,new_vaccination,Rolling_People_Vaccinated)
as
(select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from CovidDeath as dea
inner join CovidVaccination as vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 1,2,3
)
select *, (Rolling_People_Vaccinated/population)*100 
from populationVSVaccination;



--TEMP TABLE
drop table if exists #percentageofpopulationvaccinated
create table #percentageofpopulationvaccinated
(continent nvarchar(55),
location nvarchar(55),
date datetime,
population numeric,
new_vaccination numeric,
Rolling_People_Vaccinated numeric
)

insert into #percentageofpopulationvaccinated
select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from CovidDeath as dea
inner join CovidVaccination as vac
on dea.location = vac.location
and dea.date = vac.date
--where dea.continent is not null
--order by 1,2,3;

select *, (Rolling_People_Vaccinated/population)*100 
from #percentageofpopulationvaccinated;



--creating view to store data for later visualization

create view percentageofpopulationvaccinated
as
select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from CovidDeath as dea
inner join CovidVaccination as vac
on dea.location = vac.location
and dea.date = vac.date;
--where dea.continent is not null
--order by 1,2,3;

select * 
from percentageofpopulationvaccinated;



















