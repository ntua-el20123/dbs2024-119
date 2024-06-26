


/* QUERY NO 1  (CHECKED, IT WORKS) */ 

SELECT chef_id, cousine_name, AVG(total_score) AS average_score
FROM (
    SELECT chef_id, cousine_name, (score_1 + score_2 + score_3) AS total_score
    FROM scores
) AS score_totals
GROUP BY chef_id, cousine_name;

/* EXPECTED OUTPUT FOR MY DATA:
    1/Italian/11.5
    1/Greek/11.5
    2/Greek/8
*/


/* QUERY NO 2 (CHECKED, IT WORKS) */

( SELECT DISTINCT specializes_in.cousine_name AS cousine, chefs_that_took_part.chef_id AS chef_id, chefs_that_took_part.season_number AS season, 'yes' AS took_part
  FROM specializes_in JOIN ( ( SELECT chef_id, episode_number, season_number
                               FROM judge_in_episode
                               )
                             UNION
                             ( SELECT chef_id, episode_number, season_number
                               FROM scores
                               )
						  ) AS chefs_that_took_part
                          ON specializes_in.chef_id=chefs_that_took_part.chef_id
)
UNION
( SELECT DISTINCT cousine, chef_id, season, 'no' AS took_part
  FROM ( SELECT DISTINCT specializes_in.cousine_name AS cousine, specializes_in.chef_id AS chef_id, all_the_seasons.season_number AS season
         FROM (specializes_in, (SELECT DISTINCT season_number FROM episode) AS all_the_seasons )
         EXCEPT 
         ( ( SELECT specializes_in.cousine_name AS cousine, judge_in_episode.chef_id AS chef_id, judge_in_episode.season_number AS season
			 FROM specializes_in JOIN judge_in_episode ON specializes_in.chef_id=judge_in_episode.chef_id
            ) 
            UNION
			( SELECT specializes_in.cousine_name AS cousine, scores.chef_id AS chef_id, scores.season_number AS season
              FROM specializes_in JOIN scores ON specializes_in.chef_id=scores.chef_id
             )
		   )
         ) AS k 
 )
;
 
 /* EXPECTED OUTPUT:
Greek	1	1	yes
Greek	2	1	yes
Indian	3	2	yes
Italian	1	1	yes
Italian	2	1	yes
Indian	3	1	no
Italian	2	2	no
Italian	1	2	no
Greek	2	2	no
Greek	1	2	no
Italian	2	3	no
Italian	1	3	no
Indian	3	3	no
Greek	2	3	no
Greek	1	3	no
*/
    



/* QUERY NO 3    (CHECKED, IT WORKS)*/  

WITH k AS (
SELECT chef_id, COUNT(*) AS number_of_recipes
FROM chef NATURAL JOIN cook_has_recipe
WHERE age<30
GROUP BY chef_id
)
SELECT *
FROM k
WHERE number_of_recipes = ( SELECT MAX(number_of_recipes)
							FROM k
                            )
;

 /* EXPECTED OUTPUT:
    4/3
    5/3
/*


/* QUERY NO 4 (CHECKED, IT WORKS) */

SELECT chef_id
FROM chef
WHERE chef_id NOT IN ( SELECT chef_id
                       FROM judge_in_episode
                       )
;

/* EXPECTED OUTPUT:
   1, 2, 4, 5
*/



/* QUERY NO 5 (CHECKED, IT WORKS) need work*/

WITH j AS (
    SELECT chef_id, season_number, COUNT(*) AS times_as_judge
    FROM judge_in_episode
    GROUP BY chef_id, season_number
)
SELECT j1.chef_id AS judge_1,
       j2.chef_id AS judge_2,
       j1.times_as_judge AS number_of_episodes,
       j1.season_number AS in_season
FROM j AS j1
JOIN j AS j2
ON j1.times_as_judge = j2.times_as_judge 
    AND j1.season_number = j2.season_number
    AND j1.chef_id <> j2.chef_id  
WHERE j1.times_as_judge >= 3
; 


/* EXPECTED OUTPUT:
   6/7/4/2
   6/7/3/1
   5/7/3/1
   5/6/3/1
   and all the vice versa
*/


/* QUERY NO 6 */

