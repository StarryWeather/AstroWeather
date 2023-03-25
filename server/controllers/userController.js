// Imports
const asyncHandler = require("express-async-handler");
const User = require("../models/userModel");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

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

    // Validate if the user exists
    const available = await User.findOne({email});
    if (available) {
        res.status(400);
        throw new Error("User already exists!");
    }

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);
    console.log("Hashed Password: ", hashedPassword);

    // Create new user object and send to database
    const user = await User.create({
        email,
        password: hashedPassword,
    });

    // Create response
    console.log(`User created ${user}`);
    if (user) {
        res.status(201).json({_id: user.id, email: user.email});
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

    // Compare entered password with hashed passwords in database
    if (user && (await bcrypt.compare(password, user.password))) {

        // Create json web token to validate sign in
        const accessToken = jwt.sign(
            {
                user: {
                    email: user.email,
                    id: user.id,
                },
            }, 
            process.env.ACCESS_TOKEN_SECRET,
            {expiresIn: "15m"}
        )
        res.status(200).json({accessToken});
    } else {
        res.status(401);
        throw new Error("Email or password invalid");
    }
});

//@desc Current user information
//@route GET /api/users/current
//@access private
const currentUser = asyncHandler(async (req, res) => {
    res.json(req.user);
});

module.exports = {
    registerUser, 
    loginUser, 
    currentUser
};