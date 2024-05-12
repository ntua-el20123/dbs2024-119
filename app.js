const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser'); // Import body-parser
const app = express();

// Set 'views' directory for any views being rendered
app.set('views', __dirname + '/views');

// Set EJS as the templating engine
app.set('view engine', 'ejs');

//secret key for handling user info during sessions
app.use(session({
    secret: "SecretKey",
    resave: false,
    saveUninitialized: false
}));

//bodyparser for req body 
app.use(bodyParser.urlencoded({ extended: true }));
//bodyparser for json (if needed) 
app.use(bodyParser.json());

//public folder for storing css files
app.use(express.static('public'));

// Import and use routes defined in routes.js
const routes = require('./routes/routes'); // Import the routes module
app.use('/', routes); // Mount routes under / path

// Start the server
const port = process.env.PORT || 4217;
app.listen(port, () => {
    console.log(`Server started on port ${port}!`);
});
