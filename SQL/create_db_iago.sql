DROP DATABASE IF EXISTS dblabV2;
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
 image LONGBLOB,
 carbs_per_serving INT UNSIGNED NOT NULL,
 fats_per_serving INT UNSIGNED NOT NULL,
 proteins_per_serving INT UNSIGNED NOT NULL,
 total_calories INT UNSIGNED NOT NULL DEFAULT 0,
 number_of_servings INT UNSIGNED NOT NULL,
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



/*
DELIMITER //

CREATE TRIGGER fill_calories
AFTER INSERT ON recipe
FOR EACH ROW
BEGIN
   DECLARE total_calories_temp INT UNSIGNED;

   SET total_calories_temp = 4*NEW.carbs_per_serving + 9*NEW.fats_per_serving + 4*NEW.proteins_per_serving;

   UPDATE recipe
   SET total_calories = total_calories_temp
   WHERE recipe_id = NEW.recipe_id;
END//

DELIMITER ;
*/


CREATE TABLE recipe_has_ingridient(
 recipe_id SMALLINT UNSIGNED NOT NULL,
 ingridient_id SMALLINT UNSIGNED NOT NULL,
 quantity VARCHAR(30) NOT NULL,
 PRIMARY KEY(recipe_id,ingridient_id),
 KEY idx_fk_recipe_id (recipe_id),
 KEY idx_fk_ingridient_id (ingridient_id),
 CONSTRAINT fk_recipe_id FOREIGN KEY(recipe_id)
 REFERENCES recipe (recipe_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 CONSTRAINT fk_ingridient_id FOREIGN KEY(ingridient_id)
 REFERENCES ingridient (ingridient_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE recipe_has_tag(
 tag_name VARCHAR(30) NOT NULL,
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
 image LONGBLOB,
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
 chef_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
 first_name VARCHAR(45) NOT NULL,
 last_name VARCHAR(45) NOT NULL,
 birth_year YEAR NOT NULL,
 phone_number INT NOT NULL,
 image_description VARCHAR(200),
 actual_image LONGBLOB,
 age INT NOT NULL,
 years_of_work_experience INT NOT NULL,
 professional_status VARCHAR(45) NOT NULL,
 PRIMARY KEY(chef_id)
 );
 
 CREATE TABLE specializes_in(
 chef_id SMALLINT UNSIGNED NOT NULL,
 cousine_name VARCHAR(30) NOT NULL,
 PRIMARY KEY(chef_id, cousine_name),
 FOREIGN KEY (chef_id) REFERENCES chef(chef_id) ON DELETE RESTRICT ON UPDATE CASCADE,
 FOREIGN KEY (cousine_name) REFERENCES cousine(cousine_name) ON DELETE RESTRICT ON UPDATE CASCADE
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
 total_score FLOAT NOT NULL DEFAULT 0,
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
 
 
 CREATE TABLE meal_type(
	meal_type_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (meal_type_name)
);


 CREATE TABLE recipe_meal_type (
 meal_type_name VARCHAR(30) NOT NULL,
 recipe_id SMALLINT UNSIGNED NOT NULL,
 PRIMARY KEY (meal_type_name, recipe_id),
 FOREIGN KEY (meal_type_name) REFERENCES meal_type(meal_type_name) ON DELETE RESTRICT ON UPDATE CASCADE,
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



/* FILLING THE DATABASE */

-- INSERT operations on cousine table
INSERT INTO cousine(cousine_name) VALUES 
('Italian') , ('Greek') , ('Cubanese') , ('Turkish') , ('Mexican') , ('Indian');


-- INSERT operations on chef table
INSERT INTO chef(chef_id, first_name, last_name, birth_year, phone_number, image_description, age, years_of_work_experience, professional_status) VALUES
(1, 'Catherine', 'Mellou', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 7, 'Rising Star'),
(2, 'Aggeliki', 'Visvardi', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star'),
(3, 'Maria', 'Tsiavou', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 75, 21, 'Rising Star'),
(4, 'Paris', 'Voutas', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 25, 5, 'Rising Star'),
(5, 'Foivos', 'Golois', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 28, 9, 'Rising Star'),
(6, 'Ntaglas', 'Sigalas', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 40, 2, 'Rising Star'),
(7, 'Filippos', 'Mardirosian', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 40, 15, 'Rising Star');



-- INSERT operations on theme table
INSERT INTO theme(theme_name, theme_description) VALUES 
    ('Flaming Hot', 'Cook with spices to create flavorful and spicy dishes'),
    ('Nose to Tail', 'Utilize as much of the protein provided as possible'),
    ('Quick and Easy', 'Simple and effortless recipes for busy individuals');
    
    
-- INSERT operations on food_group table
INSERT INTO food_group(food_group_id, group_name, group_description) VALUES 
    (1, 'Meat', 'Fatty and delicious but not very healthy'),
    (2, 'Vegetables', 'Green and grassy, good for your health'),
    (3, 'Grains', 'pasta, bread, ...'),
    (4, 'Beverages', '...');
    
    
-- INSERT operations on ingridient table
INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES 
    (1, 'Beef', 1), (2, 'Chicken', 1), (3, 'Broccoli', 2), (4, 'Tomato', 2), (5, 'dough', 3);
    
    
-- INSERT operations on recipe table
INSERT INTO recipe(recipe_id, cooking_time, prep_time, difficulty, recipe_name, carbs_per_serving, fats_per_serving, proteins_per_serving, total_calories, number_of_servings, cousine_name, theme_name, main_ingridient_id) VALUES 
    (1, '00:30:00', '00:15:00', 2, 'Cake Althea Ketsi', 40, 20, 30, 100, 4, 'Greek', 'Quick and Easy', 1),
    (2, '00:30:00', '00:15:00', 4, 'Beef steak', 15, 20, 30, 100, 4, 'Greek', 'Nose to Tail', 1),
    (3, '00:30:00', '00:15:00', 3, 'Pizza', 30, 20, 30, 100, 4, 'Italian', 'Flaming Hot', 1),
    (4, '00:30:00', '00:15:00', 1, 'Buratta salad', 10, 20, 30, 100, 4, 'Italian', 'Quick and Easy', 1),
    (5, '00:30:00', '00:15:00', 4, 'Green beans', 20, 20, 30, 100, 4, 'Greek', 'Nose to Tail', 1);
    
/*   
-- INSERT operations on cook_has_recipe table
INSERT INTO cook_has_recipe(chef_id, recipe_id) VALUES
(1, 1) , (1, 2) , (1, 3) , (1, 4) , 
(2, 2) , (2, 3) , (2, 4) , (2, 5),
(3, 1), (3, 2),
(4, 1), (4, 2), (4,3),
(5, 2), (5, 4), (5,5);


-- INSERT operations on episode table
INSERT INTO episode(episode_number, season_number) VALUES 
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
    (1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2),
    (1,3);
    
    
-- INSERT operations on scores table (create random scores for player-chefs in all episodes)
INSERT INTO scores(chef_id, episode_number, season_number, cousine_name, recipe_id, score_1, score_2, score_3, total_score) VALUES 
    (1, 3, 1, 'Italian', 3, 4, 5, 3, 4),
    (1, 2, 1, 'Italian', 4, 3, 4, 4, 3.7),
    (1, 4, 1, 'Greek', 1, 2, 3, 4, 3),
    (1, 5, 1, 'Greek', 2, 5, 4, 5, 4.7),
    (2, 1, 1, 'Greek', 1, 3, 4, 4, 3.7),
    (2, 2, 2, 'Italian', 3, 1, 2, 2, 1.7),
    (2, 7, 1, 'Italian', 3, 1, 2, 2, 1.7),
    (3, 2, 2, 'Italian', 3, 1, 2, 2, 1.7),
    (3, 4, 2, 'Italian', 3, 1, 2, 2, 1.7),
    (3, 6, 2, 'Italian', 3, 1, 2, 2, 1.7),
    (4, 2, 2, 'Greek', 1, 1, 2, 2, 1.7),
    (4, 6, 2, 'Greek', 5, 1, 2, 2, 1.7),
    (4, 8, 2, 'Greek', 5, 1, 2, 2, 1.7),
    (4, 4, 2, 'Greek', 5, 1, 2, 2, 1.7);


-- INSERT operations on specializes_in table
INSERT INTO specializes_in(chef_id, cousine_name) VALUES
	(1, "Italian"), (1, "Greek"),
    (2, "Italian"), (2, "Greek"),
    (3, "Indian");


-- INSERT operations on judge_in_episode table (match chefs as judges in some episodes)
INSERT INTO judge_in_episode(chef_id, episode_number, season_number, judge_number) VALUES
	(3, 7, 2, 1), (3, 3, 2, 1), (3, 5, 2, 1),
    (4, 5, 2, 2),
    (5, 2, 2, 3), (5, 4, 2, 3), (5, 5, 2, 3), (5, 7, 2, 3), (5, 8, 2, 3),
    (5, 2, 1, 3), (5, 4, 1, 3), (5, 5, 1, 3),
    (6, 7, 1, 2), (6, 8, 1, 2), (6, 2, 1, 2),
    (6, 5, 2, 2), (6, 7, 2, 2), (6, 8, 2, 2), (6, 2, 2, 2),
    (7, 5, 2, 1), (7, 7, 2, 1), (7, 8, 2, 1), (7, 2, 2, 1),
    (7, 5, 1, 1), (7, 7, 1, 1), (7, 8, 1, 1), (7, 4, 1, 2);
    
    
    
-- INSERT operations on recipe_has_ingridient table 
INSERT INTO recipe_has_ingridient(recipe_id, ingridient_id, quantity) VALUES
	(1, 5, 1), (2, 1, 1), (3, 5, 1), (4, 4, 1), (5, 4, 1);
    

-- INSERT operations on cooking_equipment table (20)
INSERT INTO cooking_equipment(equipment_id, equipment_name, instructions, image_description) VALUES 
    (1, 'Blender', 'Blend ingredients to a smooth consistency', 'A versatile kitchen appliance'),
    (2, 'Grill', 'Cook food over an open flame or hot surface', 'Great for barbecue'),
    (3, 'Wok', 'Cook food quickly over high heat', 'Traditional Asian cooking vessel'),
    (4, 'Oven', 'Bake or roast food in a closed chamber', 'Essential for baking'),
    (5, 'Saucepan', 'Cook food in liquid over low heat', 'Great for making sauces'),
    (6, 'Frying Pan', 'Cook food over medium heat with a small amount of oil', 'Perfect for frying');
    
    
-- INSERT operations on recipe_has_cooking_equipment table (match all equipment to recipes)
INSERT INTO recipe_has_cooking_equipment(recipe_id, equipment_id) VALUES
	(3, 1), (3, 2), (3, 3),
    (4, 1), (4, 2),
    (1, 1), (1, 2), (1, 3), (1, 4);
    
    */
    
    


