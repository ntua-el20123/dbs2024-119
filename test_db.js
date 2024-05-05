const fs = require('fs');
const pool = require('./server');

async function test_db() {
    try {
        // Start a transaction
        const connection = await pool.getConnection();
        await connection.beginTransaction();

        // CREATE database
        // Read the SQL file content
        const sqlFilePath = './SQL/create_database_V2.sql';
        const sql = fs.readFileSync(sqlFilePath, 'utf-8');

        // Execute the SQL commands
        await connection.query(sql);

        try {
            // INSERT opereation on food_group
            await pool.query(
                'INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (?, ?, ?)',
                [1,'red meat','fatty and delicious but not very healthy']
            );
    
            await pool.query(
                'INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (?, ?, ?)',
                [2,'vegetables','green and grassy and good for your health']
    
            );
    
            await pool.query(
                'INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (?, ?, ?)',
                [5,'fruits','great for salads and smoothies']
            );

            await pool.query(
                'INSERT INTO food_group(food_group_id,group_name,group_description) VALUES (?, ?, ?)',
                [7,'fish','scaly and slimy but delicious']
            );
    
            // DELETE operation on food_group    
            await pool.query(
                'DELETE FROM food_group WHERE group_name = ?',
                ['fish']
            );
    
            // UPDATE operation on food_group
            await pool.query(
                'UPDATE food_group SET group_name = ? WHERE group_name = ?',
                ['meat', 'red meat']
            );
    
            await pool.query(
                'UPDATE food_group SET group_name = ? WHERE food_group_id = ?',
                ['red meat', 1]
            );
    
            await pool.query(
                'UPDATE food_group SET food_group_id = ? WHERE food_group_id = ?',
                [3, 5]
            );

            console.log('food_group table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operations on theme
            await pool.query(
                'INSERT INTO theme(theme_name, theme_description) VALUES (?, ?)',
                ['flaming hot', 'cook with spices to create the most flavorful and spicy dishes possible!']
            );

            await pool.query(
                'INSERT INTO theme(theme_name, theme_description) VALUES (?, ?)',
                ['nose to tail', 'cook utilizing as much of the protein provided as possible!']
            );

            // This query is designed to fail due to unique constraint violation
            /*
            await pool.query(
                'INSERT INTO theme(theme_name, theme_description) VALUES (?, ?)',
                ['flaming hot', 'same primary but different attribute']
            );
            */

            await pool.query(
                'INSERT INTO theme(theme_name, theme_description) VALUES (?, ?)',
                ['Under the Sea', 'Exotic seafood recipes with unusual ingridients!']
            );

            // DELETE operations on theme
            await pool.query(
                'DELETE FROM theme WHERE theme_name = ?',
                ['nose to tail']
            );

            await pool.query(
                'DELETE FROM theme WHERE theme_description = ?',
                ['Exotic seafood recipes with unusual ingridients!']
            );

            // UPDATE operations on theme
            await pool.query(
                'UPDATE theme SET theme_name = ? WHERE theme_name = ?',
                ['hot', 'flaming hot']
            );

            await pool.query(
                'UPDATE theme SET theme_name = ? WHERE theme_name = ?',
                ['flaming hot', 'hot']
            );

            console.log('food_group table modifications completed successfully');
            
            //------------------------------------------------------------------//

            // INSERT operations on cousine table
            await pool.query(
                'INSERT INTO cousine(cousine_name) VALUES (?)',
                ['Asian']
            );

            await pool.query(
                'INSERT INTO cousine(cousine_name) VALUES (?)',
                ['Italian']
            );

            await pool.query(
                'INSERT INTO cousine(cousine_name) VALUES (?)',
                ['Middle-Eastern']
            );

            await pool.query(
                'INSERT INTO cousine(cousine_name) VALUES (?)',
                ['French']
            );

            // DELETE operation on cousine table
            await pool.query(
                'DELETE FROM cousine WHERE cousine_name = ?',
                ['Middle-Eastern']
            );

            // UPDATE operation on cousine table
            await pool.query(
                'UPDATE cousine SET cousine_name = ? WHERE cousine_name = ?',
                ['asian', 'asian']
            );

            console.log('cousine table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on tag table
            await pool.query(
                'INSERT INTO tag(tag_name) VALUES (?)',
                ['quick and easy']
            );

            console.log('tag table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on ingridient table
            await pool.query(
                'INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (?, ?, ?)',
                [1, 'ground meat', 1]
            );

            await pool.query(
                'INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (?, ?, ?)',
                [2, 'apple', 3]
            );

            await pool.query(
                'INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (?, ?, ?)',
                [3, 'pear', 3]
            );

            // DELETE operation on ingridient table
            await pool.query(
                'DELETE FROM ingridient WHERE ingridient_id = ?',
                [3]
            );

            // UPDATE operation on ingridient table
            await pool.query(
                'UPDATE ingridient SET ingridient_name = ?, food_group_id = ? WHERE ingridient_name = ?',
                ['broccoli', 2, 'ground meat']
            );

            console.log('ingridient table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on recipe table
            await pool.query(
                `INSERT INTO recipe(recipe_id, cooking_time, prep_time, difficulty, recipe_name, image, 
                carbs_per_serving, fats_per_serving, proteins_per_serving, total_calories, number_of_servings, 
                meal_type, cousine_name, theme_name, main_ingridient_id) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [1, 15, 5, 2, 'test recipe', null, 100, 100, 100, 300, 1, 'lunch', 'Italian', 'flaming hot', 1]
            );

            // UPDATE operation on recipe table
            await pool.query(
                'UPDATE recipe SET total_calories = ? WHERE recipe_id = ?',
                [301, 1]
            );

            console.log('recipe table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operations on recipe_has_ingridient table
            await pool.query(
                'INSERT INTO recipe_has_ingridient(recipe_id, ingridient_id) VALUES (?, ?)',
                [1, 1]
            );

            await pool.query(
                'INSERT INTO recipe_has_ingridient(recipe_id, ingridient_id) VALUES (?, ?)',
                [1, 2]
            );

            // DELETE operation on recipe_has_ingridient table
            await pool.query(
                'DELETE FROM recipe_has_ingridient WHERE recipe_id = ?',
                [1]
            );

            console.log('recipe_has_ingridient table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on recipe_has_tag table
            await pool.query(
                'INSERT INTO recipe_has_tag(tag_name, recipe_id) VALUES (?, ?)',
                ['quick and easy', 1]
            );

            // DELETE operation on recipe_has_tag table
            await pool.query(
                'DELETE FROM recipe_has_tag WHERE recipe_id = ?',
                [1]
            );

            console.log('recipe_has_tag table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on cooking_equipment table
            await pool.query(
                `INSERT INTO cooking_equipment(equipment_id, equipment_name, instructions, image, image_description) 
                VALUES (?, ?, ?, ?, ?)`,
                [1, 'blender', 'blend things', null, "it's a blender"]
            );

            console.log('cooking_equipment table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on recipe_has_cooking_equipment table
            await pool.query(
                'INSERT INTO recipe_has_cooking_equipment(recipe_id, equipment_id) VALUES (?, ?)',
                [1, 1]
            );

            await pool.query(
                'DELETE FROM recipe_has_cooking_equipment WHERE recipe_id = ?',
                [1]
            );

            console.log('recipe_has_cooking_equipment table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operations on tips table
            await pool.query(
                'INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES (?, ?, ?)',
                [1, 'Drizzle with the Rizzle', 1]
            );

            await pool.query(
                'INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES (?, ?, ?)',
                [2, 'Sprinkle the Mizzle Fizzle', 1]
            );

            await pool.query(
                'INSERT INTO tips(tip_number, tip_description, recipe_id) VALUES (?, ?, ?)',
                [3, 'Spike with heroin', 1]
            );

            // DELETE operation on tips table
            await pool.query(
                'DELETE FROM tips WHERE recipe_id = ?',
                [1]
            );

            console.log('tips table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on chef table
            await pool.query(
                `INSERT INTO chef(chef_id, first_name, last_name, birth_year, phone_number, 
                image_description, actual_image, age, years_of_work_experience, professional_status, cousine_name) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [1, 'Tony', 'Spaghetti', 1943, 698581581, 'the most decorated Italian chef of Asian cuisine', null, 89, 88, 'the goat', 'Italian']
            );

            console.log('chef table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on episode table
            await pool.query(
                'INSERT INTO episode(episode_number, season_number) VALUES (?, ?)',
                [1, 1]
            );

            console.log('episode table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on judge_in_episode table
            await pool.query(
                'INSERT INTO judge_in_episode(chef_id, episode_number, season_number, judge_number) VALUES (?, ?, ?, ?)',
                [1, 1, 1, 1]
            );

            console.log('judge_in_episode table modifications completed successfully');

            //------------------------------------------------------------------//

            // INSERT operation on scores table
            await pool.query(
                `INSERT INTO scores(chef_id, episode_number, season_number, cousine_name, recipe_id, 
                score_1, score_2, score_3, total_score) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [1, 1, 1, 'Asian', 1, 2, 4, 4, 3]
            );

            // DELETE operation on scores table
            await pool.query(
                'DELETE FROM scores WHERE chef_id = ?',
                [1]
            );

            console.log('scores table modifications completed successfully');

            //------------------------------------------------------------------//
            
            // Commit the transaction
            await connection.commit();

            console.log('Database modifications completed successfully');
        }
        catch (error) {
            // Rollback the transaction if any query fails
            await connection.rollback();
            throw error; // Re-throw the error to the outer catch block
        }
        finally {
            // Release the connection back to the pool
            connection.release();
        }
    }
    catch (error) {
        console.error('Error performing database modifications:', error);
    }
}

test_db();