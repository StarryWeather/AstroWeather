// Imports
const express = require("express");
const connectDb = require("./config/dbConnection");
const errorHandler = require("./config/errorHandler");
const dotenv = require("dotenv").config();
const cors = require("cors");
const path = require("path");

// Assignments
const port = process.env.PORT || 5000;
const app = express();

/* Set port with express
app.set("port", port);
*/

// Print to console database details
connectDb();

// Declare "body" parser for a given data stream received from client
app.use(express.json());

// Declare use of cors for security management
app.use(cors());

// Error Handler
app.use(errorHandler);

// Define cors
app.use((req, res, next) => {
    res.setHeader("Acccess-Control-Allow-Origin", "*");
    res.setHeader('Access-Control-Allow-Headers','Origin, X-Requested-With, Content-Type, Accept, Authorization');
    res.setHeader('Access-Control-Allow-Methods','GET, POST, PUT, DELETE');
    next();
});

// Define URL routing to internal routing
app.use("/api/locations", require("./routes/locationRoutes"));
app.use("/api/users", require("./routes/userRoutes"));

// Server static assets if in production
if (process.env.NODE_ENV === 'production') {
    // Set static folder
    app.use(express.static('astro_weather/build/web'));
    app.get('*', (req, res) => {
        res.sendFile(path.resolve(__dirname, 'astro_weather', 'build', 'web', 'index.html'));
    });
}

// Start backend
app.listen(port, () => {
    console.log(`Server running on port ${port}`)
});

/*
Start Scripts:
"heroku-postbuild": "NPM_CONFIG_PRODUCTION=false npm install --prefix astro_weather && npm run build --prefix astro_weather"

Gitignore:
/node_modules
.env
.DS_Store
npm-debug.log
/*.env
*/