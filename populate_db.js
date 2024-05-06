const fs = require('fs');
const pool = require('./server');

async function populate_db() {
    try {
        // Start a transaction
        const connection = await pool.getConnection();
        await connection.beginTransaction();

        try {
            // populate database
            // Read the SQL file content
            const createFilePath = './SQL/populate_db.sql';
            const sqlPopulate = fs.readFileSync(createFilePath, 'utf-8');

            // Execute the SQL commands
            await connection.query(sqlPopulate);

            console.log('Database populated successfully');

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

populate_db();