const fs = require('fs');
const pool = require('./server');

async function test_db() {
    try {
        // Start a transaction
        const connection = await pool.getConnection();
        await connection.beginTransaction();

        try {
            // test database
            const testFilePath = './SQL/test_db.sql';
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
