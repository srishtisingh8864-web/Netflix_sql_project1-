-- Netflix project


-- Netflix Project
 Drop Table if Exists netflix;
CREATE TABLE netflix (
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(208),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(100),
    description VARCHAR(250)
);

select * from netflix;

select 
      Count(*) as total_content
From netflix;

select 
      *
From netflix;

select 
      Distinct type 
From netflix;

select * from netflix;

-- 15 Business problems

--1. Count the number  of movies vs TV Shows

Select 
      type,
	  count(*) as total_content
From netflix
Group by type

--2. Find the most common ratings for movies and tv shows 
SELECT 
    type,
	rating
From
(
SELECT 
    type,
    rating,
    COUNT(*),
    RANK() over(Partition by type order by count (*) DESC) as ranking
FROM netflix
GROUP BY 1, 2
) as t
Where 
     ranking = 1

--3. List all movies released in a specific year (e.g., 2020)
--- filter 2020
--- movies
Select * from netflix
where
     type = 'Movie'
	 AND
	 release_year = 2020

--4. Find the top 5 countries with the most content on netflix 

SELECT 
    TRIM(unnest(string_to_array(country, ','))) AS country,
    COUNT(show_id) AS total_content 
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--5.Identify the longest movie
select * from netflix
where 
    type = 'Movie'
    AND
    duration = (select max(duration)from netflix)

--6.Find thecontent added in the last 5 years
SELECT 
    *,
    TO_DATE(date_added, 'Month DD, YYYY') AS converted_date
FROM netflix
WHERE 
    TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
	
--7. Find all the movies/Tv Shows by Director "Rajiv Chilaka"
select * from netflix
Where director ILike '%Rajiv Chilaka%'
 
--8 List all Tv shows where they are season's more than 5

SELECT *
FROM netflix
WHERE type = 'TV Show'
AND SPLIT_PART(duration, ' ', 1)::numeric > 5;

--9       

