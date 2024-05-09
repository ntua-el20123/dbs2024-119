use dblabV2;

-- Insert random dummy data into food_group table
INSERT INTO food_group (group_name, group_description)
VALUES
    ('Meat', 'Various types of meat'),
    ('Vegetables', 'Assorted vegetables'),
    ('Fruits', 'Different kinds of fruits'),
    ('Seafood', 'Fish and seafood'),
    ('Grains', 'Different grains and cereals');

-- Insert random dummy data into theme table
INSERT INTO theme (theme_name, theme_description)
VALUES
    ('Spicy Dishes', 'Recipes with a spicy twist'),
    ('Healthy Choices', 'Nutritious and balanced meals'),
    ('Desserts Galore', 'Indulgent dessert recipes');

-- Insert random dummy data into cousine table
INSERT INTO cousine (cousine_name)
VALUES
    ('Italian'),
    ('Asian'),
    ('Mexican'),
    ('Mediterranean'),
    ('Indian');

-- Insert random dummy data into tag table
INSERT INTO tag (tag_name)
VALUES
    ('Quick and Easy'),
    ('Vegetarian'),
    ('Low Carb'),
    ('Family Friendly'),
    ('Gluten Free');

-- Insert at least 100 random dummy data into ingridient table
DELIMITER //

CREATE PROCEDURE InsertIngredients(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE ingridient_name VARCHAR(45);

    WHILE i <= num DO
        SET ingridient_name = CONCAT('Ingredient ', i);

        INSERT INTO ingridient (ingridient_name, food_group_id)
        VALUES
            (ingridient_name, FLOOR(1 + RAND() * 5)); -- Random food_group_id between 1 and 5

        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

CALL InsertIngredients(100); -- Call the procedure to insert 100 ingredients

-- Insert at least 50 random dummy data into recipe table
DELIMITER //

CREATE PROCEDURE InsertRecipes(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE recipe_name VARCHAR(45);

    WHILE i <= num DO
        SET recipe_name = CONCAT('Recipe ', i);

        INSERT INTO recipe (cooking_time, prep_time, difficulty, recipe_name, carbs_per_serving, fats_per_serving, proteins_per_serving, total_calories, number_of_servings, meal_type, cousine_name, theme_name, main_ingridient_id)
        VALUES
            (SEC_TO_TIME(FLOOR(600 + RAND() * 1800)), -- Random cooking time between 10 minutes and 30 minutes
             SEC_TO_TIME(FLOOR(300 + RAND() * 1200)), -- Random prep time between 5 minutes and 20 minutes
             FLOOR(1 + RAND() * 5), -- Random difficulty level between 1 and 5
             recipe_name,
             FLOOR(10 + RAND() * 50), -- Random carbs per serving between 10g and 60g
             FLOOR(5 + RAND() * 30), -- Random fats per serving between 5g and 35g
             FLOOR(10 + RAND() * 40), -- Random proteins per serving between 10g and 50g
             FLOOR(200 + RAND() * 500), -- Random total calories between 200 and 700
             FLOOR(1 + RAND() * 6), -- Random number of servings between 1 and 6
             'Dinner', -- Hardcoded meal type for simplicity
             'Italian', -- Hardcoded cousine name for simplicity
             'Healthy Choices', -- Hardcoded theme name for simplicity
             FLOOR(1 + RAND() * 100)); -- Random main_ingridient_id between 1 and 100 (assuming at least 100 ingredients)

        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

CALL InsertRecipes(50); -- Call the procedure to insert 50 recipes

-- Insert at least 50 random dummy data into chef table
DELIMITER //

CREATE PROCEDURE InsertChefs(IN num INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE first_name VARCHAR(45);
    DECLARE last_name VARCHAR(45);

    WHILE i <= num DO
        SET first_name = CONCAT('Chef ', i);
        SET last_name = 'Smith'; -- Hardcoded last name for simplicity

        INSERT INTO chef (username,_password,first_name, last_name, birth_year, phone_number, age, years_of_work_experience, professional_status, cousine_name)
        VALUES

            (first_name,
             last_name,
             first_name, -- use the first name as the username
             'password', -- hard code the password for simplicity
             FLOOR(1960 + RAND() * 40), -- Random birth year between 1960 and 2000
             FLOOR(100000000 + RAND() * 900000000), -- Random phone number with 9 digits
             FLOOR(25 + RAND() * 40), -- Random age between 25 and 65
             FLOOR(5 + RAND() * 40), -- Random years of work experience between 5 and 45
             'Head Chef', -- Hardcoded professional status for simplicity
             'Italian'); -- Hardcoded cousine name for simplicity

        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

CALL InsertChefs(50); -- Call the procedure to insert 50 chefs

-- Insert at least 50 random dummy data into episode table
INSERT INTO episode (episode_number, season_number)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 3),
    (8, 3),
    (9, 3),
    (10, 4),
    (11, 4),
    (12, 4),
    (13, 5),
    (14, 5),
    (15, 5),
    (16, 6),
    (17, 6),
    (18, 6),
    (19, 7),
    (20, 7),
    (21, 7),
    (22, 8),
    (23, 8),
    (24, 8),
    (25, 9),
    (26, 9),
    (27, 9),
    (28, 10),
    (29, 10),
    (30, 10),
    (31, 11),
    (32, 11),
    (33, 11),
    (34, 12),
    (35, 12),
    (36, 12),
    (37, 13),
    (38, 13),
    (39, 13),
    (40, 14),
    (41, 14),
    (42, 14),
    (43, 15),
    (44, 15),
    (45, 15),
    (46, 16),
    (47, 16),
    (48, 16),
    (49, 17),
    (50, 17);

-- Insert random dummy data into judge_in_episode table
INSERT INTO judge_in_episode (chef_id, episode_number, season_number, judge_number)
SELECT
    chef_id,
    episode_number,
    season_number,
    1 AS judge_number -- Hardcoded judge_number for simplicity
FROM
    chef
CROSS JOIN
    episode
ORDER BY
    RAND()
LIMIT
    50; -- Select 50 random combinations of chef and episode for judges

-- Insert random dummy data into scores table
INSERT INTO scores (chef_id, episode_number, season_number, cousine_name, recipe_id,score_1,score_2,score_3, total_score)
SELECT
    chef_id,
    episode_number,
    season_number,
    'Italian' AS cousine_name, -- Hardcoded cousine_name for simplicity
    recipe_id,
    FLOOR(1 + RAND() * 5) AS score_1, -- Random score between 1 and 5
    FLOOR(1 + RAND() * 5) AS score_2, -- Random score between 1 and 5
    FLOOR(1 + RAND() * 5) AS score_3, -- Random score between 1 and 5
    (score_1 + score_2 + score_3) / 3.0 AS total_score -- Calculate total score as average
FROM
    chef
CROSS JOIN
    episode
CROSS JOIN
    recipe
ORDER BY
    RAND()
LIMIT
    50; -- Select 50 random combinations of chef, episode, and recipe for scores
