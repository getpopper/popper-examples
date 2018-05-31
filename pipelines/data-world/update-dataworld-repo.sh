#!/usr/bin/env bash
# [wf] execute update-dataworld-repo.sh stage

# [wf] Installing dependencies
if python -c "import datadotworld" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    pip install datadotworld[pandas]
fi

# [wf] running scripts
python scripts/update-dataworld-repo.py


