
###Deep Analysis WCT20 2024 Qualified player's previous World cup and IPL'24 until 8th May
### WorldCup T20 Stats ###
-- #### BATTING PERFORMANCE ###
-- # Leading run scorer in the T20 world cup so far (Top 3 Batsman)
SELECT b.Player_Name, w.Country, b.runs, b.HS, b.Ave, b.SR, b.`100`, b.`50`
FROM batting_wc b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
ORDER BY runs DESC
LIMIT 3;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # Batsman with highest average 
SELECT b.Player_Name, b.ave AS Average 
FROM batting_wc b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
ORDER BY b.ave DESC
LIMIT 3;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # Batsman with highest strike rate (Min. 7 innings)
SELECT b.Player_Name, b.SR AS Strike_Rate 
FROM batting_wc b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
WHERE Inns >= 7
ORDER BY b.SR DESC 
LIMIT 5;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- #### BOWLING PERFORMANCE ###
-- # Leading wicket Taker
SELECT b.Player_Name, b.Wkts AS Wickets, b.Econ AS Economy_Rate
FROM bowling_wc b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
ORDER BY Wickets DESC
LIMIT 10;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # Best Economic Bowlers (Min. 7 matches)
SELECT b.Player_Name, b.Team_Name, b.Econ AS Economy_Rate, b.Wkts AS Wickets
FROM bowling_wc b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
WHERE Inns >= 7
ORDER BY b.Econ ASC
LIMIT 10;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # Most Expensive Bowlers
SELECT b.Player_Name, b.Team_Name, b.Econ AS Economy_Rate, b.Wkts AS Wickets
FROM bowling_wc b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
WHERE Inns >= 7
ORDER BY b.Econ DESC
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # Most Stumpings 
SELECT wk.Player_Name, wk.Team_Name, wk.st
FROM wc_wk AS wk
JOIN wc_qualifiers w ON wk.Player_Name = w.Player_Name
ORDER BY St DESC
LIMIT 4;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- # Most Catches by wicketkeeper
SELECT wk.Player_Name, wk.Team_Name, wk.ct
FROM wc_wk AS wk
JOIN wc_qualifiers w ON wk.Player_Name = w.Player_Name
ORDER BY wk.ct DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
###IPL 2024 Stats
-- # Batsman with highest runs in IPL
SELECT b.Player_Name, w.Country, b.runs, b.HS, b.Ave, b.SR, b.`100`, b.`50`
FROM batting_ipl b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
ORDER BY runs DESC
LIMIT 3;

-- # Batsman with highest average in IPL
SELECT b.Player_Name, b.ave AS Average 
FROM batting_ipl b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
ORDER BY b.ave DESC
LIMIT 3;

-- # Batsman with highest strike rate in IPL (Min. 7 innings)
SELECT b.Player_Name, b.SR AS Strike_Rate 
FROM batting_ipl b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
WHERE Inns >= 7
ORDER BY b.SR DESC 
LIMIT 5;

-- # Leading wicket taker in IPL
SELECT b.Player_Name, b.Wkts AS Wickets, b.Econ AS Economy_Rate
FROM bowling_ipl b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
ORDER BY Wickets DESC
LIMIT 10;

-- # Best Economic Bowlers in IPL (Min. 7 matches)
SELECT b.Player_Name, b.IPL_Team_Name, b.Econ AS Economy_Rate, b.Wkts AS Wickets
FROM bowling_ipl b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
WHERE Inns >= 7
ORDER BY b.Econ ASC
LIMIT 10;

-- # Most Expensive Bowlers in IPL
SELECT b.Player_Name, b.IPL_Team_Name, w.country, b.Econ AS Economy_Rate, b.Wkts AS Wickets
FROM bowling_ipl b
JOIN wc_qualifiers w ON b.Player_Name = w.Player_Name
WHERE Inns >= 7
ORDER BY b.Econ DESC
LIMIT 10;

-- # Most Stumpings in IPL
SELECT wk.Player_Name, w.country, wk.IPL_Team_Name, wk.st AS Stumpings
FROM wk_ipl AS wk
JOIN wc_qualifiers w ON wk.Player_Name = w.Player_Name
WHERE st >= 1
ORDER BY St DESC;

