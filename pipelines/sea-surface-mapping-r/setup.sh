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

    # Checks if a virtual environment is active.

})


if [ "$VIRTUAL_ENV" != "" ]; then
    source "$VIRTUAL_ENV"/bin/activate
    echo "It looks like you have an active virtual environment. I'll deactivate it in order to execute this pipeline."
    deactivate
fi

# Create virtual environment using python 2.7
virtualenv --python=python2.7 virtual-environment-python-27/

source virtual-environment-python-27/bin/activate

pip install scipy
pip install -U numpy








