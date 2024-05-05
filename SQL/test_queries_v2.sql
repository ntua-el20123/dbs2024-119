USE db_proj_119-24;

-- Basic INSERT operation

-- food group
-- INSERT
INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (1,'red meat','fatty and delicious but not very healthy');
INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (2,'vegetables','green and grassy and good for your health');
INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (5,'fruits','great for salads and smoothies');

-- DELETE
DELETE FROM food_group WHERE food_group_id = 1;
DELETE FROM food_group WHERE group_name = 'vegetables';

-- UPDATE
UPDATE food_group SET group_name = "meat" WHERE group_name = "red meat";
UPDATE food_group SET group_name = "red meat" WHERE food_group_id = "1";
UPDATE food_group SET food_group_id = 3 WHERE food_group_id = 5;

-- -----------------------------------------------------------------------------------------------------------------------------------------

-- theme
-- INSERT
INSERT INTO theme(theme_name,theme_description) VALUES('flaming hot','cook with spices to create the most flavorable and spicy dishes possible!');
-- this query is designed to fail 
-- INSERT INTO theme(theme_name,theme_description) VALUES('flaming hot','same primary but different attribute');
INSERT INTO theme(theme_name,theme_description) VALUES('Under the Sea','Exotic seafood recipes with unusual ingridients!');

-- DELETE
DELETE FROM theme WHERE theme_name = 'flaming hot';
DELETE FROM theme WHERE theme_description = 'Exotic seafood recipes with unusual ingridients!';

-- UPDATE
UPDATE theme SET theme_name = 'hot' WHERE theme_name = 'flaming hot';
UPDATE theme SET theme_name = 'flaming hot' WHERE theme_name = 'hot';
-- ------------------------------------------------------------------------------------------------------------------------------------------

-- cousine
-- INSERT
INSERT INTO cousine(cousine_name) VALUE ('Asian');
INSERT INTO cousine(cousine_name) VALUE ('Italian');
INSERT INTO cousine(cousine_name) VALUE ('Middle-Eastern');
INSERT INTO cousine(cousine_name) VALUE ('French');

-- DELETE
DELETE FROM cousine WHERE cousine_name = 'Asian';

-- UPDATE
UPDATE cousine SET cousine_name = 'asian' WHERE cousine_name = 'asian';
-- ----------------------------------------------------------------------------------------------------------------------------------------------

-- tag
-- INSERT
INSERT INTO tag(tag_name) VALUE('quick and easy');
-- ----------------------------------------------------------------------------------------------------------------------------------------------
-- ingridient
-- INSERT
INSERT INTO ingridient(ingridient_id,ingridient_name,food_group_id) VALUES(1,'ground meat',1);

SELECT ingridient_name FROM ingridient WHERE food_group_id = ( 
	SELECT food_group_id FROM food_group WHERE group_name = 'red meat');

INSERT INTO ingridient(ingridient_id,ingridient_name,food_group_id) VALUES(2,'apple',3);

-- DELETE
DELETE FROM ingridient WHERE ingridient_id = 1;

-- UPDATE
UPDATE ingridient SET ingridient_name = 'broccoli',food_group_id = 2 WHERE ingridient_name = 'ground meat';
-- -----------------------------------------------------------------------------------------------------------------------------------------------

-- recipe

INSERT INTO recipe(recipe_id,cooking_time,prep_time,difficulty,recipe_name,image,carbs_per_serving,fats_per_serving,proteins_per_serving,
total_calories,number_of_servings,meal_type,cousine_name,theme_name,main_ingridient_id)
VALUES(1,15,5,2,'test recipe',NULL,100,100,100,300,1,'lunch',"Italian",'flaming hot',1);

UPDATE recipe SET total_calories = 301 WHERE recipe_id = 1;

DELETE FROM recipe WHERE recipe_id = 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- recipe_has_ingridient

INSERT INTO recipe_has_ingridient(recipe_id,ingridient_id) VALUES(1,1);
INSERT INTO recipe_has_ingridient(recipe_id,ingridient_id) VALUES(1,2);

DELETE FROM recipe_has_ingridient WHERE recipe_id = 1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- recipe_has tag

INSERT INTO recipe_has_tag(tag_name,recipe_id) VALUES ('quick and easy',1);

DELETE FROM recipe_has_tag WHERE recipe_id=1;

-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- cooking_equipement

INSERT INTO cooking_equipment(equipment_id,equipment_name,instructions,image,image_description) VALUES (1,'blender','blend things',NULL,"it's a blender");

-- -------------------------------------------------------------------------------------------------------------------------------------------------

-- recipe_has_cooking_equipment

INSERT INTO recipe_has_cooking_equipment(recipe_id,equipment_id) VALUES (1,1);

DELETE FROM recipe_has_cooking_equipment WHERE recipe_id=1;
-- --------------------------------------------------------------------------------------------------------------------------------------------------

-- tips

 INSERT INTO tips(tip_number,tip_despcription,recipe_id) VALUES (1,"Drizzle with the Rizzle",1);
 INSERT INTO tips(tip_number,tip_despcription,recipe_id) VALUES (2,"Sprinkle the Mizzle Fizzle",1);
 INSERT INTO tips(tip_number,tip_despcription,recipe_id) VALUES (3,"Spike with heroin",1);
 
 DELETE FROM tips WHERE recipe_id = 1;
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- chef

INSERT INTO chef(chef_id,first_name,last_name,birth_year,phone_number,image_description,actual_image,age,years_of_work_expirience,proffesional_status,cousine_name)
VALUES (1,'Tony','Spaghetti',1943,698581581,'the most decorated italian chef of asian cousine',NULL,89,88,'the goat','Italian');

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- episode

INSERT INTO episode(episode_number,season_number) VALUES(1,1); 

-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- judge_in_episode

INSERT INTO judge_in_episode(chef_id,episode_number,season_number,judge_number) VALUES(1,1,1,1);

-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- scores

INSERT INTO scores(chef_id,episode_number,season_number,cousine_name,recipe_id,score_1,score_2,score_3,total_score) 
VALUES (1,1,1,'Asian',1,2,4,4,3);

DELETE FROM scores WHERE chef_id = 1;