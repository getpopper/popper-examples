import datadotworld as dw
import csv
import os

"""
    Script for uploading your local changes to data.world
"""

with dw.open_remote_file(os.environ['DATA_WORLD_ACCOUNT'], os.environ['DATA_WORLD_CSV']) as w:
    input_file = open("data/DataDotWorldBBallStats.csv", "r")
    reader = csv.reader(input_file)
    writer = csv.writer(w, delimiter=",", quotechar='"', quoting=csv.QUOTE_ALL)

    for row in reader:
        writer.writerow(row)

    input_file.close()
