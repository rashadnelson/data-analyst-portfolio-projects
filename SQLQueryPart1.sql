-- SQL PROJECT:  ARMED FORCES PERSONNEL LABOR PERCENTAGE BY LOCATION

--SELECT THE ENTIRE DATASET

--SELECT * 
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$
--ORDER BY 1, 2, 3


--SELECT THE DATASET BY SPECIFIC COLUMNS

--SELECT entity, code, year, percentage_of_labor
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$
--ORDER BY 1, 2, 3


-- SELECT ARMED FORCES PERSONNEL WHERE PERCENTAGE OF LABOR FORCE IS 5% OR ABOVE

--SELECT entity, code, year, percentage_of_labor
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$
--WHERE percentage_of_labor >= 5
--ORDER BY 1, 2, 3


-- SEE WHICH COUNTRIES HAVE THE HIGHEST LABOR FORCE RATE AMONG ARMED FORCES PERSONNEL SINCE THE DATA WAS COLLECTED

--SELECT entity, code, year, percentage_of_labor
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$
--ORDER BY percentage_of_labor DESC


-- SEE WHICH COUNTRIES HAVE THE LOWEST LABOR FORCE RATE AMONG ARMED FORCES PERSONNEL SINCE THE DATA WAS COLLECTED

--SELECT entity, code, year, percentage_of_labor
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$
--ORDER BY percentage_of_labor ASC


-- SEE WHICH COUNTRIES HAVE THE HIGHEST LABOR FORCE RATE FROM 2015 TO 2020

--SELECT entity, code, year, percentage_of_labor
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$
--WHERE year < 2020
--AND year > 2015
--ORDER BY percentage_of_labor ASC


-- CREATING A TEMP TABLE.  DROP EXISTING TABLE TO MAKE ROOM FOR UPDATES.

--DROP TABLE IF EXISTS #armed_forces_labor_participation
--CREATE TABLE #armed_forces_labor_participation
--(
--location nvarchar(255), 
--location_code nvarchar(255),
--year numeric, 
--labor_percentage numeric, 
--)


-- INSERT DATA INTO NEWLY FORMED TABLE

--INSERT INTO #armed_forces_labor_participation
--SELECT *
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$


-- SELECT NEWLY CREATE TABLE
--SELECT *
--FROM #armed_forces_labor_participation


--CREATING VIEW TO STORE DATA FOR LATER VISUALIZATIONS

--CREATE VIEW armed_forces_labor_participation_view AS
--SELECT *
--FROM PortfolioProject..ArmedForcesPersonnelLaborForce$





-- SQL PROJECT:  COVID DEATHS AND VACCINATIONS


-- PULLING THE ENTIRE DATASET - COVID DEATHS

--SELECT * 
--FROM PortfolioProject..CovidDeaths$
--ORDER BY 3, 4


-- PULLING THE ENTIRE DATASET - COVID VACCINATIONS

--SELECT * 
--FROM PortfolioProject..CovidVaccinations$
--ORDER BY 3, 4


-- SELECTING THE DATA TO BE USED

--SELECT location, date, total_cases, new_cases, total_deaths, population
--FROM PortfolioProject..CovidDeaths$
--ORDER BY 1, 2


-- TOTAL CASES VS TOTAL DEATHS

--SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Rate
--FROM PortfolioProject..CovidDeaths$
--WHERE location like '%states%'
--ORDER BY 1, 2


-- TOTAL CASES VS. POPULATION

--SELECT location, date, population, total_cases, (total_cases/population)*100 AS Percent_Population_Infected
--FROM PortfolioProject..CovidDeaths$
--WHERE location like '%states%'
--ORDER BY 1, 2


-- COUNTRIES WITH HIGHEST INFECTION RATES COMPARED TO POPULATION

--SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Percent_Population_Infected
--FROM PortfolioProject..CovidDeaths$
----WHERE location like '%states%'
--GROUP BY location, population
--ORDER BY Percent_Population_Infected DESC


-- COUNTRIES WITH HIGHEST DEATH COUNT

--SELECT location, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
--FROM PortfolioProject..CovidDeaths$
--WHERE continent IS NOT NULL
--GROUP BY location
--ORDER BY Total_Death_Count DESC


-- CONTINENTS WTIH HIGHEST DEATH COUNT

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


-- SELECT NEWLY CREATE TABLE

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
--ORDER BY 1, 2, 3
