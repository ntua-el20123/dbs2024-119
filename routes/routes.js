const express = require('express');
const pool = require('../server'); // Import the MySQL connection pool
const session = require('express-session'); //for managing logged-in users during sessions
const router = express.Router();

// Define routes
router.get('/', async (req, res) => {
    try {
        res.render('homePage',{ sessionUser: req.session.user});
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

router.get('/chef', async (req, res) => {
    try {
        const [rows, fields] = await pool.query('SELECT * FROM chef');
        res.render('chef', { rows });
    } catch (error) {
        console.error('Error fetching chef:', error);
        res.status(500).send('Internal Server Error');
    }
});

router.get('/login', async (req,res) => {
    try{
        var sql_query = 'SELECT username,_password FROM chef';
        const [rows,fields] = await pool.query(sql_query);
        //DEBUG
        console.log(rows)
        row = rows[0]
        console.log(row.username,row._password)
        res.render('login',{ users: rows });
    }
    catch(e){
        console.error('Error loading log-in page');
        console.error(e.stack);
        res.status(500).send('Server Error');
    }
});

router.post('/login', async (req,res) =>{
    const {username,password} = req.body;
    req.session.user = {username};
    console.log(req.session.user)
})


module.exports = router;
