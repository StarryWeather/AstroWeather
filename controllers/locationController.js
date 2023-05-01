// Imports
const asyncHandler = require("express-async-handler");
const Location = require("../models/locationModel");
const jwt = require("jsonwebtoken");

//@desc Get all locations
//@route GET /api/locations
//@access private
const getLocations = asyncHandler(async (req, res) => {
    // Contact database and get locations
    const locations = await Location.findById(req.user.id); //(req.params.id) url? not auth bearer header

    // Send response back to client
    res.status(200).json({"locations"});
});


//@desc Create new location
//@route POST /api/locations
//@access private
const createLocation = asyncHandler(async (req, res) => {
    // Take in request from client and validate
    const {lat, long} = req.body;
    if (!lat || !long) {
        res.status(400);
        throw new Error("Missing latitude or longitude from location data");
    }

    // // Decode JWT into user ID
    // const {user: {id}} = jwt.verify(accessToken, process.env.ACCESS_TOKEN_SECRET);
    // if (!id) {
    //     res.status(400);
    //     throw new Error("Error decoding user ID");
    // };

    // Find user entry in locations table
    let location = await Location.findById(req.user.id);

    // Decide on if you're creating a new location object or apending to database
    if (!location) {
        const newLocation = await Location.create({
            _id: id,
            savedLocations: [{
                latitude: lat,
                longitude: long,
            }]
        });
        res.status(201).json({});
    } else {
        const coordinates = {latitude: lat, longitude: long};
        const updatedLocation = await Location.findByIdAndUpdate(id, {$push: {savedLocations: coordinates}});
        if (!updatedLocation) {
            res.status(404);
            throw new Error("Error updating location");
        } else {
            res.status(201).json({});
        }
    }
});


//@desc Update location
//@route POST /api/locations/:id
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

    res.status(201).json(updatedLocation);
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