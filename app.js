// Imports
const express = require("express");
const connectDb = require("./config/dbConnection");
const errorHandler = require("./config/errorHandler");
const dotenv = require("dotenv").config();
const cors = require("cors");
const path = require("path");
const nodemailer = require("nodemailer");

var createError = require('http-errors');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

// Assignments
//const port = process.env.PORT || 5000;
const app = express();

// Log on dev build
app.use(logger('dev'));

app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

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

// // Start backend
// app.listen(port, () => {
//     console.log(`Server running on port ${port}`)
// });

module.exports = app;