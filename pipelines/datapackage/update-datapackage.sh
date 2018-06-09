#!/usr/bin/env bash
# [wf] execute update-datapackage.sh stage

# [wf] Installing dependencies
if python3.6 -c "import datapackage" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    pip3.6 install datapackage
fi

# [wf] running scripts
python3.6 scripts/update-datapackage.py