WITH tag_pairs AS (
    SELECT t1.recipe_id, t1.tag_name AS tag1, t2.tag_name AS tag2
        FROM recipe_has_tag t1
        JOIN recipe_has_tag t2 ON t1.recipe_id = t2.recipe_id
        WHERE t1.tag_name < t2.tag_name
    ),
tag_pair_episodes AS (
    SELECT tp.tag1, tp.tag2, COUNT(*) AS pair_count
        FROM tag_pairs tp
        JOIN scores s ON tp.recipe_id = s.recipe_id
        GROUP BY tp.tag1, tp.tag2
)
SELECT tag1, tag2, pair_count
    FROM tag_pair_episodes
    ORDER BY pair_count DESC
    LIMIT 3;


/* QUERY NO 7 (CHECKED, IT WORKS)*/

WITH k AS (
SELECT chef_id, COUNT(*) AS times_in_episode
FROM ((SELECT chef_id FROM judge_in_episode) UNION ALL (SELECT chef_id FROM scores)) AS l
GROUP BY chef_id
)
SELECT *
FROM k
WHERE times_in_episode+5 <= ( SELECT DISTINCT MAX(times_in_episode) 
							  FROM k
                              )
;

/* EXPECTED OUTPUT:
   3/2
   4/3
   2/3
*/



/* QUERY NO 8 (CHECKED, IT WORKS) */

WITH k AS (
	SELECT scores.season_number AS season_number, scores.episode_number AS episode_number, COUNT(*) AS amount_of_equipment_used
	FROM scores, recipe, recipe_has_cooking_equipment
	WHERE scores.recipe_id=recipe.recipe_id AND recipe.recipe_id=recipe_has_cooking_equipment.recipe_id
	GROUP BY scores.season_number, scores.episode_number
)
SELECT * 
FROM k
WHERE amount_of_equipment_used = ( SELECT MAX(amount_of_equipment_used)
								   FROM k
                                   )
;

/* EXPECTED OUTPUT:
   1/1/7
   2/2/7
*/



/* QUERY NO 9 (CHECKED, IT WORKS) */

SELECT scores.season_number, AVG(recipe.carbs_per_serving) AS average_carbs
FROM scores JOIN recipe ON scores.recipe_id=recipe.recipe_id
GROUP BY scores.season_number;

/* EXPECTED OUTPUT:
   1/27.857
   2/30
*/


/* QUERY NO 10 (CHECKED, IT WORKS) needs work*/

WITH cousine_season_appearances AS (
	SELECT cousine.cousine_name AS cousine, scores.season_number AS season, COUNT(*) AS appearances
	FROM scores JOIN cousine ON scores.cousine_name=cousine.cousine_name
	GROUP BY cousine.cousine_name, scores.season_number
	HAVING appearances>=3
) , 
cousine_b2b AS (
	SELECT cousine_season_appearances_one.cousine AS cousine, cousine_season_appearances_one.season AS season1, cousine_season_appearances_two.season AS season2, cousine_season_appearances_one.appearances AS season1_appearances, cousine_season_appearances_two.appearances AS season2_appearances
	FROM cousine_season_appearances AS cousine_season_appearances_one 
		JOIN 
        cousine_season_appearances AS cousine_season_appearances_two 
        ON cousine_season_appearances_one.cousine=cousine_season_appearances_two.cousine
	WHERE cousine_season_appearances_one.season+1=cousine_season_appearances_two.season
)
SELECT cousine_b2b_one.cousine AS cousine_one, cousine_b2b_two.cousine AS cousine_two, cousine_b2b_one.season1 AS season_one, cousine_b2b_one.season2 AS season_two, cousine_b2b_one.season1_appearances AS appearances_cousine_one_season_one, cousine_b2b_one.season2_appearances AS appearances_cousine_one_season_two, cousine_b2b_two.season1_appearances AS appearances_cousine_two_season_one, cousine_b2b_two.season2_appearances AS appearances_cousine_two_season_two
FROM cousine_b2b AS cousine_b2b_one
     JOIN
     cousine_b2b AS cousine_b2b_two
     ON (cousine_b2b_one.season1=cousine_b2b_two.season1 AND cousine_b2b_one.season2=cousine_b2b_two.season2)
