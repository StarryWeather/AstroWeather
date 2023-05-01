const express = require("express");
const router = express.Router();
const {
    getLocations, 
    createLocation,
    deleteLocation, 
    // updateLocation,
    // getLocation
} = require("../controllers/locationController"); // Provides methods for responses
const validateToken = require("../config/validateTokenHandler");

// Listen for CRUD request at the specified endpoint ("/") in server.js (api/locations/)
router.use(validateToken)
router.route("/").get(getLocations).post(createLocation).delete(deleteLocation);
//router.route("/:id").put(updateLocation).get(getLocation);

module.exports = router;













// Code without controller files/folders
// Listen for a GET request at the specified endpoint in server.js (request, response)
// router.route("/").get((req,res) => {
//     res.status(200).json({ message: "Get all contacts"}); //JSON format, pass as well the status code
// });

// router.route("/").post((req,res) => {
//     res.status(200).json({ message: "Create contact"});
// });

// router.route("/:id").put((req,res) => {
//     res.status(200).json({ message: `Update contact for ${req.params.id}`}); //JSON format, pass as well the status code
// });

// router.route("/:id").delete((req,res) => {
//     res.status(200).json({ message: `Delete contact for ${req.params.id}`});
// });

// router.route("/:id").get((req,res) => {
//     res.status(200).json({ message: `Get contact for ${req.params.id}`}); //JSON format, pass as well the status code
// });