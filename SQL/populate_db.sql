-- INSERT operations on food_group table
INSERT INTO food_group(food_group_id, group_name, group_description) VALUES (1, 'red meat', 'fatty and delicious but not very healthy');
INSERT INTO food_group(food_group_id, group_name, group_description) VALUES (2, 'vegetables', 'green and grassy and good for your health');
INSERT INTO food_group(food_group_id, group_name, group_description) VALUES (5, 'fruits', 'great for salads and smoothies');
INSERT INTO food_group(food_group_id, group_name, group_description) VALUES (7, 'fish', 'scaly and slimy but delicious');

-- DELETE operation on food_group table
DELETE FROM food_group WHERE group_name = 'fish';

-- UPDATE operations on food_group table
UPDATE food_group SET group_name = 'meat' WHERE group_name = 'red meat';
UPDATE food_group SET group_name = 'red meat' WHERE food_group_id = 1;
UPDATE food_group SET food_group_id = 3 WHERE food_group_id = 5;

-- INSERT operations on theme table
INSERT INTO theme(theme_name, theme_description) VALUES ('flaming hot', 'cook with spices to create the most flavorful and spicy dishes possible!');
INSERT INTO theme(theme_name, theme_description) VALUES ('nose to tail', 'cook utilizing as much of the protein provided as possible!');

-- This query is designed to fail due to unique constraint violation
/*
INSERT INTO theme(theme_name, theme_description) VALUES ('flaming hot', 'same primary but different attribute');
*/

INSERT INTO theme(theme_name, theme_description) VALUES ('Under the Sea', 'Exotic seafood recipes with unusual ingredients!');

-- DELETE operations on theme table
DELETE FROM theme WHERE theme_name = 'nose to tail';
DELETE FROM theme WHERE theme_description = 'Exotic seafood recipes with unusual ingredients!';

-- UPDATE operations on theme table
UPDATE theme SET theme_name = 'hot' WHERE theme_name = 'flaming hot';
UPDATE theme SET theme_name = 'flaming hot' WHERE theme_name = 'hot';

-- INSERT operations on cousine table
INSERT INTO cousine(cousine_name) VALUES ('Asian');
INSERT INTO cousine(cousine_name) VALUES ('Italian');
INSERT INTO cousine(cousine_name) VALUES ('Spanish');
INSERT INTO cousine(cousine_name) VALUES ('French');
INSERT INTO cousine(cousine_name) VALUES ('Latin');
INSERT INTO cousine(cousine_name) VALUES ('Desserts');
INSERT INTO cousine(cousine_name) VALUES ('Mexican');

-- DELETE operation on cousine table
DELETE FROM cousine WHERE cousine_name = 'Middle-Eastern';

-- UPDATE operation on cousine table
UPDATE cousine SET cousine_name = 'asian' WHERE cousine_name = 'asian';

-- INSERT operation on tag table
INSERT INTO tag(tag_name) VALUES ('quick and easy');

-- INSERT operations on ingridient table
INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (1, 'ground meat', 1);
INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (2, 'apple', 3);
INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (3, 'pear', 3);

-- DELETE operation on ingridient table
DELETE FROM ingridient WHERE ingridient_id = 3;

-- UPDATE operation on ingridient table
UPDATE ingridient SET ingridient_name = 'broccoli', food_group_id = 2 WHERE ingridient_name = 'ground meat';

-- INSERT operation on recipe table
INSERT INTO recipe(recipe_id, cooking_time, prep_time, difficulty, recipe_name, image, carbs_per_serving, fats_per_serving, proteins_per_serving, total_calories, number_of_servings, meal_type, cousine_name, theme_name, main_ingridient_id) VALUES (1, 15, 5, 2, 'test recipe', NULL, 100, 100, 100, 300, 1, 'lunch', 'Italian', 'flaming hot', 1);

-- UPDATE operation on recipe table
UPDATE recipe SET total_calories = 301 WHERE recipe_id = 1;

-- INSERT operations on recipe_has_ingridient table
INSERT INTO recipe_has_ingridient(recipe_id, ingridient_id) VALUES (1, 1);
INSERT INTO recipe_has_ingridient(recipe_id, ingridient_id) VALUES (1, 2);

-- DELETE operation on recipe_has_ingridient table
DELETE FROM recipe_has_ingridient WHERE recipe_id = 1;

-- INSERT operation on recipe_has_tag table
INSERT INTO recipe_has_tag(tag_name, recipe_id) VALUES ('quick and easy', 1);

-- DELETE operation on recipe_has_tag table
DELETE FROM recipe_has_tag WHERE recipe_id = 1;

-- INSERT operation on cooking_equipment table
INSERT INTO cooking_equipment(equipment_id, equipment_name, instructions, image, image_description) VALUES (1, 'blender', 'blend things', NULL, 'it''s a blender');

-- INSERT operations on recipe_has_cooking_equipment table
INSERT INTO recipe_has_cooking_equipment(recipe_id, equipment_id) VALUES (1, 1);
DELETE FROM recipe_has_cooking_equipment WHERE recipe_id = 1;

-- INSERT operations on tips table
INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES (1, 'Drizzle with the Rizzle', 1);
INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES (2, 'Sprinkle the Mizzle Fizzle', 1);
INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES (3, 'Spike with heroin', 1);

-- DELETE operation on tips table
DELETE FROM tips WHERE recipe_id = 1;

-- INSERT operation on chef table
INSERT INTO chef(chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (1, 'Tony', 'Spaghetti', 1943, 698581581, 'the most decorated Italian chef of Asian cuisine', NULL, 89, 88, 'the goat', 'Italian');
INSERT INTO chef (chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (2, 'Jessica', 'Smith', 1978, 556892341, 'Award-winning chef specializing in French cuisine', NULL, 47, 20, 'Master Chef', 'French');
INSERT INTO chef (chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (3, 'Carlos', 'Garcia', 1965, 789234567, 'Renowned Spanish chef known for tapas and paella', NULL, 60, 35, 'Gastronomy Maestro', 'Spanish');
INSERT INTO chef (chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (4, 'Linda', 'Wilson', 1982, 456123789, 'Innovative chef blending Asian and Fusion cuisine', NULL, 39, 15, 'Creative Culinary Artist', 'Asian');
INSERT INTO chef (chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (5, 'Ricardo', 'Santos', 1970, 987654321, 'Expert in Latin American dishes and flavors', NULL, 51, 25, 'Latin Cuisine Specialist', 'Latin');
INSERT INTO chef (chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (6, 'Sophie', 'Martin', 1985, 321789654, 'Innovative pastry chef with a passion for desserts', NULL, 36, 12, 'Dessert Diva', 'Desserts');
INSERT INTO chef (chef_id, first_name, last_name, birth_year, phone_number, image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) VALUES (7, 'Miguel', 'Gonzalez', 1975, 654987321, 'Master of Mexican cuisine and traditional dishes', NULL, 46, 22, 'Mexican Food Expert', 'Mexican');

-- INSERT operation on episode table
INSERT INTO episode(episode_number, season_number) VALUES (1, 1);

-- INSERT operation on judge_in_episode table
INSERT INTO judge_in_episode(chef_id, episode_number, season_number, judge_number) VALUES (3, 1, 1, 1);

-- INSERT operation on scores table
INSERT INTO scores(chef_id, episode_number, season_number, cousine_name, recipe_id, score_1, score_2, score_3, total_score) VALUES (1, 1, 1, 'Asian', 1, 2, 4, 4, 3);

-- DELETE operation on scores table
DELETE FROM scores WHERE chef_id = 1;
