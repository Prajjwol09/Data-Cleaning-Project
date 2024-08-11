-- DEALING WITH NULL VALUES

SELECT * 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';


SELECT * 
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT *
FROM layoffs_staging2 table1
JOIN layoffs_staging2 table2
	ON table1.company = table2.company
WHERE table1.industry IS NULL AND table2.industry IS NOT NULL;


UPDATE layoffs_staging2 table1
JOIN layoffs_staging2 table2
	ON table1.company = table2.company
SET table1.industry = table2.industry
WHERE table1.industry IS NULL AND table2.industry IS NOT NULL;