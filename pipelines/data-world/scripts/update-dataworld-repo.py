import datadotworld as dw
import csv

"""
    Script for uploading your local changes to data.world
    NOTE: You must have a data.world account.
"""

with dw.open_remote_file('<YOUR DATA.WORLD PAGE>', '<YOUR DATA.WORLD CSV>') as w:
    input_file = open("<PATH TO YOUR LOCAL CSV>", "r")
    reader = csv.reader(input_file)
    writer = csv.writer(w, delimiter=",", quotechar='"', quoting=csv.QUOTE_ALL)

    for row in reader:
        writer.writerow(row)

    input_file.close()
