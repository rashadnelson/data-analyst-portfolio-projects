--SELECT * 
--FROM PortfolioProject..CovidDeaths$
--ORDER BY 3, 4

--SELECT * 
--FROM PortfolioProject..CovidVaccinations$
--ORDER BY 3, 4


-- Select the data that we're going to be using

--SELECT location, date, total_cases, new_cases, total_deaths, population
--FROM PortfolioProject..CovidDeaths$
--ORDER BY 1, 2


-- Looking at the Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract Covid in your country

--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Rate
--FROM PortfolioProject..CovidDeaths$
--WHERE location like '%states%'
--ORDER BY 1, 2


-- Looking at Total Cases vs Population
-- Shows what pcercentage of population got Covid

--SELECT location, date, population, total_cases, (total_cases/population)*100 AS Percent_Population_Infected
--FROM PortfolioProject..CovidDeaths$
--WHERE location like '%states%'
--ORDER BY 1, 2


-- Looking at Countries with Highest Infection Rate compared to Population

--SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_Population_Infected
--FROM PortfolioProject..CovidDeaths$
----WHERE location like '%states%'
--GROUP BY location, population
--ORDER BY Percent_Population_Infected DESC


-- Showing the Countries with the Highest Death Count

--SELECT location, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
--FROM PortfolioProject..CovidDeaths$
--WHERE continent IS NOT NULL
--GROUP BY location
--ORDER BY Total_Death_Count DESC


-- Showing the Continents with the Highest Death Count

--SELECT continent, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
--FROM PortfolioProject..CovidDeaths$
--WHERE continent IS NOT NULL
---- AND location NOT LIKE '%income%'
--GROUP BY continent
--ORDER BY Total_Death_Count DESC


-- GLOBAL NUMBERS

--SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS Death_Rate
--FROM PortfolioProject..CovidDeaths$
---- WHERE location like '%states%'
--WHERE continent IS NOT NULL
----ORDER BY 1, 2


-- MAIN JOINING OF BOTH SPREADSHEETS

--SELECT * 
--FROM PortfolioProject..CovidDeaths$ dea
--JOIN PortfolioProject..CovidVaccinations$ vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date



-- CREATING A TEMP TABLE.  DROP THE EXISTING TABLE TO MAKE ROOM FOR UPDATES.

--DROP TABLE IF EXISTS #percent_population_vaccinated
--CREATE TABLE #percent_population_vaccinated
--(
--continent nvarchar(255), 
--location nvarchar(255),
--date datetime, 
--population numeric, 
--new_vaccinations numeric, 
--)


-- LOOKING AT TOTAL POPULATION VS VACCINATIONS AND INSERT INTO NEW TABLE

--INSERT INTO #percent_population_vaccinated
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--FROM PortfolioProject..CovidDeaths$ dea
--JOIN PortfolioProject..CovidVaccinations$ vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL
--AND vac.new_vaccinations IS NOT NULL
--ORDER BY 1, 2, 3


------ SELECT NEWLY CREATE TABLE
--SELECT *
--FROM #percent_population_vaccinated


--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS

--CREATE VIEW percent_population_vaccinated AS
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--FROM PortfolioProject..CovidDeaths$ dea
--JOIN PortfolioProject..CovidVaccinations$ vac
--	ON dea.location = vac.location
--	AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL
--AND vac.new_vaccinations IS NOT NULL
----ORDER BY 1, 2, 3