-- # Most Catches by wicketkeeper in IPL
SELECT wk.Player_Name, w.country, wk.IPL_Team_Name, wk.ct AS Catches
FROM wk_ipl AS wk
JOIN wc_qualifiers w ON wk.Player_Name = w.Player_Name
ORDER BY wk.ct DESC;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--## Overall Top Performance in past WCT20s and IPL_2024(Combined) 
SELECT 
    Player_Name, 
    Country, 
    ROUND(SUM(runs), 2) AS Total_Runs, 
    MAX(HS) AS Highest_Score, 
    ROUND(AVG(Ave), 2) AS Average, 
    ROUND(AVG(SR), 2) AS Strike_Rate, 
    SUM(`100`) AS Centuries, 
    SUM(`50`) AS Half_Centuries
FROM (
    SELECT 
        b.Player_Name, 
        w.Country, 
        b.runs, 
        b.HS, 
        b.Ave, 
        b.SR, 
        b.`100`, 
        b.`50`
    FROM 
        batting_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    UNION ALL
    SELECT 
        b.Player_Name, 
        w.Country, 
        b.runs, 
        b.HS, 
        b.Ave, 
        b.SR, 
        b.`100`, 
        b.`50`
    FROM 
        batting_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
) AS combined_results
GROUP BY 
    Player_Name, 
    Country
ORDER BY 
    Total_Runs DESC
LIMIT 
    6;
    
--### Overall Highest Average
SELECT 
    Player_Name,
    Team_Name, 
    Sum(Matches) as Total_Matches,
    sum(Innings) as Total_Innings,
    AVG(Average) AS Average
FROM (
    -- Query for batting performance in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.Country as Team_Name,
         b.Mat as Matches,
        b.Inns as Innings,
        b.ave AS Average 
    FROM 
        batting_wc b 
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name

    UNION ALL

    -- Query for batting performance in IPL
    SELECT 
       b.Player_Name, 
        w.Country as Team_Name,
        b.Mat as Matches,
        b.Inns as Innings,
        b.ave AS Average 
    FROM 
        batting_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
) AS combined_results
GROUP BY 
    Player_Name, Team_Name
ORDER BY 
    Average DESC
LIMIT 
    10;


--- Overall Highest Strike rate
SELECT 
    Player_Name,
    Team_Name, 
    sum(Innings) as Total_Innings, 
    AVG(Strike_Rate) AS Average_Strike_Rate
FROM (
    -- Query for batting performance in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
        b.Inns as Innings,
        b.SR AS Strike_Rate 
    FROM 
        batting_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    
    UNION ALL
    
    -- Query for batting performance in IPL
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
		b.Inns as Innings,
        b.SR AS Strike_Rate
       
    FROM 
        batting_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
        where b.Inns >=5
) AS combined_results
GROUP BY 
    Player_Name, 
    Team_Name,
    Innings
ORDER BY 
    Average_Strike_Rate DESC 
LIMIT 
    10;


-- Overall Most Wickets
SELECT Player_Name, Team_Name, SUM(Innings) as Total_Innings, SUM(Wickets) AS Total_Wickets, ROUND(AVG(Economy_Rate),1) AS Average_Economy_Rate
FROM (
    -- Query for leading wicket takers in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
        b.inns as Innings,
        b.Wkts AS Wickets, 
        b.Econ AS Economy_Rate
    FROM 
        bowling_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    
    UNION ALL
    
  ##leading wicket takers in IPL
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
        b.inns as Innings,
        b.Wkts AS Wickets, 
        b.Econ AS Economy_Rate
    FROM 
        bowling_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
) AS combined_results
GROUP BY 
    Player_Name,
    Team_Name
ORDER BY 
    Total_Wickets DESC
LIMIT 
    10;

-- Overall Best Economy
SELECT 
    Player_Name,
    Team_Name, 
    SUM(Innings) AS Total_Innings,
    ROUND(AVG(Economy_Rate), 2) AS Average_Economy_Rate, 
    SUM(Wickets) AS Total_Wickets
FROM (
    -- Query for best economic bowlers in T20 World Cup
    SELECT 
        b.Player_Name,
        b.Inns AS Innings,
        w.country as Team_Name,
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5
    
    UNION ALL
    
    -- Query for best economic bowlers in IPL
    SELECT 
        b.Player_Name, 
		b.Inns AS Innings,
         w.country as Team_Name, 
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5
) AS combined_results
GROUP BY 
    Player_Name, 
    Team_Name
ORDER BY 
    Average_Economy_Rate ASC
LIMIT 
    10;

---## Overall Most Expensive Bowlers
-- Joining and adding data from both queries
SELECT 
    Player_Name, 
    Team_Name, 
    sum(Innings) as Innings,
    ROUND(AVG(Economy_Rate),2) as Economy_Rate,
    Sum(Wickets) as Total_Wickets
