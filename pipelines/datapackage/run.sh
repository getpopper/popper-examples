#!/usr/bin/env bash
# [wf] execute run.sh stage

# [wf] data folder
mkdir data

# [wf] Installing dependencies
if python -c "import wget" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    pip install wget
fi

# [wf] running script generate-data
python scripts/generate-data.py