SHOW DATABASES;
USE shoe_brand;
SHOW TABLES;
SELECT * FROM table1;
SELECT * FROM table2;

#####            TABLE.1 QUERRIES####

### Q1. querry to retrieve all shoe names and their corresponding prices for all men's shoe
SELECT shoe_name,price FROM table1 WHERE CATEGORY='Men';
### Q2. query to retrieve the number of different colors available for each category.
SELECT no_of_colors,category FROM table1 WHERE CATEGORY='Men';
SELECT no_of_colors,category FROM table1 WHERE CATEGORY='Women';
### Q3. query to find the most expensive men's shoe.
SELECT MAX(price),CATEGORY FROM TABLE1 WHERE CATEGORY='Men';
### Q4. query to find the cheapest women's shoe in a specific color
SELECT MIN(Price),CATEGORY FROM TABLE1 WHERE CATEGORY='Women' AND NO_OF_COLORS='1';
### Q5. query to retrieve all shoe names and their corresponding prices for men's shoes.


#####              TABLE2 QUERRIES:
SELECT * FROM TABLE2;
### Q1. query that retrieves the count of sizes for all styles.
SELECT COUNT_OF_SIZES,STYLE_CODE FROM TABLE2;
### Q2. query to list all styles with their associated colors.
SELECT COLOR1,COLOR2,COLOR3,COLOR4,COLOR5,STYLE_CODE FROM TABLE2;
### Q3. query to find styles that have more than one color.
SELECT STYLE_CODE,COLOR1,COLOR2,COLOR3,COLOR4,COLOR5 FROM TABLE2 WHERE COLOR2 !='-';
### Q4. query to find the count of sizes available for each color for a specific style code.
SELECT COUNT_OF_SIZES,COLOR1,COLOR2,COLOR3,COLOR4,COLOR5 FROM table2 WHERE STYLE_CODE='Style: 379068_04';
### Q5. query to find styles that have a specific color.
SELECT STYLE_CODE FROM TABLE2 WHERE (COLOR2='-' AND COLOR3='-' AND COLOR4='-' AND COLOR5='-'); # ONLY COLOR1 (ONE SPECIFI COLOR PRESENT)
SELECT STYLE_CODE,COLOR1,COLOR2,COLOR3,COLOR4,COLOR5 FROM TABLE2 WHERE (COLOR2='-' AND COLOR3='-' AND COLOR4='-' AND COLOR5='-');

########                           TABLE3 QUERRIES
SELECT * FROM TABLE3;
### Q1. query calculates the average comfort rating for a specific product based on its reviews.
SELECT AVG(star_rating) FROM TABLE3 FULL JOIN TABLE2 ON TABLE3.SL_NO = TABLE2.SL_NO WHERE STYLE_CODE='Style: 379068_04';  ##
### Q2. query to retrieve products with high star ratings (e.g., 4 stars or above)
SELECT SL_NO,STAR_RATING FROM TABLE3 WHERE STAR_RATING>=4;
### Q3. query that counts the number of reviews for each product.
SELECT COUNT(REVIEWS) FROM TABLE3;                 ##
SELECT SL_NO,REVIEWS FROM TABLE3;
### Q4. To retrieve products that have a quantified durability/quality/performance rating above a certain threshold (e.g., above 7).
SELECT QUALITY FROM TABLE3 WHERE QUALITY >=7; 
### Q5. query that  calculates the average comfort rating for each size.
SELECT AVG(COMFORT) FROM TABLE3 GROUP BY SIZE;                ## COMFORT RATING COLUMN COULD NOT BE SCRAPPED PROPERLY AS ALL THE WEBSITE DOES NOT CONTAINS THIS COLUM
   
 
          ######    JOIN SQL QUERRIES USING 3 TABLES   #####

### Q1.  query finds the top-rated men's shoes along with their sizes from "Table1" and "Table3."
SELECT t1.SL_NO, t1.shoe_name, t3.size
FROM TABLE1 t1
INNER JOIN TABLE3 t3 ON t1.SL_NO = t3.SL_NO
WHERE t1.CATEGORY = 'Men'
AND t3.STAR_RATING >=4;  

### Q2. query calculates the average comfort rating for each category from "Table1" and "Table3."
SELECT t1.CATEGORY, AVG(t3.COMFORT) AS COMFORT_RATING_AVG
FROM TABLE1 t1
INNER JOIN TABLE3 t3 ON t1.SL_NO = t3.SL_NO
GROUP BY t1.CATEGORY;

### Q3. query identifies products with a durability/quality/performance rating higher than the average from "Table1" and "Table3."
SELECT t1.SL_NO, t1.SHOE_NAME
FROM TABLE1 t1
INNER JOIN TABLE3 t3 ON t1.SL_NO = t3.SL_NO
WHERE t3.quality > ( SELECT AVG(quality) FROM TABLE3); 

###Q4. subquery finds products with comfort ratings above the average comfort rating using "Table1" and "Table3."
SELECT t1.SL_NO, t1.SHOE_NAME,t3.COMFORT
FROM TABLE11 t1
INNER JOIN TABLE3 t3 ON t1.SL_NO = t3.SL_NO
WHERE t3.COMFORT > (SELECT AVG(COMFORT) FROM TABLE3);

###Q5.  query joins Table 1  and Table 2  using the "Style code/Product code" column, allowing you to retrieve shoe information along with product details.
SELECT t1.*, t2.*
FROM TABLE1 t1
INNER JOIN TABLE2 t2 ON t1.STYLE_CODE = t2.STYLE_CODE;

SELECT t1.*,t2.* FROM TABLE1 t1 INNER JOIN TABLE2 t2 ON t1.SL_NO=t2.SL_NO;

### Q6.  query that  identifies products with a star rating above the average star rating for their respective size.
SELECT t1.SL_NO, T1.SHOE_NAME, t3.STAR_RATING, t3.SIZE
FROM TABLE1 t1
INNER JOIN TABLE3 t3 ON t1.SL_NO = t3.SL_NO
WHERE t3.STAR_RATING > ( SELECT AVG(t3.STAR_RATING) FROM TABLE3 WHERE TABLE3.size = t3.size);

### Q7. query finds products with the highest comfort rating in each category.
SELECT t1.SL_NO, t1.SHOE_NAME, t1.CATEGORY,t3.COMFORT=MAX(t3.COMFORT)
FROM TABLE1 t1 INNER JOIN TABLE3 t3 
GROUP BY t1.CATEGORY;
    




