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
            // CREATE database
            // Read the SQL file content
            const createFilePath = './SQL/create_database_V2.sql';
            const sqlCreate = fs.readFileSync(createFilePath, 'utf-8');

            // Execute the SQL commands
            await connection.query(sqlCreate);

            console.log('Database created successfully');

            // test database
            const testFilePath = './SQL/test_queries_v2.sql';
            const sqlTest = fs.readFileSync(testFilePath, 'utf-8');

            await connection.query(sqlTest);

            console.log('Database tested successfully');

            // Commit the transaction
            await connection.commit();
            console.log('Transaction committed');

        }
        catch (error) {
            // Rollback the transaction if any query fails (undo all the changes made to the database)
            await connection.rollback();
            throw error; // Re-throw the error to the outer catch block
        }
        finally {
            // Close the connection
            if (connection) await connection.release();
        }
    }
    catch (error) {
        console.error('Error performing database modifications:', error);
    }

    pool.end();
}

test_db();