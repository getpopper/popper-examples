
import datadotworld as dw
import csv

"""
    Script for generating data. 
    Here, you should use your own script for generating data.
"""

# Downloading official dataworld dataset example
with dw.open_remote_file('jonloyens/an-intro-to-dataworld-dataset','DataDotWorldBBallStats.csv', mode='r') as r:
    reader = csv.reader(r)
    output_file = open("data/DataDotWorldBBallStats.csv","wb")
    writer = csv.writer(output_file, delimiter=",",quotechar='"', quoting=csv.QUOTE_ALL)

    for row in reader:
        writer.writerow(row)

    output_file.close()
