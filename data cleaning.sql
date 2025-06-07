SELECT * 
FROM world_layoffs.layoffs;

-- REMOVE DUPLICATES
-- DATA STANDARDISATION
-- NULL VALUES OR BLANK VALUES
-- REMOVE ANY DUPLICATES

CREATE TABLE world_layoffs.layoff_f
lIKE world_layoffs.layoffs;


SELECT * 
FROM  world_layoffs.layoff_f;

INSERT world_layoffs.layoff_f 
SELECT *
FROM world_layoffs.layoffs;

SELECT * 
FROM world_layoffs.layoff_f;

WITH duplicate_c AS
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date') AS roe_num
FROM layoFf_f)
SELECT * 
FROM duplicate_c
WHERE ROE_NUM > 1;
    
    
    CREATE TABLE LAYOFF_F2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT DEFAULT NULL,
    percentage_laid_off TEXT,
    layoff_date DATE,  -- Changed to DATE type
    stage TEXT,
    country TEXT,
    funds_raised_millions INT DEFAULT NULL,
    roe_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


    SELECT * FROM LAYOFF_F2;
    
INSERT INTO LAYOFF_F2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',STAGE,country,funds_raised_millions) AS roe_num
FROM layoFf_f;

INSERT INTO LAYOFF_F2
SELECT company, location, industry, total_laid_off, percentage_laid_off, 
       STR_TO_DATE(`date`, '%m/%d/%Y') AS layoff_date,  -- Convert the date string
       STAGE, country, funds_raised_millions,
       ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, STAGE, country, funds_raised_millions) AS roe_num
FROM layoFf_f;

SELECT * FROM layoff_f2
WHERE ROE_NUM > 1
;

DELETE FROM layoff_f2 WHERE ROE_NUM > 1 AND  id > 0 ;

ALTER TABLE layoff_f2 ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

SELECT * FROM layoff_f2
WHERE ROE_NUM > 1;


SELECT * FROM layoff_f2;


-- data standardization
SELECT company, TRIM(company)
FROM layoff_f2;

UPDATE layoff_f2
SET company = TRIM(company);

SELECT industry
FROM layoff_f2
WHERE industry LIKE 'crypto%';

UPDATE layoff_f2
set industry = 'crypto'
WHERE industry like 'crypto%';

SELECT DISTINCT industry
FROM layoff_f2;

SELECT * FROM layoff_f2;

DELETE FROM layoff_f2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- exploratory data analysis

SELECT * FROM layoff_f2;

SELECT MAX(total_laid_off)
FROM layoff_f2;

SELECT MIN('date'),MAX('date')
FROM layoff_f2;



