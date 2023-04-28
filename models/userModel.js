const mongoose = require("mongoose");

// Schema for accounts in the mongoDB database
const userSchema = mongoose.Schema(
    {
        email: {
            type: String,
            required: [true, "Please add an email"],
            unique: [true, "Please check your email or password or reset your password"]
        },
        password: {
            type: String,
            required: [true, "Please add a password"],
        },
        confirmed: {
            type: Boolean,
            required: [true, "Error with account confirmation"],
        }
    },
    {
        timestamps: true,
    }
);

// Export the mongo database schema for accounts
module.exports = mongoose.model("User", userSchema);