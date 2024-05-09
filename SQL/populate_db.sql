-- INSERT operations on food_group table
INSERT INTO food_group(group_name, group_description) VALUES 
    ('Red Meat', 'Fatty and delicious but not very healthy'),
    ('Vegetables', 'Green and grassy, good for your health');


-- INSERT operations on theme table
INSERT INTO theme(theme_name, theme_description) VALUES 
    ('Flaming Hot', 'Cook with spices to create flavorful and spicy dishes'),
    ('Nose to Tail', 'Utilize as much of the protein provided as possible'),
    ('Quick and Easy', 'Simple and effortless recipes for busy individuals');


-- INSERT operations on cousine table
INSERT INTO cousine(cousine_name) VALUES 
    ('Asian'), ('Italian'), ('Spanish'), ('French'), ('Latin'), ('Desserts'), ('Mexican');


-- INSERT operations on tag table
INSERT INTO tag(tag_name) VALUES 
    ('Quick and Easy'), ('Healthy'), ('Vegetarian'), ('Gluten-Free'), ('Dairy-Free'), ('Asian');


-- INSERT operations on ingridient table
INSERT INTO ingridient(ingridient_name, food_group_id) VALUES 
    ('Beef', 1), ('Chicken', 1), ('Broccoli', 2), ('Tomato', 2);


-- INSERT operations on recipe table
INSERT INTO recipe(cooking_time, prep_time, difficulty, recipe_name, carbs_per_serving, fats_per_serving, proteins_per_serving, number_of_servings, meal_type, cousine_name, theme_name, main_ingridient_id) VALUES 
    ('00:30:00', '00:15:00', 3, 'Spaghetti Bolognese', 60, 20, 30, 4, 'Dinner', 'Italian', 'Flaming Hot', 1),
    ('01:00:00', '00:30:00', 4, 'Vegetable Stir-Fry', 40, 15, 20, 2, 'Lunch', 'Asian', 'Quick and Easy', 3);


-- INSERT operations on recipe_has_ingridient table (match all ingredients to recipes)
INSERT INTO recipe_has_ingridient(recipe_id, ingridient_id) VALUES 
    (1, 1), (1, 2), (2, 3), (2, 4);


-- INSERT operations on recipe_has_tag table (match all tags to recipes)
INSERT INTO recipe_has_tag(tag_name, recipe_id) VALUES 
    ('Quick and Easy', 1), ('Healthy', 1), ('Vegetarian', 2), ('Asian', 2);


-- INSERT operations on cooking_equipment table
INSERT INTO cooking_equipment(equipment_name, instructions, image_description) VALUES 
    ('Blender', 'Blend ingredients to a smooth consistency', 'A versatile kitchen appliance'),
    ('Grill', 'Cook food over an open flame or hot surface', 'Great for barbecue');


-- INSERT operations on recipe_has_cooking_equipment table (match all equipment to recipes)
INSERT INTO recipe_has_cooking_equipment(recipe_id, equipment_id) VALUES 
    (1, 1), (1, 2), (2, 3), (2, 4);


-- INSERT operations on tips table
INSERT INTO tips(tip_description, recipe_id) VALUES 
    ('Drizzle with olive oil before serving', 1),
    ('Prep all ingredients before starting cooking', 2);


-- INSERT operations on chef table
INSERT INTO chef(first_name, last_name, birth_year, phone_number, image_description, age, years_of_work_experience, professional_status, cousine_name) VALUES 
    ('Tony', 'Spaghetti', 1943, 698581581, 'The most decorated Italian chef of Asian cuisine', 79, 58, 'The Goat', 'Italian'),
    ('Jessica', 'Smith', 1978, 556892341, 'Award-winning chef specializing in French cuisine', 44, 20, 'Master Chef', 'French');


-- INSERT operations on episode table
INSERT INTO episode(episode_number, season_number) VALUES 
    (1, 1), (2, 1), (3, 1), (4, 2), (5, 2);


-- INSERT operations on judge_in_episode table (match chefs as judges in some episodes)
INSERT INTO judge_in_episode(chef_id, episode_number, season_number, judge_number) VALUES 
    (3, 1, 1, 1), (5, 1, 1, 2), (2, 2, 1, 1), (4, 2, 1, 2);


-- INSERT operations on scores table (create random scores for player-chefs in all episodes)
INSERT INTO scores(chef_id, episode_number, season_number, cousine_name, recipe_id, score_1, score_2, score_3, total_score) VALUES 
    (1, 1, 1, 'Italian', 1, 4, 5, 3, 4),
    (2, 1, 1, 'French', 2, 3, 4, 4, 3);

