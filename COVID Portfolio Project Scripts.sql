SELECT *
FROM PortfolioProject..Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..Covid_Vaccinations
--ORDER BY 3,4

-- Select Data that we are going to be using 

SELECT Location, Date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..Covid_Deaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid in your country

SELECT Location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

SELECT Location, Date, Population, total_cases, (total_cases/population)*100 AS PopulationPercentage
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Looking at countries with Highest Infection Rate compared to Population

SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC

-- Looking at countries with Highest Death Count per Population

SELECT Location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC

-- Break things down by Continent
-- Correct Way

--SELECT location, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
--FROM PortfolioProject..Covid_Deaths
---- WHERE location like '%states'
--WHERE continent IS NULL
--GROUP BY location
--ORDER BY TotalDeathCount DESC

-- Incorrect way
SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Look at Continents with the Highest Death Count per Population

SELECT continent, MAX(CAST(Total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global Numbers Death Percentage by Date

SELECT Date, SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS INT)) AS Total_Deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 DeathPercentage
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
GROUP BY Date
ORDER BY 1,2

-- Total world numbers

SELECT SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS INT)) AS Total_Deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 DeathPercentage
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Join Covid_Deaths and Covid_Vaccinations

SELECT *
FROM PortfolioProject..Covid_Deaths dea
JOIN PortfolioProject..Covid_Vaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date

-- Looking at Total Population vs Vaccination

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccinations,
(RollingVaccinations/population)* 100
FROM PortfolioProject..Covid_Deaths dea
JOIN PortfolioProject..Covid_Vaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3

-- CTE

WITH PopvsVac (Continent, Location, Date, Population, New_Vaccination, RollingVaccinations)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccinations
--(RollingVaccinations/population)* 100
FROM PortfolioProject..Covid_Deaths dea
JOIN PortfolioProject..Covid_Vaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3
)
SELECT *, (RollingVaccinations/Population)*100 AS RollingPCT
FROM PopvsVac

-- TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingVaccinations numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccinations
--(RollingVaccinations/population)* 100
FROM PortfolioProject..Covid_Deaths dea
JOIN PortfolioProject..Covid_Vaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3

SELECT *, (RollingVaccinations/Population)*100 AS RollingPCT
FROM #PercentPopulationVaccinated

-- Creating View to store data for later visualizations
-- Looking at Total Population vs Vaccination

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingVaccinations
--(RollingVaccinations/population)* 100
FROM PortfolioProject..Covid_Deaths dea
JOIN PortfolioProject..Covid_Vaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3

-- Total Cases vs Total Deaths

CREATE VIEW CasevsDeath AS
SELECT Location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
--ORDER BY 1,2

-- Percentage of population got Covid

CREATE VIEW CovidAffected AS
SELECT Location, Date, Population, total_cases, (total_cases/population)*100 AS PopulationPercentage
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
-- ORDER BY 1,2

-- Looking at countries with Highest Infection Rate compared to Population

CREATE VIEW InfectionRates AS
SELECT Location, Population, MAX(total_cases) AS HighestInfectionCount, (MAX(total_cases)/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..Covid_Deaths
-- WHERE location like '%states'
WHERE continent IS NOT NULL
GROUP BY Location, Population
-- ORDER BY PercentPopulationInfected DESC

