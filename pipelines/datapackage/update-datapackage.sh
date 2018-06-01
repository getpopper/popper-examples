#!/usr/bin/env bash
# [wf] execute update-datapackage.sh stage

# [wf] Installing dependencies
if python -c "import datapackage" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    pip install datapackage
fi

# [wf] running scripts
python scripts/update-datapackage.py