FROM (
    -- Query for most expensive bowlers in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.country as Team_Name, 
        b.inns as Innings,
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5
    
    UNION ALL
    
    -- Query for most expensive bowlers in IPL
    SELECT 
        b.Player_Name, 
        w.country as Team_Name, 
        b.inns as Innings,
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5
) AS combined_results
GROUP BY 
Player_name, Team_Name
ORDER BY 
    Economy_Rate DESC
LIMIT 
    10;


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
##Facts to Know

- ###People who featured 2007 WCT20 also featuring 2024 WCT20
WITH cte AS (
    SELECT bt.Player_Name, bt.Team_Name, bt.From_year
    FROM batting_wc bt
    LEFT JOIN bowling_wc bw ON bt.Player_Name = bw.Player_name
)
SELECT w.Player_Name, cte.Team_Name, cte.From_year
FROM cte
JOIN wc_qualifiers w ON w.Player_Name = cte.Player_Name
WHERE cte.From_year = '2007';

### the oldest T20 players based on their participation in the World Cup
WITH cte AS (
    SELECT bt.Player_Name, bt.Team_Name, bt.From_year
    FROM batting_wc bt
    LEFT JOIN bowling_wc bw ON bt.Player_Name = bw.Player_name
)
SELECT w.Player_Name, cte.Team_Name, cte.From_year as First_World_Cup
FROM cte
JOIN wc_qualifiers w ON w.Player_Name = cte.Player_Name
ORDER BY cte.From_year ASC;

- ##Player who are qualified but they didn’t play an innings/appear in IPL 2024 but in featured in past WCT20
SELECT WC.Player_Name, WC.Team_Name
FROM
  (SELECT bt.Player_Name, bt.Team_Name
    FROM batting_wc bt
    LEFT JOIN bowling_wc bw ON bt.Player_Name = bw.Player_name) as WC
JOIN
  (SELECT *
    FROM wc_qualifiers) as WCQ ON WC.Player_Name = WCQ.Player_Name
LEFT JOIN
  (SELECT bt.Player_Name, bt.IPL_Team_Name
    FROM batting_ipl bt
    LEFT JOIN bowling_ipl bw ON bt.Player_Name = bw.Player_name) AS IPL ON WC.Player_Name = IPL.Player_Name
WHERE IPL.Player_Name IS NULL;


- ##Player who are featured/Played an innings in past WCT20, IPL'24 and WCT20'24

 SELECT WC.Player_Name, WC.Team_Name
FROM
  (SELECT Player_Name, Team_Name
FROM batting_wc

UNION

SELECT Player_Name, Team_Name
FROM bowling_wc) as WC

JOIN

 (SELECT Player_Name, IPL_Team_Name
    FROM batting_ipl UNION
    SELECT Player_Name, IPL_Team_Name
    FROM batting_ipl) AS IPL ON WC.Player_Name = IPL.Player_Name
    
JOIN
  (SELECT *
    FROM wc_qualifiers) as WCQ ON WC.Player_Name = WCQ.Player_Name
    
- ##Player who played in IPL but they didn’t selected in the 2024 WCT20. 
SELECT IPL.Player_Name
FROM
  ((SELECT Player_Name, IPL_Team_Name
    FROM batting_ipl
    UNION
    SELECT Player_Name, IPL_Team_Name
    FROM bowling_ipl) AS IPL
LEFT JOIN
  (SELECT *
    FROM wc_qualifiers) AS WCQ ON IPL.Player_Name = WCQ.Player_Name)
WHERE IPL.Player_Name NOT IN 
  (SELECT Player_Name
   FROM wc_qualifiers);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
####INDIA's Overall Performance in WCT20s and IPL_2024############
-- Overall Top Performance in past WCT20s and IPL_2024
SELECT 
    Player_Name, 
    Country, 
    ROUND(SUM(runs), 2) AS Total_Runs, 
    MAX(HS) AS Highest_Score, 
    ROUND(AVG(Ave), 2) AS Average, 
    ROUND(AVG(SR), 2) AS Strike_Rate, 
    SUM(`100`) AS Centuries, 
    SUM(`50`) AS Half_Centuries
