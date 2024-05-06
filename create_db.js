const fs = require('fs');
const pool = require('./server');

async function create_db() {
    try {
        // Start a transaction
        const connection = await pool.getConnection();
        await connection.beginTransaction();

        try {
            // CREATE database
            // Read the SQL file content
            const createFilePath = './SQL/create_db.sql';
            const sqlCreate = fs.readFileSync(createFilePath, 'utf-8');

            // Execute the SQL commands
            await connection.query(sqlCreate);

            console.log('Database created successfully');

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

create_db();