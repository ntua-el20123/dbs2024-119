-- Inserting dummy data into the food_group table
INSERT INTO food_group (group_name, group_description) VALUES
('Grains', 'Food items made from wheat, rice, oats, cornmeal, barley, or another cereal grain'),
('Vegetables', 'Edible parts of plants that are consumed by humans or other animals as food'),
('Fruits', 'Edible parts of flowering plants that are consumed by humans or other animals as food');

-- Inserting dummy data into the theme table
INSERT INTO theme (theme_name, theme_description) VALUES
('Italian', 'Recipes inspired by Italian cuisine'),
('Mediterranean', 'Recipes inspired by Mediterranean cuisine'),
('Asian', 'Recipes inspired by Asian cuisine');

-- Inserting dummy data into the cousine table
INSERT INTO cousine (cousine_name) VALUES
('Italian'),
('Greek'),
('Chinese');

-- Inserting dummy data into the tag table
INSERT INTO tag (tag_name) VALUES
('Healthy'),
('Quick and Easy'),
('Vegetarian');

-- Inserting dummy data into the ingredient table
INSERT INTO ingridient (ingridient_name, food_group_id) VALUES
('Pasta', 1),
('Tomato', 2),
('Chicken', 2);

-- Inserting dummy data into the recipe table
INSERT INTO recipe (
    cooking_time, prep_time, difficulty, recipe_name, image, carbs_per_serving, 
    fats_per_serving, proteins_per_serving, total_calories, number_of_servings, 
    meal_type, cousine_name, theme_name, main_ingridient_id
) VALUES
('00:45:00', '00:20:00', 3, 'Spaghetti Bolognese', NULL, 50, 20, 30, 500, 4, 'Main Course', 'Italian', 'Italian', 1),
('01:00:00', '00:30:00', 4, 'Greek Salad', NULL, 20, 10, 5, 150, 2, 'Appetizer', 'Greek', 'Mediterranean', 2),
('00:30:00', '00:15:00', 2, 'Stir-Fried Chicken with Vegetables', NULL, 10, 15, 20, 250, 3, 'Main Course', 'Chinese', 'Asian', 3);

-- Inserting dummy data into the cooking_equipment table
INSERT INTO cooking_equipment (equipment_name, instructions, image, image_description) VALUES
('Pan', 'Use to cook food on the stovetop', NULL, NULL),
('Oven', 'Use to bake or roast food', NULL, NULL),
('Knife', 'Use to cut or chop ingredients', NULL, NULL);

