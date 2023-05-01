// Imports
const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const { validate } = require("../models/userModel");

const validateEmailToken = asyncHandler(async (req, res, next) => {
    let token;
    let authorizationHeader = req.headers.Authorization || req.headers.authorization; // Header or Respective section in HTTP request

    // Begin parsing jwt
    if  (authorizationHeader && authorizationHeader.startsWith("Bearer")) {
        token = authorizationHeader.split(" ")[1]; // Begin at first index, space is 0 index
        jwt.verify(token, process.env.EMAIL_TOKEN_SECRET, (err, decoded) => {
            if (err) {
                res.status(401);
                throw new Error("User not authorized");
            }
            req.user = decoded.user
            next();
        });

        if (!token) {
            res.status(401);
            throw new Error("User not authorized or token is missing");
        }
    }
});

module.exports = validateEmailToken;