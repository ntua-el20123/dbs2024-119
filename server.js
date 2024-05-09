const mysql = require('mysql2/promise');

// Create connection pool to MySQL database
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'password',  //example password, change accordingly
    database: 'dblabV2', //'dbs2024-119' in create_db.sql it's dblabV2 so better keep it that way
    multipleStatements: true
});

module.exports = pool;
