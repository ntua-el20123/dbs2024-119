const express = require('express');
const pool = require('../server'); // Import the MySQL connection pool
const session = require('express-session'); //for managing logged-in users during sessions
const router = express.Router();

// Define routes
router.get('/food_group', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM food_group');
        res.render('food_group', { rows });
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

router.get('/cousine', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM cousine');
        res.render('cousine', { rows });
    } catch (error) {
        console.error('Error fetching cousine:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/tag', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM tag');
        res.render('tag', { rows });
    } catch (error) {
        console.error('Error fetching tag:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/ingredient', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM ingredient');
        res.render('ingredient', { rows });
    } catch (error) {
        console.error('Error fetching ingredient:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe');
        res.render('recipe', { rows });
    } catch (error) {
        console.error('Error fetching recipe:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe_has_ingredient', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe_has_ingredient');
        res.render('recipe_has_ingredient', { rows });
    } catch (error) {
        console.error('Error fetching recipe_has_ingredient:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe_has_tag', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe_has_tag');
        res.render('recipe_has_tag', { rows });
    } catch (error) {
        console.error('Error fetching recipe_has_tag:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/cooking_equipment', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM cooking_equipment');
        res.render('cooking_equipment', { rows });
    } catch (error) {
        console.error('Error fetching cooking_equipment:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/recipe_has_cooking_equipment', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM recipe_has_cooking_equipment');
        res.render('recipe_has_cooking_equipment', { rows });
    } catch (error) {
        console.error('Error fetching recipe_has_cooking_equipment:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/tips', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM tips');
        res.render('tips', { rows });
    } catch (error) {
        console.error('Error fetching tips:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/steps', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM steps');
        res.render('steps', { rows });
    } catch (error) {
        console.error('Error fetching steps:', error);
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

router.get('/specializes_in', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM specializes_in');
        res.render('specializes_in', { rows });
    } catch (error) {
        console.error('Error fetching specializes_in:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/episode', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM episode');
        res.render('episode', { rows });
    } catch (error) {
        console.error('Error fetching episode:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/judge_in_episode', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM judge_in_episode');
        res.render('judge_in_episode', { rows });
    } catch (error) {
        console.error('Error fetching judge_in_episode:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/scores', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM scores');
        res.render('scores', { rows });
    } catch (error) {
        console.error('Error fetching scores:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/cook_has_recipe', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM cook_has_recipe');
        res.render('cook_has_recipe', { rows });
    } catch (error) {
        console.error('Error fetching cook_has_recipe:', error);
        res.status(500).send('Internal Server Error');
    }
});

module.exports = router;
