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
const validateEmailToken = require("../config/validateEmailTokenHandler");


router.post("/login", loginUser);
router.post("/register", registerUser);
router.get("/current", validateToken, currentUser); // Ignore
router.get("/confirm/:token", confirmUser); // Figure out how to make PUT with urls sent in emails
router.post("/reset", passwordPrompt);
router.post("/resetPassword", validateEmailToken, resetPassword); // Figure out how to make PUT with urls sent in emails

module.exports = router;