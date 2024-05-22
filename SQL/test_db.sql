/* QUERY NO 1 (CHECKED, IT WORKS) */ 

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


/* QUERY NO 2 */

(
    SELECT DISTINCT specializes_in.cousine_name AS cousine, chefs_that_took_part.chef_id AS chef_id, chefs_that_took_part.season AS season, 'yes' AS took_part
    FROM specializes_in 
    JOIN (
        (SELECT chef_id, episode_number, season_number
         FROM judge_in_episode)
        UNION
        (SELECT chef_id, episode_number, season_number
         FROM scores)
    ) AS chefs_that_took_part
    ON specializes_in.chef_id=chefs_that_took_part.chef_id
)
UNION
(
    SELECT DISTINCT cousine, chef_id, season, 'no' AS took_part
    FROM (
        SELECT DISTINCT specializes_in.cousine_name AS cousine, specializes_in.chef_id AS chef_id, all_the_seasons.season AS season
        FROM specializes_in, (SELECT DISTINCT season_number FROM episode) AS all_the_seasons
        WHERE NOT EXISTS (
            (SELECT specializes_in.cousine_name AS cousine, judge_in_episode.chef_id AS chef_id, judge_in_episode.season AS season
             FROM specializes_in 
             JOIN judge_in_episode ON specializes_in.chef_id=judge_in_episode.chef_id)
            UNION
            (SELECT specializes_in.cousine_name AS cousine, scores.chef_id AS chef_id, scores.season AS season
             FROM specializes_in 
             JOIN scores ON specializes_in.chef_id=scores.chef_id)
        )
    )
);


/* QUERY NO 3 (works) */

SELECT chef_id, COUNT(*) AS number_of_recipes
FROM chef 
NATURAL JOIN cook_has_recipe
WHERE age<30
GROUP BY chef_id
HAVING number_of_recipes = (
    SELECT MAX(recipe_count)
    FROM (
        SELECT chef_id, COUNT(*) AS recipe_count
        FROM chef 
        NATURAL JOIN cook_has_recipe
        WHERE age<30
        GROUP BY chef_id
    ) AS k
);


/* QUERY NO 4 (works) */

SELECT chef_id
FROM chef
WHERE chef_id NOT IN (
    SELECT chef_id
    FROM judge_in_episode
);


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
FROM (
    (SELECT chef_id FROM judge_in_episode) 
    UNION ALL 
    (SELECT chef_id FROM scores)
) AS l
GROUP BY chef_id
HAVING times_in_episode + 5 <= (
    SELECT DISTINCT MAX(times_in_episode)
    FROM (
        SELECT chef_id, COUNT(*) AS times_in_episode
        FROM (
            (SELECT chef_id FROM judge_in_episode) 
            UNION ALL 
            (SELECT chef_id FROM scores)
        ) AS p
        GROUP BY chef_id
    ) AS k
);


/* QUERY NO 8 */

SELECT scores.season, scores.episode, COUNT(*) AS amount_of_equipment_used
FROM scores, recipe, recipe_has_cooking_equipment
WHERE scores.recipe_id=recipe.recipe_id AND recipe.recipe_id=recipe_has_cooking_equipment.recipe_id
GROUP BY scores.season, scores.episode
HAVING  amount_of_equipment_used = (
    SELECT MAX(amount_of_equipment_used)
    FROM (
        SELECT scores.season, scores.episode, COUNT(*) AS amount_of_equipment_used
        FROM scores, recipe, recipe_has_cooking_equipment
        WHERE scores.recipe_id=recipe.recipe_id AND recipe.recipe_id=recipe_has_cooking_equipment.recipe_id
        GROUP BY scores.season, scores.episode
    )
);


/* QUERY NO 9 */

SELECT scores.season_number, AVG(recipe.carbs_per_serving) AS average_carbs
FROM scores 
JOIN recipe ON scores.recipe_id=recipe.recipe_id
GROUP BY scores.season_number;


/* QUERY NO 10 */

(
    SELECT cousine.cousine_name AS cousine, scores.season AS season, COUNT(*) AS appearances
    FROM scores 
    JOIN cousine ON scores.cousine_name = cousine.cousine_name
    GROUP BY cousine.cousine_name, scores.season
    HAVING appearances >= 3
) AS cousine_season_appearances

