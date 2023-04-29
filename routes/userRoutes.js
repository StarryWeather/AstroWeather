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
router.get("/confirm/:token", confirmUser); // Figure out how to make put with urls sent in emails
router.get("/reset/:token", resetPassword);
router.get("/current", validateToken, currentUser);
router.get("/reset", passwordPrompt);

module.exports = router;