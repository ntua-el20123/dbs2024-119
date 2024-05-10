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
    ('Asian'), ('Italian'), ('Spanish'), ('French'), ('Latin'), ('Desserts'), ('Mexican'), ('Healthy'), ('Gluten-Free'), ('Vegetarian'), ('Quick and Easy');


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


-- INSERT operations on cooking_equipment table (20)
INSERT INTO cooking_equipment(equipment_name, instructions, image_description) VALUES 
    ('Blender', 'Blend ingredients to a smooth consistency', 'A versatile kitchen appliance'),
    ('Grill', 'Cook food over an open flame or hot surface', 'Great for barbecue'),
    ('Wok', 'Cook food quickly over high heat', 'Traditional Asian cooking vessel'),
    ('Oven', 'Bake or roast food in a closed chamber', 'Essential for baking'),
    ('Saucepan', 'Cook food in liquid over low heat', 'Great for making sauces'),
    ('Frying Pan', 'Cook food over medium heat with a small amount of oil', 'Perfect for frying'),
    ('Knife', 'Cut and chop ingredients with precision', 'A chef''s best friend'),
    ('Cutting Board', 'Prepare ingredients on a flat surface', 'Protect your countertops'),
    ('Mixing Bowl', 'Combine ingredients for recipes', 'Essential for baking'),
    ('Measuring Cup', 'Measure liquid and dry ingredients accurately', 'For precise cooking'),
    ('Spatula', 'Flip and turn food while cooking', 'Great for pancakes'),
    ('Whisk', 'Mix ingredients together to incorporate air', 'For light and fluffy dishes'),
    ('Tongs', 'Pick up and turn food while cooking', 'Great for grilling'),
    ('Peeler', 'Remove the skin from fruits and vegetables', 'Make food prep easier'),
    ('Colander', 'Drain liquid from food items', 'Great for pasta'),
    ('Grater', 'Shred cheese and vegetables into small pieces', 'For adding texture to dishes'),
    ('Rolling Pin', 'Flatten dough for baking', 'Essential for making pies'),
    ('Mixer', 'Mix ingredients together quickly and easily', 'Great for baking'),
    ('Strainer', 'Separate liquid from solid ingredients', 'For making sauces'),
    ('Skillet', 'Cook food over high heat with a small amount of oil', 'Great for searing'),
    ('Baking Sheet', 'Bake cookies, pastries, and other items in the oven', 'For baking');


-- INSERT operations on recipe_has_cooking_equipment table (match all equipment to recipes)
INSERT INTO recipe_has_cooking_equipment(recipe_id, equipment_id) VALUES 
    (1, 1), (1, 2), (2, 3), (2, 4);


-- INSERT operations on tips table
INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES 
    (1, 'Drizzle with olive oil before serving', 1),
    (2, 'Prep all ingredients before starting cooking', 2);


