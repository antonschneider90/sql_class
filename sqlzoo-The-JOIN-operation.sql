/* 1 Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER' */

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER'


/* 2 Show id, stadium, team1, team2 for just game 1012 */

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012


/* 3 Modify it to show the player, teamid, stadium and mdate for every German goal. */

SELECT go.player, go.teamid, ga.stadium, ga.mdate
FROM game AS ga JOIN goal AS go ON ga.id=go.matchid
WHERE go.teamid = 'GER'


/* 4 Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%' */

SELECT ga.team1, ga.team2, go.player
FROM game AS ga JOIN goal AS go ON ga.id=go.matchid
WHERE go.player LIKE 'Mario%'


/* 5 Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */

SELECT g.player, g.teamid, e.coach, g.gtime
FROM goal AS g
JOIN eteam AS e ON g.teamid = e.id
WHERE g.gtime<=10


/* 6 List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */

SELECT g.mdate, e.teamname
FROM game AS g
JOIN eteam AS e ON g.team1=e.id
WHERE e.coach = 'Fernando Santos'


/* 7 List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */

SELECT go.player
FROM goal AS go JOIN game AS ga ON ga.id=go.matchid
WHERE ga.stadium = 'National Stadium, Warsaw'


/* 8 Instead show the name of all players who scored a goal against Germany. */

SELECT DISTINCT(go.player)
FROM goal AS go JOIN game AS ga ON go.matchid = ga.id
WHERE (ga.team1='GER' OR ga.team2='GER') AND go.teamid != 'GER'
