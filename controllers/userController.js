// Imports
const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");
const dotenv = require("dotenv").config();
const { token } = require("morgan");

//@desc Register a user
//@route POST /api/users/register
//@access public
const registerUser = asyncHandler(async (req, res) => {
    // Take in request from client and validate it exists
    const { email, password } = req.body;
    if (!email || !password) {
        res.status(400);
        throw new Error("All fields are mandatory");
    }

    // Validate if the email is present in the db
    const exists = await User.findOne({email});
    if (exists) {
        res.status(400);
        throw new Error("User already exists!");
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);
    console.log("Hashed Password: ", hashedPassword);

    // Create new user object and send to database
    const user = await User.create({
        email: email,
        password: hashedPassword,
        confirmed: false,
    });

    // Email functionality
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
//            type: "OAuth2",
            user: process.env.EMAIL_USERNAME,
            pass: process.env.EMAIL_PASSWORD,
//            clientId: process.env.OAUTH_CLIENTID,
//            clientSecret: process.env.OAUTH_CLIENTSECRET,
//            refreshToken: process.env.OAUTH_REFRESHTOKEN,
        },
        debug: true,
        logger: true
    });

    // Create json web token to send in account confirmation email
    jwt.sign(
        {
            user: {
                id: user.id,
            },
        }, 
        process.env.EMAIL_TOKEN_SECRET,
        {expiresIn: "30m"},
        (err, emailToken) => {
            const url = `http://astroweather.space/api/users/confirm/${emailToken}`;

            transporter.sendMail({
                to: user.email,
                subject: "Please Confirm Your Email",
                html: `Click this link to confirm your email, or paste into your web browser in order to access the site: <a href="${url}">${url}</a>`,
            });
        },
    );

    // Create response
    console.log(`User created ${user}`);
    if (user) {
        res.status(201).json({email: user.email}); //_id: user.id,
    } else {
        res.status(400);
        throw new Error("User data not valid");
    }
});


//@desc Login a user
//@route POST /api/users/login
//@access public
const loginUser = asyncHandler(async (req, res) => {
    const {email, password} = req.body;
    if (!email || !password) {
        res.status(400);
        throw new Error("All fields are mandatory");
    }

    // Find user in database with email
    const user = await User.findOne({email});

    // Verify if user is email validated
    if (user.confirmed != true) {
        console.log(user.confirmed);
        res.status(401);
        throw new Error("Please verify your email address to continue");
    }

    // Compare entered password with hashed passwords in database
    // Could refactor as in reset function
    if (!(await bcrypt.compare(password, user.password))) {
        res.status(401);
        throw new Error("Email or password invalid");
    } else {

        // Create json web token to validate sign in
        const accessToken = jwt.sign(
            {
                user: {
                    email: user.email,
                    id: user.id,
                },
            }, 
            process.env.ACCESS_TOKEN_SECRET,
            {expiresIn: "30m"}
        );
        res.status(200).json({accessToken});
    }
});

//@desc Current user information
//@route GET /api/users/current
//@access private
const currentUser = asyncHandler(async (req, res) => {
    res.json(req.user);
});

//@desc Verify user account from email
//@route GET /api/users/confirm/:token
//@access private
const confirmUser = asyncHandler(async (req, res) => {
    try {
        const {user: {id}} = jwt.verify(req.params.token, process.env.EMAIL_TOKEN_SECRET);
        await User.findByIdAndUpdate(id, {confirmed: true});
    } catch (e) {
        res.status(400);
        throw new Error("Email validation error");
    }

    return res.redirect("http://astroweather.space/#/")
});

//@desc Email verification prompt to reset password
//@route POST /api/users/reset
//@access public
// FIX PATHING TO PROMPT AT WEBSITE PAGE
const passwordPrompt = asyncHandler(async (req, res) => {
    const {email} = req.body;
    if (!email) {
        res.status(400);
        throw new Error("Please enter an email");
    }

    // Find user in database with email
    const user = await User.findOne({email});

    // Verify if user is email validated
    if (user.confirmed != true) {
        console.log(user.confirmed);
        res.status(401);
        throw new Error("Please verify your email address to continue");
    }

    // Email functionality
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: process.env.EMAIL_USERNAME,
            pass: process.env.EMAIL_PASSWORD,
        },
        debug: true,
        logger: true
    });

    // Create json web token to send in password reset email
    jwt.sign(
        {
            user: {
                id: user.id,
            },
        }, 
        process.env.EMAIL_TOKEN_SECRET,
        {expiresIn: "5m"},
        (err, emailToken) => {
            transporter.sendMail({
                to: user.email,
                subject: "Reset your password",
                html: `Copy this code and type it into your password reset page: \n\n ${emailToken}`,
            });
        },
    );

    // Create response
    if (user) {
        res.status(201).json({email: user.email});
    } else {
        res.status(500);
        throw new Error("Unvalidated Email Error");
    }
});

//@desc Reset user password after email confirmation
//@route POST /api/users/reset/
//@access private
const resetPassword = asyncHandler(async (req, res) => {
    const {newPassword} = req.body;

    // Check for present fields
    if (!newPassword) {
        res.status(400);
        throw new Error("All fields are mandatory");
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    console.log("New Hashed Password: ", hashedPassword);

    // Update password and send response
    if (await User.findByIdAndUpdate(req.user.id, {password: hashedPassword})) {
        res.status(200).json("Success");
    } else {
        res.status(500).json("Error");
        throw new Error("Error resetting password");
    }
});

module.exports = {
    registerUser, 
    loginUser, 
    currentUser,
    confirmUser,
    passwordPrompt,
    resetPassword,
};