-- INSERT operations on chef table
INSERT INTO chef(first_name, last_name, birth_year, phone_number, image_description, age, years_of_work_experience, professional_status, cousine_name) VALUES 
    ('John', 'Doe', 1985, 123456789, 'Up-and-coming chef with a passion for fusion cuisine', 36, 10, 'Rising Star', 'Asian'),
    ('Emily', 'Johnson', 1990, 987654321, 'Innovative chef known for her creative desserts', 31, 8, 'Pastry Genius', 'Desserts'),
    ('Michael', 'Brown', 1975, 555555555, 'Experienced chef specializing in Spanish cuisine', 46, 22, 'Mediterranean Maestro', 'Spanish'),
    ('Sarah', 'Wilson', 1982, 111111111, 'Talented chef with a flair for Latin American flavors', 39, 15, 'Latin Lover', 'Latin'),
    ('David', 'Miller', 1995, 999999999, 'Young and ambitious chef with a passion for healthy cooking', 26, 5, 'Fit Foodie', 'Healthy'),
    ('Jennifer', 'Anderson', 1988, 777777777, 'Versatile chef known for her expertise in gluten-free cuisine', 33, 12, 'Gluten-Free Guru', 'Gluten-Free'),
    ('Robert', 'Taylor', 1970, 444444444, 'Renowned chef specializing in French cuisine', 51, 28, 'French Master', 'French'),
    ('Amy', 'Thomas', 1980, 222222222, 'Inventive chef known for her modern take on Italian classics', 41, 18, 'Italian Innovator', 'Italian'),
    ('Daniel', 'Wilson', 1992, 888888888, 'Passionate chef with a focus on Mexican cuisine', 29, 7, 'Mexican Maverick', 'Mexican'),
    ('Michelle', 'Lee', 1977, 333333333, 'Skilled chef specializing in dairy-free and vegan dishes', 44, 21, 'Vegan Virtuoso', 'Vegetarian'),
    ('Christopher', 'Harris', 1984, 666666666, 'Creative chef known for his innovative use of ingredients', 37, 11, 'Culinary Artist', 'Quick and Easy'),
    ('Amanda', 'Clark', 1991, 555555555, 'Talented chef with a passion for seafood', 30, 6, 'Seafood Sensation', 'Asian'),
    ('Matthew', 'Walker', 1978, 444444444, 'Experienced chef specializing in Italian cuisine', 43, 19, 'Italian Maestro', 'Italian'),
    ('Stephanie', 'Baker', 1983, 333333333, 'Inventive chef known for her fusion of Asian and French flavors', 38, 13, 'Asian-French Fusion', 'Asian'),
    ('Andrew', 'Robinson', 1994, 222222222, 'Young and talented chef with a passion for healthy and flavorful dishes', 27, 4, 'Healthy Flavorist', 'Healthy'),
    ('Melissa', 'Young', 1987, 111111111, 'Versatile chef known for her expertise in gluten-free and dairy-free cuisine', 34, 9, 'Free-From Foodie', 'Gluten-Free'),
    ('Jonathan', 'Hill', 1972, 999999999, 'Renowned chef specializing in Spanish and Latin American cuisine', 49, 26, 'Hispanic Gourmet', 'Spanish'),
    ('Laura', 'Carter', 1989, 888888888, 'Innovative chef known for her modern take on French classics', 32, 14, 'French Innovator', 'French'),
    ('Kevin', 'Turner', 1976, 777777777, 'Passionate chef with a focus on Mexican and Latin American cuisine', 45, 20, 'Mexican-Latin Fusion', 'Mexican'),
    ('Rachel', 'Scott', 1993, 666666666, 'Skilled chef specializing in vegetarian and vegan dishes', 28, 5, 'Plant-Based Pro', 'Vegetarian'),
    ('Thomas', 'Barnes', 1981, 555555555, 'Creative chef known for his quick and easy recipes', 40, 16, 'Effortless Chef', 'Quick and Easy'),
    ('Olivia', 'Parker', 1996, 444444444, 'Talented chef with a passion for Asian cuisine', 25, 3, 'Asian Aficionado', 'Asian'),
    ('William', 'Cook', 1979, 333333333, 'Experienced chef specializing in Italian and French cuisine', 42, 17, 'Mediterranean Master', 'Italian'),
    ('Jessica', 'Wright', 1984, 222222222, 'Inventive chef known for her fusion of Latin American and Asian flavors', 37, 12, 'Latin-Asian Fusion', 'Latin'),
    ('Daniel', 'Harris', 1997, 111111111, 'Young and talented chef with a passion for healthy and flavorful dishes', 24, 2, 'Healthy Flavorist', 'Healthy'),
    ('Emily', 'Young', 1988, 999999999, 'Versatile chef known for her expertise in gluten-free and dairy-free cuisine', 33, 8, 'Free-From Foodie', 'Gluten-Free'),
    ('Michael', 'Hill', 1973, 888888888, 'Renowned chef specializing in Spanish and Latin American cuisine', 48, 25, 'Hispanic Gourmet', 'Spanish'),
    ('Sarah', 'Carter', 1990, 777777777, 'Innovative chef known for her modern take on French classics', 31, 13, 'French Innovator', 'French'),
    ('David', 'Turner', 1977, 666666666, 'Passionate chef with a focus on Mexican and Latin American cuisine', 44, 19, 'Mexican-Latin Fusion', 'Mexican'),
    ('Jennifer', 'Scott', 1982, 555555555, 'Skilled chef specializing in vegetarian and vegan dishes', 39, 14, 'Plant-Based Pro', 'Vegetarian'),
    ('Robert', 'Barnes', 1995, 444444444, 'Creative chef known for his quick and easy recipes', 26, 4, 'Effortless Chef', 'Quick and Easy'),
    ('Amy', 'Parker', 1989, 333333333, 'Talented chef with a passion for Asian cuisine', 32, 10, 'Asian Aficionado', 'Asian'),
    ('Daniel', 'Cook', 1974, 222222222, 'Experienced chef specializing in Italian and French cuisine', 47, 24, 'Mediterranean Master', 'Italian'),
    ('Michelle', 'Wright', 1985, 111111111, 'Inventive chef known for her fusion of Latin American and Asian flavors', 36, 11, 'Latin-Asian Fusion', 'Latin'),
    ('Christopher', 'Harris', 1998, 999999999, 'Young and talented chef with a passion for healthy and flavorful dishes', 23, 1, 'Healthy Flavorist', 'Healthy'),
    ('Amanda', 'Young', 1986, 888888888, 'Versatile chef known for her expertise in gluten-free and dairy-free cuisine', 35, 7, 'Free-From Foodie', 'Gluten-Free'),
    ('Matthew', 'Hill', 1971, 777777777, 'Renowned chef specializing in Spanish and Latin American cuisine', 50, 27, 'Hispanic Gourmet', 'Spanish'),
    ('Stephanie', 'Carter', 1987, 666666666, 'Innovative chef known for her modern take on French classics', 34, 12, 'French Innovator', 'French'),
    ('Andrew', 'Turner', 1974, 555555555, 'Passionate chef with a focus on Mexican and Latin American cuisine', 47, 18, 'Mexican-Latin Fusion', 'Mexican'),
    ('Melissa', 'Scott', 1991, 444444444, 'Skilled chef specializing in vegetarian and vegan dishes', 30, 13, 'Plant-Based Pro', 'Vegetarian'),
    ('Jonathan', 'Barnes', 1976, 333333333, 'Creative chef known for his quick and easy recipes', 45, 16, 'Effortless Chef', 'Quick and Easy'),
    ('Laura', 'Parker', 1983, 222222222, 'Talented chef with a passion for Asian cuisine', 38, 9, 'Asian Aficionado', 'Asian'),
    ('Kevin', 'Cook', 1970, 111111111, 'Experienced chef specializing in Italian and French cuisine', 51, 23, 'Mediterranean Master', 'Italian'),
    ('Rachel', 'Wright', 1986, 999999999, 'Inventive chef known for her fusion of Latin American and Asian flavors', 35, 10, 'Latin-Asian Fusion', 'Latin'),
    ('Thomas', 'Harris', 1999, 888888888, 'Young and talented chef with a passion for healthy and flavorful dishes', 22, 3, 'Healthy Flavorist', 'Healthy'),
    ('Olivia', 'Young', 1985, 777777777, 'Versatile chef known for her expertise in gluten-free and dairy-free cuisine', 36, 6, 'Free-From Foodie', 'Gluten-Free'),
    ('William', 'Hill', 1972, 666666666, 'Renowned chef specializing in Spanish and Latin American cuisine', 49, 25, 'Hispanic Gourmet', 'Spanish'),
    ('Jessica', 'Carter', 1988, 555555555, 'Innovative chef known for her modern take on French classics', 33, 11, 'French Innovator', 'French'),
    ('Daniel', 'Turner', 1975, 444444444, 'Passionate chef with a focus on Mexican and Latin American cuisine', 46, 17, 'Mexican-Latin Fusion', 'Mexican'),
    ('Emily', 'Scott', 1992, 333333333, 'Skilled chef specializing in vegetarian and vegan dishes', 29, 12, 'Plant-Based Pro', 'Vegetarian'),
    ('Michael', 'Barnes', 1977, 222222222, 'Creative chef known for his quick and easy recipes', 44, 15, 'Effortless Chef', 'Quick and Easy');    

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

