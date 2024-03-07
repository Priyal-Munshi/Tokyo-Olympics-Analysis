
-- reading all tables

select * from Athletes_Details
select * from Coaches_Details
select * from Medals_Details
select * from Gender_Details
select * from Team_Details
select * from Continent1
select * from Continent2

-- Avg count of participants across all disciplines

select count(Name) as Total_Participants, Discipline 
from Athletes_Details
group by Discipline 
order by Total_Participants desc

-- Most Medals won by each country, top 3 ranks

SELECT top 3 [Team/NOC], CAST(Total AS INT) AS Total
FROM Medals_Details 
ORDER BY Total DESC;

-- Most Bronze,silver and gold

select top 1 [Team/Noc], 
cast(Gold as int) Gold, 
cast(Silver as int) Silver, 
cast(Bronze as int) Bronze 
from Medals_Details

-- Particpants at across countries

select count([Name]) as Total_Participants, NOC 
from Athletes_Details 
group by NOC 
order by Total_Participants desc

-- Numbers Table, count of various events

SELECT CONCAT('Total Events  :- ', count(distinct Discipline)) AS Total_Events FROM Athletes_Details
union 
SELECT CONCAT('Total Countries  :- ', count(distinct NOC)) AS Total_Events FROM Athletes_Details
union 
SELECT CONCAT('Female Participants  :- ', count(distinct Female)) AS Total_Events FROM Gender_Details
union 
SELECT CONCAT('Male Participants  :- ', count(distinct Male)) AS Total_Events FROM Gender_Details
union 
SELECT CONCAT('Total Participants  :- ', count(distinct Total)) AS Total_Events FROM Gender_Details
union 
SELECT CONCAT('Total Gold Medals  :- ', count(distinct Gold)) AS Total_Events FROM Medals_Details
union 
SELECT CONCAT('Total Silver Medals  :- ', count(distinct Silver)) AS Total_Events FROM Medals_Details
union 
SELECT CONCAT('Total Bronze Medals  :- ', count(distinct Bronze)) AS Total_Events FROM Medals_Details
union 
SELECT CONCAT('Total Medals  :- ', count(distinct Total)) AS Total_Events FROM Medals_Details

-- Coaches produced by the countries

select NOC, count(Name) as Names 
from Coaches_Details 
group by NOC 
order by Names Desc


-- Coaches vs Player Ratio

select athD.NOC, count(distinct athD.[Name]) as Total_Player, 
count(distinct CoaD.[Name]) as Total_Coach, 
(count(distinct athD.[Name])/count(distinct CoaD.[Name])) as Player_Coatch_Ratio
from Athletes_Details as athD 
join Coaches_Details as CoaD
on athD.NOC = CoaD.NOC
group by athD.NOC
order by Total_Player DESC;

-----------------------------or--------------------------------

SELECT
    coach_table.NOC,
    Count_of_Players,
    Count_of_Coaches,
    ROUND(Count_of_Players / Count_of_Coaches, 2) AS Player_Coach_Ratio
FROM
    (SELECT COUNT(Name) AS Count_of_Players, NOC
     FROM Athletes_Details
     GROUP BY NOC) AS player_table
JOIN
    (SELECT COUNT(Name) AS Count_of_Coaches, NOC
     FROM Coaches_Details
     GROUP BY NOC) AS coach_table
ON
    player_table.NOC = coach_table.NOC
ORDER BY
    player_table.Count_of_Players DESC;


-- Country wise Performance Table

select count(distinct athd.[Name]) as Total_Player, count(distinct coad.[Name]) as Total_Coach,
coad.NOC, cast(medd.Total as int) as Total_Medals  from Athletes_Details athd 
join Coaches_Details coad
on athd.NOC = coad.NOC
join Medals_Details medd
on coad.NOC = medd.[Team/NOC]
group by coad.NOC, medd.Total
order by Total_Medals desc

-- Sports with Highes female participation

select Discipline, cast(Female as float) as Female_Participants, 
cast(Total as float) as Total_Participants,
round(cast(Female as float)/cast(Total as float),4)*100 as Female_Percent_Participants 
from Gender_Details
group by Discipline, cast(Female as float), cast(Total as float)
order by Female_Percent_Participants desc

-- Sports with Highes male participation

select Discipline, cast(Male as float) as Male_Participants, cast(Total as float) as Total_Participants,
round(cast(Male as float)/cast(Total as float),4)*100 as Male_Percent_Participants 
from Gender_Details
group by Discipline, cast(Male as float), cast(Total as float)
order by Male_Percent_Participants desc

-- Doubt  Player vs coach List

select athD.Name, coaD.Name, coaD.NOC, coaD.Discipline
from Athletes_Details athD 
join Coaches_Details coaD 
on athD.NOC = coaD.NOC 
and athD.Discipline = coaD.Discipline
group by coaD.NOC, coaD.Name, athD.Name, coaD.Discipline
order by coaD.Discipline

-- Teams vs Disciplines

select NOC, count(distinct Discipline) as Discipline 
from Athletes_Details 
group by NOC 
order by count(distinct Discipline) Desc

-- Continent wise breakdown

select distinct teaD.NOC, Continent
from Team_Details teaD 
join Continent1 cont
on teaD.NOC = cont.Country

-- Continent vs count of countries partcipated in the olympics

select Continent, count(country) as No_of_Countries
from Continent1 
group by Continent
order by No_of_Countries desc

-- Continents Performance Table

select Cont1.Continent, count(distinct athD.Name) Total_Players, 
count(distinct coaD.Name) Total_Coaches, 
count(distinct medD.Total) Total_Medals
from Continent1 Cont1 
join Athletes_Details athD on Cont1.Country = athD.NOC
join Coaches_Details coaD on athD.NOC = coaD.NOC
join Medals_Details medD on coaD.NOC = medD.[Team/NOC]
group by Cont1.Continent



