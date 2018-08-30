;
WITH [DATA]
AS(
SELECT 
				[A1].[TEAM],
				[A1].[DATE],
				RIGHT([A1].[OPPONENT],3) AS [OPPONENT],
				[A1].[PTS],
				[A1].[FG%],
				[A1].[3P%],
				[A1].[FT%],
				[A1].[OREB],
				[A1].[DREB],
				[A1].[AST],
				[A1].[STL],
				[A1].[BLK],
				[A1].[TOV],
				CASE
								WHEN [A1].[OUTCOME]='W' THEN 'WIN' 
								WHEN [A1].[OUTCOME]='L' THEN 'LOSS' 
				END AS [OUTCOME]
FROM 
				[NDW3NFDB].[DBO].[SSIS_TESTING] AS [A1]
				WITH (NOLOCK)
),
[TEAM_MAP]
AS(
SELECT DISTINCT 
				[OPPONENT],
				CASE				
								WHEN [OPPONENT]='ATL' THEN 'Atlanta Hawks'
								WHEN [OPPONENT]='BKN' THEN 'Brooklyn Nets'
								WHEN [OPPONENT]='BOS' THEN 'Boston Celtics'
								WHEN [OPPONENT]='CHA' THEN 'Charlotte Hornets'
								WHEN [OPPONENT]='CHI' THEN 'Chicago Bulls'
								WHEN [OPPONENT]='CLE' THEN 'Cleveland Cavaliers'
								WHEN [OPPONENT]='DAL' THEN 'Dallas Mavericks'
								WHEN [OPPONENT]='DEN' THEN 'Denver Nuggets'
								WHEN [OPPONENT]='DET' THEN 'Detroit Pistons'
								WHEN [OPPONENT]='GSW' THEN 'Golden State Warriors'
								WHEN [OPPONENT]='HOU' THEN 'Houston Rockets'
								WHEN [OPPONENT]='IND' THEN 'Indiana Pacers'
								WHEN [OPPONENT]='LAC' THEN 'Los Angeles Clippers'
								WHEN [OPPONENT]='LAL' THEN 'Los Angeles Lakers'
								WHEN [OPPONENT]='MEM' THEN 'Memphis Grizzlies '
								WHEN [OPPONENT]='MIA' THEN 'Miami Heat'
								WHEN [OPPONENT]='MIL' THEN 'Milwaukee Bucks'
								WHEN [OPPONENT]='MIN' THEN 'Minnesota Timberwolves'
								WHEN [OPPONENT]='NOP' THEN 'New Orleans Pelicans'
								WHEN [OPPONENT]='NYK' THEN 'New York Knicks'
								WHEN [OPPONENT]='OKC' THEN 'Oklahoma City Thunder'
								WHEN [OPPONENT]='ORL' THEN 'Orlando Magic'
								WHEN [OPPONENT]='PHI' THEN 'Philadelphia 76ers'
								WHEN [OPPONENT]='PHX' THEN 'Phoenix Suns'
								WHEN [OPPONENT]='POR' THEN 'Portland Trail Blazers'
								WHEN [OPPONENT]='SAC' THEN 'Sacramento Kings'
								WHEN [OPPONENT]='SAS' THEN 'San Antonio Spurs'
								WHEN [OPPONENT]='TOR' THEN 'Toronto Raptors'
								WHEN [OPPONENT]='UTA' THEN 'Utah Jazz'
								WHEN [OPPONENT]='WAS' THEN 'Washington Wizards'
				END AS [TEAM_NAME]
FROM 
				[DATA]
UNION ALL
SELECT 'CLE' AS [OPPONENT], 'Cleveland Cavaliers' AS [TEAM_NAME]
)
SELECT 
				[T2].[TEAM_NAME] AS [TEAM],
				[D1].[DATE],
				[T1].[TEAM_NAME] AS [OPPONENT],
				[D1].[PTS],
				[D1].[FG%],
				[D1].[3P%],
				[D1].[FT%],
				[D1].[OREB],
				[D1].[DREB],
				[D1].[AST],
				[D1].[STL],
				[D1].[BLK],
				[D1].[TOV],
				[D1].[OUTCOME]
FROM 
				[DATA] AS [D1]
LEFT OUTER JOIN
				[TEAM_MAP] AS [T1]
ON
				[D1].[OPPONENT]=[T1].[OPPONENT]
LEFT OUTER JOIN
				[TEAM_MAP] AS [T2]
ON
				[D1].[TEAM]=[T2].[OPPONENT]