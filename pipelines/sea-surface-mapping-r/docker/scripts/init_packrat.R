if (!require("devtools")) install.packages("devtools")
devtools::install_github("rstudio/packrat")
library(packrat)

# if this not work set lib path and repro, and try again
# setRepositories(ind = c(1:6, 8))
# .libPaths( c("/path/to/your/R_library") )


result = tryCatch({
    packrat::status()
}, warning = function(warning_condition) {
    message(warning_condition)
}, error = function(error_condition) {

    message(error_condition)

    # after installing, type in the following commands
    packrat::init()
    packrat::clean()
    packrat::snapshot()

    # then make sure the packrat.lock, packrat.opts, init.R
    # is located in the packrat/ folder and push these files to the repo if necessary

})