-- DATA CLEANING 

SELECT *
FROM layoffs;

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT *
FROM layoff_staging;

INSERT layoff_staging
SELECT *
FROM layoffs;

-- REMOVING DUPLICATES
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, 'date') AS row_num
FROM layoff_staging;

-- CREATING CTE
WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 'date') AS row_num
FROM layoff_staging
)

SELECT * 
FROM duplicate_cte 
WHERE row_num > 1;

SELECT *
FROM layoff_staging
WHERE company = 'casper';

WITH duplicate_cte AS 
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 'date') AS row_num
FROM layoff_staging
)

DELETE 
FROM duplicate_cte 
WHERE row_num > 1;


CREATE TABLE Layoffs_staging2 (
	company text,
	location text, 
	industry text ,
	total_laid_off int DEFAULT NULL ,
	percentage_laid_off text ,
	date text ,
	stage text ,
	country text ,
	funds_raised_millions int DEFAULT NULL,
    row_num INT );

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, stage, country, funds_raised_millions, 'date') AS row_num
FROM layoff_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE 
FROM layoffs_staging2
WHERE row_num > 1;
-- DUPLICATES ARE REMOVED!