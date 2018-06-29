#!/usr/bin/env Rscript
# [wf] check if packrat is running

result = tryCatch({
    packrat::status()
}, warning = function(warning_condition) {
    message(warning_condition)
}, error = function(error_condition) {
    message(error_condition)
    message("for you")
    install.packages("rgdal", repos="http://cran.us.r-project.org")
    install.packages("units", repos = "http://cran.us.r-project.org")
    install.packages("rgdal", repos = "http://cran.us.r-project.org")
    install.packages("packrat", repos = "http://cran.us.r-project.org")
    install.packages("plotly", repos = "http://cran.us.r-project.org")
    install.packages("maps", repos = "http://cran.us.r-project.org")
    install.packages("reticulate", repos = "http://cran.us.r-project.org")
    install.packages("sf", repos = "http://cran.us.r-project.org")

    packrat::init()
})









