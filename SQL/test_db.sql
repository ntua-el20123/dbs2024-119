/* QUERY NO 1 */

SELECT chef_id, cousine_name, AVG(total_score) AS average_score
FROM (
    SELECT chef_id, cousine_name, (score_1 + score_2 + score_3) AS total_score
    FROM scores
) AS score_totals
GROUP BY chef_id, cousine_name;



/* QUERY NO 3 */

SELECT chef_id, COUNT(*) AS number_of_recipes
FROM chef NATURAL JOIN cook_has_recipe
WHERE age<30
GROUP BY chef_id
HAVING number_of_recipes = ( SELECT MAX(recipe_count)
                             FROM ( SELECT chef_id, COUNT(*) AS recipe_count
                                    FROM chef NATURAL JOIN cook_has_recipe
                                    WHERE age<30
                                    GROUP BY chef_id
								   )
							)
;


/* QUERY NO 4 */

SELECT chef_id
FROM chef
WHERE chef_id NOT IN ( SELECT chef_id
                       FROM judge_in_episode
                       )
;



/* QUERY NO 5 */

SELECT j1.chef_id AS judge_1,
       j2.chef_id AS judge_2,
       j1.times_as_judge AS number_of_episodes,
       j1.season_number AS in_season
FROM (
    SELECT chef_id, season_number, COUNT(*) AS times_as_judge
    FROM judge_in_episode
    GROUP BY chef_id, season_number
) AS j1
JOIN (
    SELECT chef_id, season_number, COUNT(*) AS times_as_judge
    FROM judge_in_episode
    GROUP BY chef_id, season_number
) AS j2
ON j1.times_as_judge = j2.times_as_judge 
    AND j1.season_number = j2.season_number
    AND j1.chef_id <> j2.chef_id  
WHERE j1.times_as_judge >= 3; 


/* QUERY NO 7 */

SELECT chef_id, COUNT(*) AS times_in_episode
FROM ((SELECT chef_id FROM judge_in_episode) UNION ALL (SELECT chef_id FROM scores))
GROUP BY chef_id
HAVING times_in_episode+5 <= ( SELECT DISTINCT MAX(times_in_episode)
                               FROM ( SELECT chef_id, COUNT(*) AS times_in_episode
                                      FROM ((SELECT chef_id FROM judge_in_episode) UNION ALL (SELECT chef_id FROM scores))
                                      GROUP BY chef_id
                                      )
								)
;



/* QUERY NO 9 */

SELECT scores.season_number, AVG(recipe.carbs_per_serving) AS average_carbs
FROM scores JOIN recipe ON scores.recipe_id=recipe.recipe_id
GROUP BY scores.season_number;


/* QUERY NO 13 */

SELECT season_number_common, episode_number_common, SUM(years_of_work_experience_common) AS total_years_of_experience
FROM ( ( SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
         FROM scores JOIN chef ON scores.chef_id=chef.chef_id
       )
       UNION
       ( SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
         FROM scores, judge_in_episode, chef
         WHERE scores.season_number = judge_in_episode.season_number AND scores.episode_number = judge_in_episode.episode_number AND judge_in_episode.chef_id = chef.chef_id
	   )
	  )
GROUP BY season_number_common, episode_number_common
HAVING total_years_of_experience = ( SELECT MIN(total_years_of_experience)
                                     FROM ( SELECT season_number_common, episode_number_common, SUM(years_of_work_experience_common) AS total_years_of_experience
                                            FROM ( ( SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
													 FROM scores JOIN chef ON scores.chef_id=chef.chef_id
                                                    )
                                                    UNION
                                                    ( SELECT scores.season_number AS season_number_common, scores.episode_number AS episode_number_common, chef.chef_id AS chef_id_common, chef.years_of_work_experience AS years_of_work_experience_common
                                                      FROM scores, judge_in_episode, chef
													  WHERE scores.season_number = judge_in_episode.season_number AND scores.episode_number = judge_in_episode.episode_number AND judge_in_episode.chef_id = chef.chef_id
	                                                )
	                                               )
                                             GROUP BY season_number_common, episode_number_common
                                             )
										)
;



/* QUERY NO 14 */

SELECT recipe.theme_name, COUNT(*) AS theme_numbers_found
FROM scores JOIN recipe ON scores.recipe_id=recipe.recipe_id
GROUP BY recipe.theme_name
HAVING theme_numbers_found = ( SELECT MAX(theme_numbers_found)
                               FROM ( SELECT recipe.theme_name, COUNT(*) AS theme_numbers_found
                                      FROM scores JOIN recipe ON scores.recipe_id=recipe.recipe_id
									  GROUP BY recipe.theme_name
                                    )
							)
;


/* QUERY NO 15 */

SELECT food_group_id, group_name
FROM food_group
WHERE food_group_id NOT IN ( SELECT ingredient.food_group_id
                             FROM scores, recipe, recipe_has_ingredient, ingredient
                             WHERE scores.recipe_id=recipe.recipe_id AND recipe.recipe_id=recipe_has_ingredient.recipe_id AND recipe_has_ingredient.ingredient_id=ingredient.ingredient_id
                             )
;