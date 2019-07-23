#!/usr/bin/env python
import csv
import sys

# This only works on Python 3
from itertools import zip_longest

fname = sys.argv[1]
group_size = int(sys.argv[2])
fout = fname.replace('.csv', '') + '_per_capita_mean.csv'


def grouper(iterable, n, fillvalue=None):
    args = [iter(iterable)] * n
    return zip_longest(*args, fillvalue=fillvalue)


with open(fname, 'r') as fi, open(fout, 'w') as fo:
    r = csv.reader(fi)
    w = csv.writer(fo)

    # get 0-based index of last column in CSV file
    last = len(next(r)) - 1

    for g in grouper(r, group_size):
        group_sum = 0
        year = 0

        for row in g:
            # check for empty value (and assume zero)
            if row[last]:
                group_sum += float(row[last])
            else:
                group_sum += 0.0
            year = row[0]

        w.writerow([year, group_sum / group_size])
