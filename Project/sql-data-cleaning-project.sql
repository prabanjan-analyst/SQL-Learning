CREATE DATABASE data_cleaning_project;

USE data_cleaning_project;

-- ORIGINAL dataset
SELECT * FROM layoffs;

-- Take a copy of the ORIGINAL dataset
-- It takes the copy of the columns only
CREATE TABLE layoffs_staging LIKE layoffs;

SELECT * FROM layoffs_staging;

-- INSERT the all data from the layoffs into layoffs_staging
INSERT layoffs_staging SELECT * FROM layoffs;

SELECT * FROM layoffs_staging;

-- To Find duplicates by giving the ROW NUMBER() fn
SELECT *, ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, 
	percentage_laid_off, `date`, stage, country, 
    funds_raised_millions) AS row_num
FROM layoffs_staging;

-- To Create a new table to add this ROW NUMBER() fn as a seperate column
CREATE TABLE layoffs_staging_2 LIKE layoffs_staging;
SELECT * FROM layoffs_staging_2;

-- To ADD the row_num Column to the table
ALTER TABLE layoffs_staging_2
ADD COLUMN row_num INT;

-- To INSERT the all data including the ROW_NUMBER()
INSERT INTO layoffs_staging_2
SELECT *, ROW_NUMBER() 
OVER(PARTITION BY company, location, industry, total_laid_off, 
	percentage_laid_off, `date`, stage, country, 
    funds_raised_millions) AS row_num
FROM layoffs_staging;
 
SELECT * FROM layoffs_staging_2;

-- To Find the Duplicates by the row_num
SELECT * FROM layoffs_staging_2
WHERE row_num > 1;

-- To DELETE the Duplicates by the row_num
DELETE FROM layoffs_staging_2
WHERE row_num > 1;

SELECT * FROM layoffs_staging_2;

-- STANDARDIZE THE DATA
-- To Find the white spaces
SELECT DISTINCT company, TRIM(company) 
FROM layoffs_staging_2 ORDER BY 1;

-- To remove and UPDATE the white spaces
UPDATE layoffs_staging_2
SET company = TRIM(company);

SELECT * FROM layoffs_staging_2;

-- To find the Duplicate values
SELECT DISTINCT industry FROM layoffs_staging_2 ORDER BY 1;

SELECT * FROM layoffs_staging_2 WHERE industry LIKE 'Crypto%'; 

-- To UPDATE the All Duplicate values as same
UPDATE layoffs_staging_2 
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT * FROM layoffs_staging_2;

-- To move into DATE
SELECT `date` 
FROM layoffs_staging_2; 

-- To change the FORMAT of the date
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging_2;

-- To update the FORMATTED Date
UPDATE layoffs_staging_2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT * FROM layoffs_staging_2;

-- To change the DataType of the date column, TEXT => DATE
ALTER TABLE layoffs_staging_2
MODIFY `date` DATE; 

SELECT * FROM layoffs_staging_2;

-- To find the extra special characters in the same value
SELECT DISTINCT country FROM layoffs_staging_2 ORDER BY 1;

-- To TRIM that special character
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) 
FROM layoffs_staging_2 ORDER BY 1;

-- To UPDATE the trimmed value
UPDATE layoffs_staging_2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'; 

SELECT DISTINCT country FROM layoffs_staging_2 ORDER BY 1;

-- To find empty industry or NULL  
SELECT * FROM layoffs_staging_2
WHERE industry = '' OR industry IS NULL;

-- To UPDATE all empty industry to NULL value
UPDATE layoffs_staging_2 
SET industry = NULL
WHERE industry = '';

SELECT * FROM layoffs_staging_2
WHERE company = 'Airbnb';

-- To find the same matching company and industry using JOIN
SELECT * FROM layoffs_staging_2 t1 JOIN layoffs_staging_2 t2
ON t1.company = t2.company 
WHERE t1.industry IS NULL;

SELECT t1.industry, t2.industry 
FROM layoffs_staging_2 t1 JOIN layoffs_staging_2 t2
ON t1.company = t2.company 
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- To UPDATE the NULL industry with the same company another industry value
UPDATE layoffs_staging_2 t1 JOIN layoffs_staging_2 t2
ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_staging_2
WHERE industry IS NULL;

SELECT * FROM layoffs_staging_2;

-- To find the NULL values in the main columns
SELECT * FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- To Delete those columns
DELETE FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_staging_2;

-- To Drop/Delete the row_num column because our data is cleaned 
ALTER TABLE layoffs_staging_2
DROP COLUMN row_num;

-- This the cleaned Data 
SELECT * FROM layoffs_staging_2;