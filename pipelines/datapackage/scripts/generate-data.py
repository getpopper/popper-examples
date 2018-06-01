import wget

"""
    Script for generating data. 
    Here, you should use your own script for generating data.
"""

# official url datapackage csv example
datapackage_url_csv_example = 'https://raw.githubusercontent.com/frictionlessdata/example-data-packages/master/periodic-table/data.csv'

#Route that we're going to use to save our csv.
output_file_route = 'data/datapackage_csv_example.csv'

# We get and download the official csv example to our route.
wget.download(datapackage_url_csv_example, output_file_route)