-- Inserting dummy data into the chef table
-- Inserting dummy data into the chef table
INSERT INTO chef (
    first_name, last_name, birth_year, phone_number, image_description,
    actual_image, age, years_of_work_experience, professional_status
) VALUES
('John', 'Doe', '1980', 123456789, NULL, NULL, 44, 20, 'Head Chef'),
('Jane', 'Smith', '1990', 987654321, NULL, NULL, 34, 15, 'Sous Chef'),
('Michael', 'Johnson', '1975', 555123456, NULL, NULL, 49, 25, 'Executive Chef'),
('Emily', 'Brown', '1985', 666654321, NULL, NULL, 39, 18, 'Pastry Chef'),
('William', 'Taylor', '1982', 777765432, NULL, NULL, 42, 22, 'Sous Chef'),
('Christopher', 'Lee', '1987', 888876543, NULL, NULL, 37, 12, 'Line Cook'),
('Sarah', 'Wong', '1993', 999987654, NULL, NULL, 31, 8, 'Head Chef'),
('Olivia', 'Garcia', '1981', 111111111, NULL, NULL, 43, 19, 'Executive Sous Chef'),
('David', 'Martinez', '1989', 222222222, NULL, NULL, 35, 16, 'Sous Chef'),
('Alex', 'Johnson', '1984', 333333333, NULL, NULL, 40, 17, 'Executive Chef'),
('Emma', 'Brown', '1991', 444444444, NULL, NULL, 30, 9, 'Pastry Chef'),
('Daniel', 'Taylor', '1983', 555555555, NULL, NULL, 38, 21, 'Sous Chef'),
('Sophia', 'Lee', '1988', 666666666, NULL, NULL, 33, 14, 'Line Cook'),
('James', 'Wong', '1994', 777777777, NULL, NULL, 29, 7, 'Head Chef'),
('Ava', 'Garcia', '1980', 888888888, NULL, NULL, 44, 18, 'Executive Sous Chef'),
('Logan', 'Martinez', '1986', 999999999, NULL, NULL, 36, 15, 'Sous Chef'),
('Ella', 'Johnson', '1992', 111111111, NULL, NULL, 32, 10, 'Executive Chef'),
('Benjamin', 'Brown', '1983', 222222222, NULL, NULL, 38, 20, 'Pastry Chef'),
('Mia', 'Taylor', '1989', 333333333, NULL, NULL, 35, 13, 'Sous Chef'),
('Henry', 'Lee', '1985', 444444444, NULL, NULL, 39, 8, 'Line Cook'),
('Liam', 'Wong', '1991', 555555555, NULL, NULL, 30, 6, 'Head Chef'),
('Charlotte', 'Garcia', '1987', 666666666, NULL, NULL, 34, 17, 'Executive Sous Chef'),
('Amelia', 'Martinez', '1982', 777777777, NULL, NULL, 39, 14, 'Sous Chef'),
('Harper', 'Johnson', '1990', 888888888, NULL, NULL, 31, 9, 'Executive Chef'),
('Evelyn', 'Brown', '1988', 999999999, NULL, NULL, 33, 19, 'Pastry Chef'),
('Michael', 'Taylor', '1984', 111111111, NULL, NULL, 37, 12, 'Sous Chef'),
('William', 'Lee', '1993', 222222222, NULL, NULL, 28, 7, 'Line Cook'),
('James', 'Wong', '1981', 333333333, NULL, NULL, 40, 18, 'Head Chef'),
('Olivia', 'Garcia', '1989', 444444444, NULL, NULL, 32, 16, 'Executive Sous Chef'),
('David', 'Martinez', '1987', 555555555, NULL, NULL, 34, 11, 'Sous Chef'),
('Sophia', 'Johnson', '1992', 666666666, NULL, NULL, 29, 9, 'Executive Chef'),
('Emma', 'Brown', '1986', 777777777, NULL, NULL, 35, 20, 'Pastry Chef'),
('Daniel', 'Taylor', '1990', 888888888, NULL, NULL, 31, 15, 'Sous Chef'),
('Ava', 'Lee', '1984', 999999999, NULL, NULL, 37, 8, 'Line Cook'),
('Logan', 'Wong', '1991', 111111111, NULL, NULL, 30, 6, 'Head Chef'),
('Ella', 'Garcia', '1988', 222222222, NULL, NULL, 33, 17, 'Executive Sous Chef'),
('Benjamin', 'Martinez', '1983', 333333333, NULL, NULL, 38, 14, 'Sous Chef'),
('Mia', 'Johnson', '1989', 444444444, NULL, NULL, 32, 9, 'Executive Chef'),
('Henry', 'Brown', '1985', 555555555, NULL, NULL, 36, 19, 'Pastry Chef'),
('Liam', 'Taylor', '1992', 666666666, NULL, NULL, 29, 14, 'Sous Chef'),
('Charlotte', 'Lee', '1987', 777777777, NULL, NULL, 34, 7, 'Line Cook'),
('Amelia', 'Wong', '1993', 888888888, NULL, NULL, 28, 5, 'Head Chef'),
('Harper', 'Garcia', '1981', 999999999, NULL, NULL, 40, 16, 'Executive Sous Chef'),
('Evelyn', 'Martinez', '1989', 111111111, NULL, NULL, 32, 13, 'Sous Chef'),
('Michael', 'Johnson', '1984', 222222222, NULL, NULL, 37, 8, 'Executive Chef'),
('William', 'Brown', '1990', 333333333, NULL, NULL, 31, 18, 'Pastry Chef'),
('James', 'Taylor', '1986', 444444444, NULL, NULL, 35, 11, 'Sous Chef'),
('Olivia', 'Lee', '1991', 555555555, NULL, NULL, 30, 6, 'Line Cook'),
('David', 'Wong', '1987', 666666666, NULL, NULL, 34, 15, 'Head Chef'),
('Sophia', 'Garcia', '1983', 777777777, NULL, NULL, 38, 20, 'Executive Sous Chef'),
('Emma', 'Martinez', '1988', 888888888, NULL, NULL, 33, 17, 'Sous Chef'),
('Daniel', 'Johnson', '1984', 999999999, NULL, NULL, 37, 12, 'Executive Chef');

-- Inserting dummy data into the specializes_in table
INSERT INTO specializes_in (chef_id, cousine_name) VALUES
(1, 'Italian'),
(2, 'Greek');

-- Inserting dummy data into the episode table
INSERT INTO episode (episode_number, season_number) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1),
(1, 2), (2, 2), (3, 2), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10, 2),
(1, 3), (2, 3), (3, 3), (4, 3), (5, 3), (6, 3), (7, 3), (8, 3), (9, 3), (10, 3),
(1, 4), (2, 4), (3, 4), (4, 4), (5, 4), (6, 4), (7, 4), (8, 4), (9, 4), (10, 4),
(1, 5), (2, 5), (3, 5), (4, 5), (5, 5), (6, 5), (7, 5), (8, 5), (9, 5), (10, 5);

-- Inserting dummy data into the judge_in_episode table
INSERT INTO judge_in_episode (chef_id, episode_number, season_number, judge_number) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(1, 2, 1, 1),
(2, 2, 1, 2);

-- Inserting dummy data into the scores table
INSERT INTO scores (
    chef_id, episode_number, season_number, cousine_name, recipe_id, 
    score_1, score_2, score_3, total_score
) VALUES
(1, 1, 1, 'Italian', 1, 5, 4, 3, 4),
(2, 1, 1, 'Greek', 2, 4, 3, 5, 4.5),
(1, 2, 1, 'Italian', 1, 4, 5, 4, 4.33),
(2, 2, 1, 'Greek', 2, 3, 4, 5, 4),
(1, 1, 2, 'Italian', 1, 4, 5, 3, 4),
(2, 1, 2, 'Greek', 2, 5, 4, 3, 4),
(1, 2, 2, 'Italian', 1, 3, 4, 5, 4),
(2, 2, 2, 'Greek', 2, 4, 3, 5, 4.33);

-- Inserting dummy data into the cook_has_recipe table
INSERT INTO cook_has_recipe (chef_id, recipe_id) VALUES
(1, 1),
(2, 2),
(1, 3),
(2, 3);