FROM (
    SELECT 
        b.Player_Name, 
        w.Country, 
        b.runs, 
        b.HS, 
        b.Ave, 
        b.SR, 
        b.`100`, 
        b.`50`
    FROM 
        batting_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'
    UNION ALL
    SELECT 
        b.Player_Name, 
        w.Country, 
        b.runs, 
        b.HS, 
        b.Ave, 
        b.SR, 
        b.`100`, 
        b.`50`
    FROM 
        batting_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'
) AS combined_results
GROUP BY 
    Player_Name, 
    Country
ORDER BY 
    Total_Runs DESC
LIMIT 
    6;

-- Overall Highest Average
SELECT 
    Player_Name,
    Team_Name, 
    Sum(Matches) as Total_Matches,
    sum(Innings) as Total_Innings,
    AVG(Average) AS Average
FROM (
    -- Query for batting performance in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.Country as Team_Name,
         b.Mat as Matches,
        b.Inns as Innings,
        b.ave AS Average 
    FROM 
        batting_wc b 
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'

    UNION ALL

    -- Query for batting performance in IPL
    SELECT 
       b.Player_Name, 
        w.Country as Team_Name,
        b.Mat as Matches,
        b.Inns as Innings,
        b.ave AS Average 
    FROM 
        batting_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'
) AS combined_results
GROUP BY 
    Player_Name, Team_Name
ORDER BY 
    Average DESC
LIMIT 
    10;

--- Overall Highest Strike rate
SELECT 
    Player_Name,
    Team_Name, 
    sum(Innings) as Total_Innings, 
    AVG(Strike_Rate) AS Average_Strike_Rate
FROM (
    -- Query for batting performance in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
        b.Inns as Innings,
        b.SR AS Strike_Rate 
    FROM 
        batting_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'
    
    UNION ALL
    
    -- Query for batting performance in IPL
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
		b.Inns as Innings,
        b.SR AS Strike_Rate
       
    FROM 
        batting_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND' AND b.Inns >=5
) AS combined_results
GROUP BY 
    Player_Name, 
    Team_Name,
    Innings
ORDER BY 
    Average_Strike_Rate DESC 
LIMIT 
    10;

-- Overall Most Wickets
SELECT Player_Name, Team_Name, SUM(Innings) as Total_Innings, SUM(Wickets) AS Total_Wickets, ROUND(AVG(Economy_Rate),1) AS Average_Economy_Rate
FROM (
    -- Query for leading wicket takers in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
        b.inns as Innings,
        b.Wkts AS Wickets, 
        b.Econ AS Economy_Rate
    FROM 
        bowling_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'
    
    UNION ALL
    
  -- Query for leading wicket takers in IPL
    SELECT 
        b.Player_Name, 
        w.country as Team_Name,
        b.inns as Innings,
        b.Wkts AS Wickets, 
        b.Econ AS Economy_Rate
    FROM 
        bowling_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE
        w.Country = 'IND'
) AS combined_results
GROUP BY 
    Player_Name,
    Team_Name
ORDER BY 
    Total_Wickets DESC
LIMIT 
    10;

-- Overall Best Economy
SELECT 
    Player_Name,
    Team_Name, 
    SUM(Innings) AS Total_Innings,
    ROUND(AVG(Economy_Rate), 2) AS Average_Economy_Rate, 
    SUM(Wickets) AS Total_Wickets
FROM (
    -- Query for best economic bowlers in T20 World Cup
    SELECT 
        b.Player_Name,
        b.Inns AS Innings,
        w.country as Team_Name,
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5 AND w.Country = 'IND'
    
    UNION ALL
    
    -- Query for best economic bowlers in IPL
    SELECT 
        b.Player_Name, 
		b.Inns AS Innings,
         w.country as Team_Name, 
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5 AND w.Country = 'IND'
) AS combined_results
GROUP BY 
    Player_Name, 
    Team_Name
ORDER BY 
    Average_Economy_Rate ASC
LIMIT 
    10;

---## Overall Most Expensive Bowlers
-- Joining and adding data from both queries
SELECT 
    Player_Name, 
    Team_Name, 
    sum(Innings) as Innings,
    ROUND(AVG(Economy_Rate),2) as Economy_Rate,
    Sum(Wickets) as Total_Wickets
FROM (
    -- Query for most expensive bowlers in T20 World Cup
    SELECT 
        b.Player_Name, 
        w.country as Team_Name, 
        b.inns as Innings,
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_wc b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5 AND w.Country = 'IND'
    
    UNION ALL
    
    -- Query for most expensive bowlers in IPL
    SELECT 
        b.Player_Name, 
        w.country as Team_Name, 
        b.inns as Innings,
        b.Econ AS Economy_Rate, 
        b.Wkts AS Wickets
    FROM 
        bowling_ipl b
    JOIN 
        wc_qualifiers w ON b.Player_Name = w.Player_Name
    WHERE 
        Inns >= 5 AND w.Country = 'IND'
) AS combined_results
GROUP BY 
    Player_name, Team_Name
