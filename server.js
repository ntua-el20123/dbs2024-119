const mysql = require('mysql2/promise');

// Create connection pool to MySQL database
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'dbs2024-119',
    multipleStatements: true
});

module.exports = pool;
