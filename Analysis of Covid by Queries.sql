-- Covid Exploration Project
-- a.Datewise likelihood of dying due to covid- Totalcases vs TotalDeath - in India
select date, total_cases, total_deaths from "CovidDeaths" where location like '%India%'
-- b.Total % of deaths out of entire population in india
select (max (total_deaths)/avg(cast(population as integer))*100) from "CovidDeaths" where location like '%India'
--c. verify b by getting info separately
select total_deaths, population from "CovidDeaths" where location like '%India%'
--d. Country with highest deaths as a % of population
select location, (max(total_deaths)/avg(cast(population as bigint))*100) as percentage from "CovidDeaths" group by location order by percentage desc;
-- e. Total % of covid +ve cases in India
select (max(total_cases)/avg(cast(population as bigint))*100) as percentagepositive from "CovidDeaths" where location like '%India'
--f. Total % of covid +ve cases in the world
select location, (max(total_cases)/avg(cast(population as bigint))*100) as percentagepositive from "CovidDeaths" group by location order by percentagepositive desc;
--g. Continentwise +ve cases
select location, max(total_cases) as total_case from "CovidDeaths" where continent is null group by location order by total_case desc;
--h. Continentwise deaths
select location, max(total_deaths) as total_death from "CovidDeaths" where continent is null group by location order by total_death desc;
--i. Daily newcases vs hospitalizations VS icu_patients - India
select date, new_cases, hosp_patients, icu_patients from "CovidDeaths" where location like '%India';
--j. countrywise age 65>
select "CovidDeaths".date, "CovidDeaths".location, "CovidVaccinations".aged_65_older from "CovidDeaths" join "CovidVaccinations" on "CovidDeaths".iso_code = "CovidVaccinations".iso_code and "CovidDeaths".date = "CovidVaccinations".date;
--k. Countrywise total vaccinated persons
select "CovidDeaths".location as country, (max("CovidVaccinations".people_fully_vaccinated)) as fully_vaccinated from "CovidDeaths" join "CovidVaccinations" on "CovidDeaths".iso_code = "CovidVaccinations".iso_code and "CovidDeaths".date = "CovidVaccinations".date where "CovidDeaths".continent is not null group by country order by fully_vaccinated