(
    SELECT cousine_season_appearances_one.cousine AS cousine, 
           cousine_season_appearances_one.season AS season1, 
           cousine_season_appearances_two.season AS season2, 
           cousine_season_appearances_one.appearances AS season1_appearances, 
           cousine_season_appearances_two.appearances AS season2_appearances
    FROM cousine_season_appearances_one 
    JOIN cousine_season_appearances_two 
    ON cousine_season_appearances_one.cousine = cousine_season_appearances_two.cousine
    WHERE cousine_season_appearances_one.season + 1 = cousine_season_appearances_two.season
) AS cousine_b2b

SELECT cousine_one, cousine_two, season_one, season_two, 
       appearances_cousine_one_season_one, appearances_cousine_one_season_two, 
       appearances_cousine_two_season_one, appearances_cousine_two_season_two
FROM cousine_b2b_one 
JOIN cousine_b2b_two 
ON (cousine_b2b_one.season1 = cousine_b2b_two.season1 AND cousine_b2b_one.season2 = cousine_b2b_two.season2)
WHERE 


/* QUERY NO 12 */

SELECT only_seasons.season AS season, 
       seasons_and_episodes.episode AS episode, 
       only_seasons.max_total_difficulty_of_season AS episode_total_difficulty
FROM (
    SELECT scores.season_number AS season, 
           scores.episode_number AS episode, 
           SUM(recipe.difficulty) AS total_difficulty
    FROM scores 
    JOIN recipe ON scores.recipe_id = recipe.recipe_id
    GROUP BY scores.season_number, scores.episode_number
) AS seasons_and_episodes,
(
    SELECT season, MAX(total_difficulty) AS max_total_difficulty_of_season
    FROM (
        SELECT scores.season_number AS season, 
               scores.episode_number AS episode, 
               SUM(recipe.difficulty) AS total_difficulty
        FROM scores 
        JOIN recipe ON scores.recipe_id = recipe.recipe_id
        GROUP BY scores.season_number, scores.episode_number
    )
    GROUP BY season
) AS only_seasons
WHERE (seasons_and_episodes.season = only_seasons.season AND 
       seasons_and_episodes.total_difficulty = only_seasons.max_total_difficulty_of_season)
;



/* QUERY NO 13 */

SELECT season_number_common, episode_number_common, 
       SUM(years_of_work_experience_common) AS total_years_of_experience
FROM (
    (
        SELECT scores.season_number AS season_number_common, 
               scores.episode_number AS episode_number_common, 
               chef.chef_id AS chef_id_common, 
               chef.years_of_work_experience AS years_of_work_experience_common
        FROM scores 
        JOIN chef ON scores.chef_id = chef.chef_id
    )
    UNION
    (
        SELECT scores.season_number AS season_number_common, 
               scores.episode_number AS episode_number_common, 
               chef.chef_id AS chef_id_common, 
               chef.years_of_work_experience AS years_of_work_experience_common
        FROM scores, 
             judge_in_episode, 
             chef
        WHERE scores.season_number = judge_in_episode.season_number AND 
              scores.episode_number = judge_in_episode.episode_number AND 
              judge_in_episode.chef_id = chef.chef_id
    )
)
GROUP BY season_number_common, episode_number_common
HAVING total_years_of_experience = (
    SELECT MIN(total_years_of_experience)
    FROM (
        SELECT season_number_common, episode_number_common, 
               SUM(years_of_work_experience_common) AS total_years_of_experience
        FROM (
            (
                SELECT scores.season_number AS season_number_common, 
                       scores.episode_number AS episode_number_common, 
                       chef.chef_id AS chef_id_common, 
                       chef.years_of_work_experience AS years_of_work_experience_common
                FROM scores 
                JOIN chef ON scores.chef_id = chef.chef_id
            )
            UNION
            (
                SELECT scores.season_number AS season_number_common, 
                       scores.episode_number AS episode_number_common, 
                       chef.chef_id AS chef_id_common, 
                       chef.years_of_work_experience AS years_of_work_experience_common
                FROM scores, 
                     judge_in_episode, 
                     chef
                WHERE scores.season_number = judge_in_episode.season_number AND 
                      scores.episode_number = judge_in_episode.episode_number AND 
                      judge_in_episode.chef_id = chef.chef_id
            )
        )
        GROUP BY season_number_common, episode_number_common
    )
);


/* QUERY NO 14 */

SELECT recipe.theme_name, COUNT(*) AS theme_numbers_found
FROM scores 
JOIN recipe ON scores.recipe_id = recipe.recipe_id
GROUP BY recipe.theme_name
HAVING theme_numbers_found = (
    SELECT MAX(theme_numbers_found)
    FROM (
        SELECT recipe.theme_name, COUNT(*) AS theme_numbers_found
        FROM scores 
        JOIN recipe ON scores.recipe_id = recipe.recipe_id
        GROUP BY recipe.theme_name
    )
);


