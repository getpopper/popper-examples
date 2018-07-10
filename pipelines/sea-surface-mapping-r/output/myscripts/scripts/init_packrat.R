result = tryCatch({
    packrat::status()
}, warning = function(warning_condition) {
    message(warning_condition)
}, error = function(error_condition) {

    message(error_condition)
    packrat::init()

})