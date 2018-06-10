#!/usr/bin/env bash
# [wf] execute update-datapackage.sh stage

# Makes sure a virtual env is active.
if [ -z "$VIRTUAL_ENV" ]; then
    echo "ERROR: A virtual environment must be active in order to execute this stage."
    exit 1
fi

# [wf] Installing dependencies
if python3.4 -c "import datapackage" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    sudo pip3 install datapackage
fi

# [wf] running scripts
python3.4 scripts/update-datapackage.py
