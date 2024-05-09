DROP DATABASE dblabV2;

CREATE DATABASE dblabV2;

USE dblabV2;

CREATE TABLE food_group(
 food_group_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 group_name VARCHAR(45) NOT NULL UNIQUE,
 group_description VARCHAR(200) NOT NULL,
 PRIMARY KEY(food_group_id)
);

CREATE TABLE theme(
 theme_name VARCHAR(45) NOT NULL UNIQUE,
 theme_description VARCHAR(200) NOT NULL,
 PRIMARY KEY(theme_name)
);

CREATE TABLE cousine(
 cousine_name VARCHAR(30) NOT NULL UNIQUE,
 PRIMARY KEY(cousine_name)
);

CREATE TABLE tag(
 tag_name VARCHAR(30) NOT NULL,
 PRIMARY KEY(tag_name)
);

CREATE TABLE ingridient(
 ingridient_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 ingridient_name VARCHAR(45) NOT NULL UNIQUE,
 food_group_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY(ingridient_id),
 KEY idx_fk_food_group_id (food_group_id),
 CONSTRAINT fk_food_group_id FOREIGN KEY(food_group_id)
 REFERENCES food_group(food_group_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE recipe(
 recipe_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 cooking_time TIME NOT NULL,
 prep_time TIME NOT NULL,
 difficulty SMALLINT NOT NULL CHECK (0 < difficulty < 6),
 recipe_name VARCHAR(45) NOT NULL UNIQUE,
 image BLOB,
 carbs_per_serving INT UNSIGNED NOT NULL,
 fats_per_serving INT UNSIGNED NOT NULL,
 proteins_per_serving INT UNSIGNED NOT NULL,
 total_calories INT UNSIGNED NOT NULL,
 number_of_servings INT UNSIGNED NOT NULL,
 meal_type VARCHAR(45) NOT NULL,
 cousine_name VARCHAR(45),
 theme_name VARCHAR(45),
 main_ingridient_id SMALLINT UNSIGNED,
 PRIMARY KEY(recipe_id),
 KEY idx_fk_cousine_name (cousine_name),
 KEY idx_fk_theme_name (theme_name),
 KEY idx_fk_main_ingridient (main_ingridient_id),
 CONSTRAINT fk_cousine_name FOREIGN KEY (cousine_name)
 REFERENCES cousine (cousine_name) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_theme_name FOREIGN KEY (theme_name)
 REFERENCES theme (theme_name) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_main_ingridient FOREIGN KEY (main_ingridient_id)
 REFERENCES ingridient (ingridient_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

DELIMITER //

CREATE TRIGGER fill_calories
AFTER INSERT ON recipe
FOR EACH ROW
BEGIN
   DECLARE total_calories_temp INT UNSIGNED;

   SET total_calories_temp = 4*NEW.carbs_per_serving + 9*NEW.fats_per_serving + 4*NEW.proteins_per_serving;

   UPDATE recipe
   SET total_calories = total_calories_temp
   WHERE id = NEW.recipe_id;
END//

DELIMITER ;



CREATE TABLE recipe_has_ingridient(
 recipe_id SMALLINT UNSIGNED NOT NULL,
 ingridient_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY(recipe_id,ingridient_id),
 KEY idx_fk_recipe_id (recipe_id),
 KEY idx_fk_ingridient_id (ingridient_id),
 CONSTRAINT fk_recipe_id FOREIGN KEY(recipe_id)
 REFERENCES recipe (recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_ingridient_id FOREIGN KEY(ingridient_id)
 REFERENCES ingridient (ingridient_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE recipe_has_tag(
 tag_name VARCHAR(30) NOT NULL UNIQUE,
 recipe_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 PRIMARY KEY(tag_name,recipe_id),
 KEY idx_fk_tag_name (tag_name),
 KEY idx_fk_recipe_id (recipe_id),
 CONSTRAINT fk_tag_name FOREIGN KEY (tag_name)
 REFERENCES tag(tag_name) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_tag_recipe_id FOREIGN KEY(recipe_id)
 REFERENCES recipe(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE cooking_equipment(
 equipment_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 equipment_name VARCHAR(20) NOT NULL UNIQUE,
 instructions VARCHAR(100) NOT NULL,
 image BLOB,
 image_description VARCHAR(100),
 PRIMARY KEY(equipment_id)
);

CREATE TABLE recipe_has_cooking_equipment(
 recipe_id SMALLINT UNSIGNED NOT NULL,
 equipment_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY(recipe_id,equipment_id),
 KEY idx_fk_equipment_id (equipment_id),
 KEY idx_fk_recipe_id (recipe_id),
 CONSTRAINT fk_equipment_id FOREIGN KEY (equipment_id)
 REFERENCES cooking_equipment(equipment_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_equip_recipe_id FOREIGN KEY(recipe_id)
 REFERENCES recipe(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE
 );
 
 CREATE TABLE tips(
 tip_number SMALLINT NOT NULL,
 tip_description VARCHAR(100) NOT NULL,
 recipe_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY(tip_number,recipe_id),
 KEY idx_pk_tip_number (tip_number),
 KEY idx_fk_tips_recipe_id (recipe_id),
 CONSTRAINT fk_tips_recipe_id FOREIGN KEY(recipe_id)
 REFERENCES recipe(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE
 );
 
 /* CREATE TRIGGER max_3_tips BEFORE INSERT ON tips
 REFERENCING NEW ROW AS nrow
 FOR EACH ROW
 WHEN (3 >= (COUNT (*) 
              FROM (SELECT (*) 
					FROM tips
					WHERE nrow.recipe_id = tips.recipe_id
					)
			 )
	   )
BEGIN ATOMIC
      ROLLBACK
END; */


DELIMITER //

CREATE TRIGGER max_3_tips
BEFORE INSERT ON tips
FOR EACH ROW
BEGIN
    DECLARE tip_count INT;
    
    SELECT COUNT(*) INTO tip_count
    FROM tips
    WHERE recipe_id = NEW.recipe_id;
    
    IF tip_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert more than 3 tips per recipe';
    END IF;
    
END //

DELIMITER ;

 
 CREATE TABLE steps(
 step_number SMALLINT UNSIGNED NOT NULL,
 step_despcription VARCHAR(100) NOT NULL,
 recipe_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY(step_number,recipe_id),
 KEY idx_fk_recipe_id (recipe_id),
 CONSTRAINT fk_steps_recipe_id FOREIGN KEY (recipe_id)
 REFERENCES recipe(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE
 );
 
 CREATE TABLE chef(
 chef_id SMALLINT UNSIGNED NOT NULL,
 username VARCHAR(45) NOT NULL,
 _password VARCHAR(45) NOT NULL,
 first_name VARCHAR(45) NOT NULL,
 last_name VARCHAR(45) NOT NULL,
 birth_year YEAR NOT NULL,
 phone_number INT NOT NULL,
 image_description VARCHAR(200),
 actual_image BLOB,
 age INT NOT NULL,
 years_of_work_experience INT NOT NULL,
 proffesional_status VARCHAR(45) NOT NULL,
 cousine_name VARCHAR(30) NOT NULL,
 PRIMARY KEY(chef_id),
 KEY idx_fk_cousine_name (cousine_name),
 CONSTRAINT fk_chef_cousine_name FOREIGN KEY (cousine_name)
 REFERENCES cousine(cousine_name) ON DELETE RESTRICT ON UPDATE CASCADE
 );
  
 CREATE TABLE episode(
 episode_number SMALLINT NOT NULL CHECK(0 < episode_number < 10) CHECK (0 <episode_number < 11),
 season_number INT NOT NULL,
 PRIMARY KEY(episode_number,season_number),
 KEY idx_pk_season_number (season_number)
 );
 
 CREATE TABLE judge_in_episode(
 chef_id SMALLINT UNSIGNED NOT NULL,
 episode_number SMALLINT(10) NOT NULL,
 season_number INT NOT NULL,
 judge_number INT NOT NULL,
 PRIMARY KEY(chef_id,episode_number,season_number),
 KEY idx_fk_chef_id (chef_id),
 KEY idx_fk_episode_number (episode_number),
 KEY idx_fk_season_number (season_number),
 CONSTRAINT fk_judge_chef_id FOREIGN KEY (chef_id)
 REFERENCES chef(chef_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_judge_episode_number FOREIGN KEY (episode_number)
 REFERENCES episode(episode_number) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_judge_season_number FOREIGN KEY (season_number)
 REFERENCES episode(season_number) ON DELETE RESTRICT ON UPDATE CASCADE
 );
 
 DELIMITER //
 
 CREATE TRIGGER judge_already_player 
 BEFORE INSERT ON judge_in_episode 
 FOR EACH ROW
 BEGIN
    IF EXISTS ( SELECT chef_id
                FROM scores
                WHERE ( (scores.chef_id = NEW.chef_id) AND (scores.episode_number = NEW.episode_number) AND (scores.season_number = NEW.season_number) )
			  )
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a chef as a judge in an episode where he is already a player';
    END IF;
END //

DELIMITER ;
 

 CREATE TABLE scores(
 chef_id SMALLINT UNSIGNED NOT NULL,
 episode_number SMALLINT NOT NULL,
 season_number INT NOT NULL,
 cousine_name VARCHAR(30) NOT NULL,
 recipe_id SMALLINT UNSIGNED NOT NULL ,
 score_1 SMALLINT NOT NULL CHECK (0 < score_1 < 6),
 score_2 SMALLINT NOT NULL CHECK (0 < score_2 < 6),
 score_3 SMALLINT NOT NULL CHECK (0 < score_3 < 6),
 total_score FLOAT NOT NULL,
 PRIMARY KEY(chef_id,episode_number,season_number,cousine_name,recipe_id),
 KEY idx_fk_chef_id (chef_id),
 KEY idx_fk_episode_number (episode_number),
 KEY idx_fk_season_number (season_number),
 KEY idx_fk_cousine_name (cousine_name),
 KEY idx_fk_recipe_id (recipe_id),
 CONSTRAINT fk_scores_chef_id FOREIGN KEY (chef_id)
 REFERENCES chef(chef_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_scores_episode_number FOREIGN KEY (episode_number)
 REFERENCES episode(episode_number) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_scores_season_number FOREIGN KEY (season_number)
 REFERENCES episode(season_number) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_scores_cousine_name FOREIGN KEY (cousine_name)
 REFERENCES cousine(cousine_name) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_scores_recipe_id FOREIGN KEY (recipe_id)
 REFERENCES recipe(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE
 );
 
 
 CREATE TABLE cook_has_recipe (
 chef_id SMALLINT UNSIGNED NOT NULL,
 recipe_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (chef_id, recipe_id),
 FOREIGN KEY (chef_id) REFERENCES chef(chef_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE
 ); 
 
 
 DELIMITER //
 
  CREATE TRIGGER player_already_judge
 BEFORE INSERT ON scores 
 FOR EACH ROW
 BEGIN
    IF EXISTS ( SELECT chef_id
                FROM judge_in_episode
                WHERE ( (judge_in_episode.chef_id = NEW.chef_id) AND (judge_in_episode.episode_number = NEW.episode_number) AND (judge_in_episode.season_number = NEW.season_number) )
			  )
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot insert a chef as a player in an episode where he is already a judge';
    END IF;
END //

DELIMITER ;



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














 
 
