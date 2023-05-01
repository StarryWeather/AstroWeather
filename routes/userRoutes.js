const express = require("express");
const router = express.Router();
const { 
    registerUser, 
    loginUser, 
    currentUser, 
    confirmUser,
    passwordPrompt,
    resetPassword,
} = require("../controllers/userController");
const validateToken = require("../config/validateTokenHandler");


router.post("/login", loginUser);
router.post("/register", registerUser);
router.get("/confirm/:token", confirmUser); // Figure out how to make PUT with urls sent in emails
router.post("/reset", passwordPrompt);
router.post("/reset/:token", resetPassword); // Figure out how to make PUT with urls sent in emails
router.get("/current", validateToken, currentUser);

module.exports = router;