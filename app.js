const express = require('express');
const app = express();

// Set 'views' directory for any views being rendered
app.set('views', __dirname + '/views');

// Set EJS as the templating engine
app.set('view engine', 'ejs');

// Import and use routes defined in routes.js
const routes = require('./routes/routes'); // Import the routes module
app.use('/', routes); // Mount routes under / path

// Start the server
const port = process.env.PORT || 4217;
app.listen(port, () => {
    console.log(`Server started on port ${port}!`);
});
