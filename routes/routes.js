const express = require('express');
const pool = require('../server'); // Import the MySQL connection pool

const router = express.Router();

// Define routes
router.get('/', async (req, res) => {
    try {
        res.status(200).send('OK');
    } catch (error) {
        console.error('Error fetching food:', error);
        res.status(500).send('Internal Server Error');
    }
});

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

module.exports = router;
