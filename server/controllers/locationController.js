// Imports
const asyncHandler = require("express-async-handler");
const Location = require("../models/locationModel");

// CRUD OPERATIONS OF INFO

//@desc Get all locations
//@route GET /api/locations
//@access private
const getLocations = asyncHandler(async (req, res) => {
    // Contact database and get locations
    const locations = await Location.find({user_id: req.user.id});

    // Send response back to client
    res.status(200).json(locations);
});


//@desc Create new location
//@route POST /api/locations
//@access private
const createLocation = asyncHandler(async (req, res) => {
    console.log("The request body is: ", req.body);

    // Take in request from client and validate
    const {email, password} = req.body;
    if (!email || !password) {
        res.status(400);
        throw new Error("All fields are mandatory");
    }

    // Create location object and send to database
    const location = await Location.create({
        email,
        password,
        user_id: req.user.id, //from jwt
    });

    // Send response back to client in JSON format with the status code
    res.status(201).json(location);
});


//@desc Update location
//@route PUT /api/locations/:id
//@access private
const updateLocation = asyncHandler(async (req, res) => {
    const location = await Location.findById(req.params.id);
    if (!location) {
        res.status(404);
        throw new Error("Location not found");
    }

    if (location.user_id.toString() !== req.user.id) {
        res.status(403);
        throw new Error("User does not have permission to update information");
    }

    const updatedLocation = await Location.findByIdAndUpdate(
        req.params.id,
        req.body,
        {new: true}
    );

    res.status(200).json(updatedLocation);
});


//@desc Delete location
//@route DELETE /api/locations/:id
//@access private
const deleteLocation = asyncHandler(async (req, res) => {
    const location = await Location.findById(req.params.id);
    if (!location) {
        res.status(404);
        throw new Error("Location not found");
    }

    if (location.user_id.toString() !== req.user.id) {
        res.status(403);
        throw new Error("User does not have permission to update information");
    }

    await Location.deleteOne({_id: req.params.id});
    res.status(200).json(location);
});


//@desc Get location
//@route GET /api/locations/:id
//@access private
const getLocation = asyncHandler(async (req, res) => {
    const location = await Location.findById(req.params.id);
    if (!location) {
        res.status(404);
        throw new Error("Location not found");
    }

    res.status(200).json(location);
});


// Export API functions to module
module.exports = {
    getLocations, 
    createLocation, 
    updateLocation, 
    deleteLocation, 
    getLocation
};