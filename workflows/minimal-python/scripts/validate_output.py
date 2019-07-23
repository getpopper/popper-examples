#!/usr/bin/env python
import csv
import sys

fname = sys.argv[1]


with open(fname, 'r') as fi:
    r = csv.reader(fi)

    # get 0-based index of last column in CSV file
    last = len(next(r)) - 1

    for row in r:
        # for years greater than 1950, we should have non-zero mean
        if int(row[0]) < 1950:
            assert float(row[last]) == 0.0
        else:
            assert float(row[last]) != 0