/* QUERY NO 15 */

SELECT food_group_id, group_name
FROM food_group
WHERE food_group_id NOT IN (
    SELECT ingredient.food_group_id
    FROM scores, recipe, recipe_has_ingredient, ingredient
    WHERE scores.recipe_id = recipe.recipe_id AND 
          recipe.recipe_id = recipe_has_ingredient.recipe_id AND 
          recipe_has_ingredient.ingredient_id = ingredient.ingredient_id
);



/* FILLING THE DATABASE */

-- INSERT operations on cousine table
INSERT INTO cousine(cousine_name) VALUES 
('Italian') , ('Greek') , ('Cubanese') , ('Turkish') , ('Mexican') , ('Indian');


-- INSERT operations on chef table
INSERT INTO chef(chef_id, first_name, last_name, birth_year, phone_number, image_description, age, years_of_work_experience, professional_status) VALUES
(1, 'Catherine', 'Mellou', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star'),
(2, 'Aggeliki', 'Visvardi', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star'),
(3, 'Maria', 'Tsiavou', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star'),
(4, 'Paris', 'Voutas', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star'),
(5, 'Foivos', 'Golois', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star');



-- INSERT operations on theme table
INSERT INTO theme(theme_name, theme_description) VALUES 
    ('Flaming Hot', 'Cook with spices to create flavorful and spicy dishes'),
    ('Nose to Tail', 'Utilize as much of the protein provided as possible'),
    ('Quick and Easy', 'Simple and effortless recipes for busy individuals');
    
    
-- INSERT operations on food_group table
INSERT INTO food_group(group_name, group_description) VALUES 
    ('Red Meat', 'Fatty and delicious but not very healthy'),
    ('Vegetables', 'Green and grassy, good for your health');
    
    
-- INSERT operations on ingridient table
INSERT INTO ingridient(ingridient_name, food_group_id) VALUES 
    ('Beef', 1), ('Chicken', 1), ('Broccoli', 2), ('Tomato', 2);
    
    
-- INSERT operations on recipe table
INSERT INTO recipe(recipe_id, cooking_time, prep_time, difficulty, recipe_name, carbs_per_serving, fats_per_serving, proteins_per_serving, total_calories, number_of_servings, meal_type, cousine_name, theme_name, main_ingridient_id) VALUES 
    (1, '00:30:00', '00:15:00', 3, 'Cake Althea Ketsi', 60, 20, 30, 100, 4, 'Dinner', 'Greek', 'Flaming Hot', 1),
    (2, '00:30:00', '00:15:00', 3, 'Beef steak', 60, 20, 30, 100, 4, 'Dinner', 'Greek', 'Flaming Hot', 1),
    (3, '00:30:00', '00:15:00', 3, 'Pizza', 60, 20, 30, 100, 4, 'Dinner', 'Italian', 'Flaming Hot', 1),
    (4, '00:30:00', '00:15:00', 3, 'Buratta salad', 60, 20, 30, 100, 4, 'Dinner', 'Italian', 'Flaming Hot', 1),
    (5, '00:30:00', '00:15:00', 3, 'Green beans', 60, 20, 30, 100, 4, 'Dinner', 'Greek', 'Flaming Hot', 1);
    
   
-- INSERT operations on cook_has_recipe table
INSERT INTO cook_has_recipe(chef_id, recipe_id) VALUES
(1, 1) , (1, 2) , (1, 3) , (1, 4) , (2, 2) , (2, 3) , (2, 4) , (2, 5);


-- INSERT operations on episode table
INSERT INTO episode(episode_number, season_number) VALUES 
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1);
    
    
-- INSERT operations on scores table (create random scores for player-chefs in all episodes)
INSERT INTO scores(chef_id, episode_number, season_number, cousine_name, recipe_id, score_1, score_2, score_3, total_score) VALUES 
    (1, 1, 1, 'Italian', 3, 4, 5, 3, 4),
    (1, 2, 1, 'Italian', 4, 3, 4, 4, 3.7),
    (1, 4, 1, 'Greek', 1, 2, 3, 4, 3),
    (1, 5, 1, 'Greek', 2, 5, 4, 5, 4.7),
    (2, 1, 1, 'Greek', 1, 3, 4, 4, 3.7),
    (2, 2, 1, 'Greek', 5, 1, 2, 2, 1.7);