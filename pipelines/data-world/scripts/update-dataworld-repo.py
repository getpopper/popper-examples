import datadotworld as dw
import csv
import os

"""
    Script for uploading your local changes to data.world
"""

with dw.open_remote_file('https://data.world/fran1307/2018-datadotworldbballstats', 'DataDotWorldBBallStats.csv') as w:
    input_file = open("data/DataDotWorldBBallStats.csv", "r")
    reader = csv.reader(input_file)
    writer = csv.writer(w, delimiter=",", quotechar='"', quoting=csv.QUOTE_ALL)

    for row in reader:
        writer.writerow(row)

    input_file.close()