ORDER BY 
    Economy_Rate DESC
LIMIT 
    10;
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##### Playing XI for India for WCT20 based on performance in IPL'24 and Worldcup Experience ########
SELECT DISTINCT Player_Name FROM (
    -- Query 1: Top 2 players by Total Runs
    SELECT Player_Name FROM (
        SELECT 
            Player_Name, 
            Country, 
            ROUND(SUM(runs), 2) AS Total_Runs, 
            ROW_NUMBER() OVER (ORDER BY SUM(runs) DESC) AS rn
        FROM (
            SELECT 
                b.Player_Name, 
                w.Country, 
                b.runs
            FROM 
                batting_wc b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
            UNION ALL
            SELECT 
                b.Player_Name, 
                w.Country, 
                b.runs
            FROM 
                batting_ipl b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
        ) AS combined_results
        GROUP BY 
            Player_Name, 
            Country
    ) AS top_runs
    WHERE rn <= 3

    UNION ALL

    -- Query 2: Top 2 players by Overall Highest Average
    SELECT Player_Name FROM (
        SELECT 
            Player_Name,
            AVG(Average) AS Average,
            ROW_NUMBER() OVER (ORDER BY AVG(Average) DESC) AS rn
        FROM (
            SELECT 
                b.Player_Name, 
                b.ave AS Average 
            FROM 
                batting_wc b 
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
            UNION ALL
            SELECT 
                b.Player_Name, 
                b.ave AS Average 
            FROM 
                batting_ipl b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
        ) AS combined_results
        GROUP BY 
            Player_Name
    ) AS top_average
    WHERE rn <= 3

    UNION ALL

    -- Query 3: Top 2 players by Overall Highest Strike rate
    SELECT Player_Name FROM (
        SELECT 
            Player_Name,
            AVG(Strike_Rate) AS Average_Strike_Rate,
            ROW_NUMBER() OVER (ORDER BY AVG(Strike_Rate) DESC) AS rn
        FROM (
            SELECT 
                b.Player_Name, 
                b.SR AS Strike_Rate 
            FROM 
                batting_wc b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
            UNION ALL
            SELECT 
                b.Player_Name, 
                b.SR AS Strike_Rate
            FROM 
                batting_ipl b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND' AND b.Inns >=5
        ) AS combined_results
        GROUP BY 
            Player_Name
    ) AS top_strike_rate
    WHERE rn <= 6

    UNION ALL

    -- Query 4: Top 2 players by Overall Most Wickets
    SELECT Player_Name FROM (
        SELECT 
            Player_Name, 
            SUM(Wickets) AS Total_Wickets,
            ROW_NUMBER() OVER (ORDER BY SUM(Wickets) DESC) AS rn
        FROM (
            SELECT 
                b.Player_Name, 
                b.Wkts AS Wickets
            FROM 
                bowling_wc b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
            UNION ALL
            SELECT 
                b.Player_Name, 
                b.Wkts AS Wickets
            FROM 
                bowling_ipl b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE
                w.Country = 'IND'
        ) AS combined_results
        GROUP BY 
            Player_Name
    ) AS top_wickets
    WHERE rn <= 4

    UNION ALL

    -- Query 5: Top 2 players by Overall Best Economy
    SELECT Player_Name FROM (
        SELECT 
            Player_Name, 
            ROUND(AVG(Economy_Rate), 2) AS Average_Economy_Rate, 
            ROW_NUMBER() OVER (ORDER BY AVG(Economy_Rate) ASC) AS rn
        FROM (
            SELECT 
                b.Player_Name, 
                b.Econ AS Economy_Rate
            FROM 
                bowling_wc b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE 
                Inns >= 5 AND w.Country = 'IND'
            UNION ALL
            SELECT 
                b.Player_Name, 
                b.Econ AS Economy_Rate
            FROM 
                bowling_ipl b
            JOIN 
                wc_qualifiers w ON b.Player_Name = w.Player_Name
            WHERE 
                Inns >= 5 AND w.Country = 'IND'
        ) AS combined_results
        GROUP BY 
            Player_Name
    ) AS top_economy
    WHERE rn <= 4
) AS combined_results;


