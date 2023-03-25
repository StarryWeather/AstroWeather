// Imports
const mongoose = require("mongoose");

// Method to connect to MongoDB
const connectDb = async () => {
    try {
        const connect = await mongoose.connect(process.env.CONNECTION_STRING);
        console.log("Database connected: ", connect.connection.host, connect.connection.name);
    }catch(err) {
        console.log(err);
        process.exit(1);
    }
};

// Export connectionDb function
module.exports = connectDb;