WHERE cousine_b2b_one.season1_appearances+cousine_b2b_one.season2_appearances=cousine_b2b_two.season1_appearances+cousine_b2b_two.season2_appearances AND cousine_b2b_one.cousine <> cousine_b2b_two.cousine
;

/* EXPECTED OUTPUT:
   Italian/Greek/1/2/4/3/3/4
   and the opposite combination
*/


WITH judge_chef_score AS (
SELECT judge_in_episode.chef_id AS judge_id,
       scores.chef_id AS player_id,  
       CASE
			WHEN judge_in_episode.judge_number=1 THEN scores.score_1
            WHEN judge_in_episode.judge_number=2 THEN scores.score_2
            ELSE scores.score_3
       END AS score
FROM scores JOIN judge_in_episode 
	 ON scores.season_number=judge_in_episode.season_number AND scores.episode_number=judge_in_episode.episode_number
)
SELECT judge_id, player_id, AVG(score) AS average_of_scores
FROM judge_chef_score
GROUP BY judge_id, player_id
ORDER BY 
    average_of_scores DESC
LIMIT 5;


/* QUERY NO 12 (CHECKED, IT WORKS) */

WITH seasons_and_episodes AS (
	SELECT scores.season_number AS season, scores.episode_number AS episode, SUM(recipe.difficulty) AS total_difficulty
	FROM scores JOIN recipe ON scores.recipe_id=recipe.recipe_id
	GROUP BY scores.season_number, scores.episode_number
)
SELECT only_seasons.season AS season, seasons_and_episodes.episode AS episode, only_seasons.max_total_difficulty_of_season AS episode_total_difficulty
FROM  seasons_and_episodes,
	   ( SELECT season, MAX(total_difficulty) AS max_total_difficulty_of_season
         FROM seasons_and_episodes
         GROUP BY season
         ) AS only_seasons
WHERE (seasons_and_episodes.season=only_seasons.season AND seasons_and_episodes.total_difficulty=only_seasons.max_total_difficulty_of_season)
;

/* EXPECTED OUTPUT:
   1/1/5
   2/2/5
*/



/* QUERY NO 13 (CHECKED, IT WORKS) */

WITH k AS (
	SELECT season_number_common AS season, episode_number_common AS episode, SUM(years_of_work_experience_common) AS total_years_of_experience_in_episode
	FROM ( ( SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
			 FROM scores JOIN chef ON scores.chef_id=chef.chef_id
		   )
		   UNION
		   ( SELECT judge_in_episode.season_number AS season_number_common, judge_in_episode.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
			 FROM judge_in_episode JOIN chef ON judge_in_episode.chef_id=chef.chef_id
		   )
		  ) AS d
	GROUP BY season_number_common, episode_number_common
)
SELECT *
FROM k
WHERE total_years_of_experience_in_episode = ( SELECT MIN(total_years_of_experience_in_episode)
											   FROM k
                                               )
;

/* EXPECTED OUTPUT:
   1/1/17
   1/8/17
*/



/* QUERY NO 14 (CHECKED, IT WORKS) */

WITH k AS (
	SELECT recipe.theme_name AS theme_name, COUNT(*) AS theme_numbers_found
	FROM scores JOIN recipe ON scores.recipe_id=recipe.recipe_id
	GROUP BY recipe.theme_name
)
SELECT theme_name, theme_numbers_found
FROM k
WHERE theme_numbers_found = ( SELECT MAX(theme_numbers_found)
                              FROM k
                              )
;


/* EXPECTED OUTPUT:
   Flaming Hot/4
   Quick and Easy/4
*/



/* QUERY NO 15 (CHECKED, IT WORKS) */

SELECT food_group_id, group_name
FROM food_group
WHERE food_group_id NOT IN ( SELECT ingridient.food_group_id
                             FROM scores, recipe, recipe_has_ingridient, ingridient
                             WHERE scores.recipe_id=recipe.recipe_id AND recipe.recipe_id=recipe_has_ingridient.recipe_id AND recipe_has_ingridient.ingridient_id=ingridient.ingridient_id
                             )
;

/* EXPECTED OUTPUT:
   4/Beverages
*/
