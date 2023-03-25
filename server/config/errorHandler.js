// Imports
const {constants} = require("./constants");

const errorHandler = (err, req, res, next) => {
    // Return status code, if none then 500
    const statusCode = res.statusCode ? res.statusCode : 500;

    // Statuscode switch
    switch (statusCode) {
        case constants.VALIDATION_ERROR:
            // Result json format the error message and a stack trace
            res.json({
                title: "Validation Failed", 
                message: err.message, 
                //stackTrace: err.stack
            });
        case constants.NOT_FOUND:
            res.json({
                title: "Not Found", 
                message: err.message, 
                //stackTrace: err.stack
            });
        case constants.FORBIDDEN:
            res.json({
                title: "Forbidden", 
                message: err.message, 
                //stackTrace: err.stack
            });
        case constants.UNAUTHORIZED:
            res.json({
                title: "Unauthorized", 
                message: err.message, 
                //stackTrace: err.stack
            });
        case constants.SERVER_ERROR:
            res.json({
                title: "Server Error", 
                message: err.message, 
                //stackTrace: err.stack
            });
        default:
            console.log("No Error, all good!");
    }
};

// Export to module the errorHandler
module.exports = errorHandler;