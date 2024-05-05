const mysql = require('mysql2/promise');

// Create connection pool to MySQL database
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'db_proj_119-24'
});

module.exports = pool;
