const express = require('express');
const pool = require('../server'); // Import the MySQL connection pool
const session = require('express-session'); //for managing logged-in users during sessions
const router = express.Router();

// Define routes
router.get('/', async (req,res) => {
    try{
        res.render('login');
    }
    catch(e){
        console.error('Error loading log-in page');
        console.error(e.stack);
        res.status(500).send('Server Error');
    }
});

router.post('/', async (req,res) =>{
    try {
        //DEBUG
        console.log(req.body);
        const { username,password } = req.body;

        var sql_query = "SELECT username,_password FROM chef WHERE username = ?";
        const [rows,fields] = await pool.query(sql_query, [username]);
        //DEBUG
        console.log(rows)
        if (rows.length > 0 && rows[0]._password == password){
            req.session.user = {username: username, password: password};
            //DEBUG
            console.log(req.session.user);
            res.redirect('/main');
        }        
        else{
            console.log(`user: ${username} with password: ${password} not found`);
        }
        
    }
    catch(e){
        console.error('Error while parsing POST request body in /login: ',e);
        console.log(e.stack);
        res.status(500).send('Server Error');
    }
})


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

router.get('/signup',async (req,res) => {
    try{
        res.render('signUp.ejs');
    }
    catch(e){
        console.error('Error loading sign-up page')
        console.error(e.stack);
        res.status(500).send('Server Error');
    }
})

router.post('/signup', async (req,res) =>{
    try {
        const {username,password,first_name,last_name,birth_year,phone_number,age,years_of_work_experience,professional_status,cousine_name} = req.body;

        var sql_query = "INSERT INTO chef(username,_password,first_name, last_name, birth_year, phone_number, image_description, age, years_of_work_experience, professional_status, cousine_name)\
         VALUES (?,?,?,?,?,?,NULL,?,?,?,?)";

        await pool.query(sql_query,[username,password,first_name,last_name,birth_year,phone_number,age,years_of_work_experience,professional_status,cousine_name]);
        
        //make the new user the session user
        req.session.user = { username: username, password: password};

        //redirect to homepage
        res.redirect('/main');
    }
    catch(e){
        console.error('Error while parsing POST request body in /login: ',e);
        console.log(e.stack);
        res.status(500).send('Server Error');
    }
})

router.get('/main', async (req,res) =>{
    try {
        const {username,password} = req.session.user;
        //DEBUG
        //console.log(username);

        var sql_query = "SELECT*  FROM chef WHERE username = ?";
        const [rows,field] = await pool.query(sql_query,[username]);
        //DEBUG
        //console.log(`sql query rows: ${rows[0]} at main.`);
        res.render('main.ejs',{chef: rows[0]});
    }
    catch(e){
        console.error('Error loading main page: ',e);
        console.log(e.stack);
        res.status(500).send('Server Error');
    }
})

router.get('/main/recipes',async (req,res) => {
   try{
    const {username,password} = req.session.user;

    var sql_query = "SELECT recipe.*\
    FROM cook_has_recipe \
    JOIN recipe ON cook_has_recipe.recipe_id = recipe.recipe_id \
    WHERE cook_has_recipe.chef_id = ( \
        SELECT chef_id FROM chef WHERE username = 'Chef 1'\
    );";
    const [rows,fields] = await pool.query(sql_query,[username]);

    res.render('recipes.ejs',{recipes: rows})
   }
   catch(e){
    console.error('Error loading recipes page');
    console.log(e.stack);
    res.status(500).send('Server Error');
    }
})

router.get('/main/recipes/:recipeID', async (req,res) =>{
    try{
        const recipeID = req.params.recipeID;
        //DEBUG
        //console.log(`recipeID:${recipeID}`);

        sql_query = "SELECT recipe.*,ingridient.ingridient_name FROM ingridient\
        JOIN recipe ON recipe.main_ingridient_id = ingridient.ingridient_id\
        WHERE ingridient.ingridient_id = ?;"
        const [rows,fields] = await pool.query(sql_query,[recipeID])

        res.render('recipeInfo.ejs',{recipe: rows[0]});
    }
    catch(e){
        console.error('Error loading recipeID page');
        console.log(e.stack);
        res.status(500).send('Server Error');
        }
})

module.exports = router;
