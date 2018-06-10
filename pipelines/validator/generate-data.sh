#!/usr/bin/env bash

# [wf] execute generate-data.sh stage

if [ -z "$VIRTUAL_ENV" ]; then
    echo "ERROR: A virtual environment must be active in order to execute this stage."
    exit 1
fi

# [wf] Checks if the statsmodels module is installed.
if python -c "import statsmodels.stats.api" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    pip install statsmodels
    pip install scipy
fi

# [wf] Data folder
mkdir data

# [wf] run generate-data.py script
python scripts/generate-data.py 0 21 1 0 22 2
