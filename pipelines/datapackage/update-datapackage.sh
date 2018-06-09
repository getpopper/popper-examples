#!/usr/bin/env bash
# [wf] execute update-datapackage.sh stage

# [wf] Installing dependencies
if python3 -c "import datapackage" &> /dev/null; then
    echo 'requirements already installed.'
else
    echo 'Installing dependencies'
    sudo pip3 install datapackage
fi

# [wf] running scripts
python3 scripts/update-datapackage.py
