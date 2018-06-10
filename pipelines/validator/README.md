# validator
A template showing how to use Popper with validations.
In this case, [Popper](https://github.com/systemslab/popper/) helps ensure that validations are enable by returning **GOLD** as the status of a pipeline after executing popper run.

Popper implements the convention of treating every line written to stdout by the **validate.sh** as a validation result.

This script should print to standard output one line per validation, denoting whether a validation passed or not. In general, the form for validation results is [true|false] <statement> (see examples below).

> [true]  algorithm A outperforms B

> [false] network throughput is 2x the IO bandwidth

