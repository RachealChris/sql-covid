select *
from covid;

select *
from covid
where field2 = "Asia";

ALTER table covid
RENAME field2 to "Continent"

--Checking to see if the altering worked 
select *
from covid
where Continent = "Asia";

--changing the column names for other selected columns

ALTER table covid
RENAME field1 to "iso_code"

ALTER table covid
RENAME field3 to "location"

ALTER table covid
RENAME field4 to "date"

ALTER table covid
RENAME field5 to "total_cases"


ALTER table covid
RENAME field6 to "new_cases"

ALTER table covid
RENAME field8 to "total_deaths"

ALTER table covid
RENAME field35 to "total_vaccinations"

ALTER table covid
RENAME field63 to "population"


select *
from covid
where Continent not NULL
;

--Selecting data that we are going to use

select Continent, location, date, total_cases, new_cases, total_deaths, population
from covid
;

--Looking at total cases vs total deaths
--Showing the likelihood of dying if you get covid in each country
select Continent, location, date, total_cases, new_cases, total_deaths, population,
(total_deaths/total_cases)*100 as DeathPercentage
from covid
;


--Looking at death percentages in the USA


select Continent, location, date, total_cases, new_cases, total_deaths, population,
(total_deaths/total_cases)*100 as DeathPercentageStates
from covid
where location like "%state%";


--Looking at total cases vs population
--shows what percentage of population got covid

select Continent, location, date, total_cases, new_cases, total_deaths, population,
(total_cases/population)*100 as PercentagePopulationInfected
from covid
; 

--Looking at countries with highest infection rate compared to the population
select location, population, 
		max(total_cases) as HighestInfectionRate, 
		max(total_cases/population)*100 as PercentagePopulationInfected
from covid
group by population, location
order by PercentagePopulationInfected desc;

--Showing countries with the highest death count per population
select Continent, location, population, total_deaths,
		max(total_deaths/population) as HighestDeathsperPopulation
from covid
group by population, total_deaths
order by HighestDeathsperPopulation DESC; 		

--Total deaths per continent
select Continent, location, population, max(total_deaths) as TotalDeathCount
from covid
where Continent is not NULL
group by location
order by TotalDeathCount DESC; 		
		
--Breaking things down by Continent
select Continent, location, population, max(total_deaths) as TotalDeathCount
from covid
where Continent is not NULL
group by Continent
order by TotalDeathCount DESC; 	

--GLOBAL NUMBERS
select Continent, date, sum(new_cases) as TotalNewCases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from covid
where Continent is not NULL 
group by date
order by TotalNewCases desc;

--Vaccinations
select Continent, location, date, total_cases, total_vaccinations, total_deaths,
	(total_deaths/total_vaccinations)as DeathsperVaccination,
	(total_vaccinations/population) as VaccinationsperPopulation
from covid
where Continent is not NULL 
order by DeathsperVaccination desc;
	

