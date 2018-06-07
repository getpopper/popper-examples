#!/usr/bin/env bash
# [wf] execute run.sh stage

# [wf] Installing dependencies
if python -c "import datadotworld" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    pip install datadotworld[pandas]
fi


# [wf] data folder
mkdir data

# [wf] running script generate-data
python scripts/generate-data.py
