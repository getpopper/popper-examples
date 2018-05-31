import datapackage

"""
    Script for uploading your local changes to data.world
    NOTE: You must have a data.world account.
"""

package = datapackage.Package()

# Path where our csv was saved.
path_to_csv = 'data/datapackage_csv_example.csv'

# We can extrapolate our CSV's schema by using infer from the Table Schema library.
# The infer function checks a small subset of your dataset and
# summarizes expected datatypes against each column, etc.
# To infer a schema for our dataset and view it, we will simply run
package.infer(path_to_csv)

# You can use descriptor to get how your descriptor looks at any time.
print(package.descriptor)

#When you're done with your package, you can save it by using the method save
package.save('data/datapackage.json')




