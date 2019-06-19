#!/usr/bin/env bash
install/bin/lulesh2.0 -s {{ param_1 }} -i {{ param_2 }} > "$GITHUB_WORKPSACE/workflows/scc18/output/out_{{param_1}}_{{param_2}}.txt"