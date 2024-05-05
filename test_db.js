const pool = require('./server');

async function test_db() {
    try {
        // Start a transaction
        const connection = await pool.getConnection();
        await connection.beginTransaction();

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
    
            // DELETE operation on food_group
            await pool.query(
                'DELETE FROM food_group WHERE food_group_id = ?',
                [1]
            );
    
            await pool.query(
                'DELETE FROM food_group WHERE group_name = ?',
                ['vegetables']
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

            // This query is designed to fail due to unique constraint violation
            await pool.query(
                'INSERT INTO theme(theme_name, theme_description) VALUES (?, ?)',
                ['flaming hot', 'same primary but different attribute']
            );

            await pool.query(
                'INSERT INTO theme(theme_name, theme_description) VALUES (?, ?)',
                ['Under the Sea', 'Exotic seafood recipes with unusual ingredients!']
            );

            // DELETE operations on theme
            await pool.query(
                'DELETE FROM theme WHERE theme_name = ?',
                ['flaming hot']
            );

            await pool.query(
                'DELETE FROM theme WHERE theme_description = ?',
                ['Exotic seafood recipes with unusual ingredients!']
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
                ['Asian']
            );

            // UPDATE operation on cousine table
            await pool.query(
                'UPDATE cousine SET cousine_name = ? WHERE cousine_name = ?',
                ['asian', 'asian']
            );

            // INSERT operation on tag table
            await pool.query(
                'INSERT INTO tag(tag_name) VALUES (?)',
                ['quick and easy']
            );

            // INSERT operation on ingridient table
            await pool.query(
                'INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (?, ?, ?)',
                [1, 'ground meat', 1]
            );

            // SELECT operation on ingridient table
            const [foodGroupIdRows, _] = await pool.query(
                'SELECT food_group_id FROM food_group WHERE group_name = ?',
                ['red meat']
            );

            if (foodGroupIdRows.length > 0) {
                const foodGroupId = foodGroupIdRows[0].food_group_id;
                const [ingridientRows, __] = await pool.query(
                    'SELECT ingridient_name FROM ingridient WHERE food_group_id = ?',
                    [foodGroupId]
                );
                console.log('Ingridients for red meat:', ingridientRows);
            }

            await pool.query(
                'INSERT INTO ingridient(ingridient_id, ingridient_name, food_group_id) VALUES (?, ?, ?)',
                [2, 'apple', 3]
            );

            // DELETE operation on ingridient table
            await pool.query(
                'DELETE FROM ingridient WHERE ingridient_id = ?',
                [1]
            );

            // UPDATE operation on ingridient table
            await pool.query(
                'UPDATE ingridient SET ingridient_name = ?, food_group_id = ? WHERE ingridient_name = ?',
                ['broccoli', 2, 'ground meat']
            );

            console.log('ingridient table modifications completed successfully');

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