# pypet-brian2

This workflow popperizes the pypet/BRIAN2 example found [here](https://pypet.readthedocs.io/en/latest/examplesdoc/example_23.html)

This workflow consists of three actions:
  * `install dependencies`. which installs all the required python packages reading from [requirements.txt](./requirement.txt).
  * `run example`. executes the script [pypet_example.py](./scripts/pypet_example.py) and generates the output in an `.hdf5` file.
  * `visualize`. action plots the results to visualize. 

