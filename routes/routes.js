const express = require('express');
const pool = require('../server'); // Import the MySQL connection pool
const session = require('express-session'); //for managing logged-in users during sessions
const router = express.Router();

// Define routes
router.get('/food_group', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM food_group');
        res.render('foodGroup', { rows });
    } catch (error) {
        console.error('Error fetching food_group:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/theme', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM theme');
        res.render('theme', { rows });
    } catch (error) {
        console.error('Error fetching theme:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/chef', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM chef');
        res.render('chef', { rows });
    } catch (error) {
        console.error('Error fetching chef:', error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
