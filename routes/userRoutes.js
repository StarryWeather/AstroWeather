const express = require("express");
const router = express.Router();
const { 
    registerUser, 
    loginUser, 
    currentUser, 
    confirmUser
} = require("../controllers/userController");
const validateToken = require("../config/validateTokenHandler");


router.post("/register", registerUser);
router.get("/confirm", confirmUser);
router.post("/login", loginUser);
router.get("/current", validateToken, currentUser);

module.exports = router;