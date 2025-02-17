
-- Creating database
create database games;

-- Selecting the database
use games;


-- Creating table for raw data
CREATE TABLE raw_vgsales (
    `Rank` INT PRIMARY KEY,
    Name VARCHAR(255),
    Platform VARCHAR(50),
    Year INT,
    Genre VARCHAR(50),
    Publisher VARCHAR(100),
    NA_Sales DECIMAL(6,2),
    EU_Sales DECIMAL(6,2),
    JP_Sales DECIMAL(6,2),
    Other_Sales DECIMAL(6,2),
    Global_Sales DECIMAL(6,2)
);

SHOW VARIABLES LIKE 'secure_file_priv';
SET GLOBAL local_infile = 1;

-- uploading the dataset locally
LOAD DATA LOCAL INFILE '/Users/syedmeesumalikazmi/Desktop/vgsales.csv'
INTO TABLE raw_vgsales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- See the table
select * from raw_vgsales;

-- 1. Platform Table
CREATE TABLE platforms (
    platform_id INT AUTO_INCREMENT PRIMARY KEY,
    platform_name VARCHAR(50) UNIQUE
);


-- 2. Genre Table
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) UNIQUE
);


-- 3. Publisher Table
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100) UNIQUE
);


-- 4. Games Table
CREATE TABLE games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    year INT,
    platform_id INT,
    genre_id INT,
    publisher_id INT,
    FOREIGN KEY (platform_id) REFERENCES platforms(platform_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);


-- 5. Sales Table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT,
    NA_Sales DECIMAL(6,2),
    EU_Sales DECIMAL(6,2),
    JP_Sales DECIMAL(6,2),
    Other_Sales DECIMAL(6,2),
    Global_Sales DECIMAL(6,2),
    FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE
);


-- Populating the tables and applying Normalization

INSERT INTO platforms (platform_name)
SELECT DISTINCT Platform FROM raw_vgsales;

INSERT INTO genres (genre_name)
SELECT DISTINCT Genre FROM raw_vgsales;

INSERT INTO publishers (publisher_name)
SELECT DISTINCT Publisher FROM raw_vgsales;

INSERT INTO games (name, year, platform_id, genre_id, publisher_id)
SELECT rv.Name, rv.Year, p.platform_id, g.genre_id, pub.publisher_id
FROM raw_vgsales rv
JOIN platforms p ON rv.Platform = p.platform_name
JOIN genres g ON rv.Genre = g.genre_name
JOIN publishers pub ON rv.Publisher = pub.publisher_name;

INSERT INTO sales (game_id, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales)
SELECT g.game_id, rv.NA_Sales, rv.EU_Sales, rv.JP_Sales, rv.Other_Sales, rv.Global_Sales
FROM raw_vgsales rv
JOIN games g ON rv.Name = g.name AND rv.Year = g.year;




-- Top 10 Selling games of all time
SELECT g.name, SUM(s.Global_Sales) AS total_sales
FROM sales s
JOIN games g ON s.game_id = g.game_id
GROUP BY g.name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 5 best selling genre
SELECT gen.genre_name, SUM(s.Global_Sales) AS total_sales
FROM sales s
JOIN games g ON s.game_id = g.game_id
JOIN genres gen ON g.genre_id = gen.genre_id
GROUP BY gen.genre_name
ORDER BY total_sales DESC
LIMIT 5;


-- Platforms with highest total sales
SELECT p.platform_name, SUM(s.Global_Sales) AS total_sales
FROM sales s
JOIN games g ON s.game_id = g.game_id
JOIN platforms p ON g.platform_id = p.platform_id
GROUP BY p.platform_name
ORDER BY total_sales DESC
LIMIT 5;


-- Publisher with most games sold
SELECT pub.publisher_name, SUM(s.Global_Sales) AS total_sales
FROM sales s
JOIN games g ON s.game_id = g.game_id
JOIN publishers pub ON g.publisher_id = pub.publisher_id
GROUP BY pub.publisher_name
ORDER BY total_sales DESC
LIMIT 5;


-- Genre Popularity by region
SELECT gen.genre_name, 
       SUM(s.NA_Sales) AS North_America, 
       SUM(s.EU_Sales) AS Europe, 
       SUM(s.JP_Sales) AS Japan
FROM sales s
JOIN games g ON s.game_id = g.game_id
JOIN genres gen ON g.genre_id = gen.genre_id
GROUP BY gen.genre_name
ORDER BY North_America DESC, Europe DESC, Japan DESC
LIMIT 5;


-- Publisher most sales each region
SELECT pub.publisher_name, 
       SUM(s.NA_Sales) AS North_America, 
       SUM(s.EU_Sales) AS Europe, 
       SUM(s.JP_Sales) AS Japan
FROM sales s
JOIN games g ON s.game_id = g.game_id
JOIN publishers pub ON g.publisher_id = pub.publisher_id
GROUP BY pub.publisher_name
ORDER BY North_America DESC, Europe DESC, Japan DESC
LIMIT 5;






