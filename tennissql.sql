SELECT * FROM acme.tennis;

-- Find the number of Grand Slam Titles for each player --

CREATE TABLE Win_table AS (
SELECT Winner, COUNT(Winner) AS win_count
FROM tennis GROUP BY Winner
ORDER BY win_count DESC
);

-- Find number of second place finishes for each player --

CREATE TABLE second_table AS (
SELECT Runner_up, COUNT(Runner_up) AS second_count
FROM tennis GROUP BY Runner_up
ORDER BY second_count DESC
);

-- Create a table to compare wins vs losses in finals for each player --

CREATE TABLE win_loss_table AS (
SELECT
  win_table.Winner as player_name,
  win_table.win_count,
  second_table.second_count
FROM second_table
JOIN win_table ON win_table.Winner=second_table.Runner_up
ORDER BY win_count DESC
);

-- Find the win rate in Grand Slam finals for each player -- 

SELECT  player_name, (win_count/(win_count + second_count))*100
AS win_percent
FROM win_loss_table;