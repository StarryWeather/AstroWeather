const mongoose = require("mongoose");

// Schema for locations in the mongoDB database
const locationSchema = mongoose.Schema(
    {
        user_id: {
            type: mongoose.Schema.Types.ObjectId,
            required: [true],
            ref: "User",
        },
        savedLocations: [
            {
                latitude: {
                    type: Number,
                    required: [true, "Invalid or missing latitude"],
                },
                longitude: {
                    type: Number,
                    required: [true, "Invalid or missing longitude"],
                }
            }
        ]
    },
    {
        timestamps: true,
    }
);

// Export the mongo database schema for locations
module.exports = mongoose.model("Location", locationSchema);