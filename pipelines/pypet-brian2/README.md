# pypet-brian2

This pipeline popperizes the pypet/BRIAN2 example found [here](https://pypet.readthedocs.io/en/latest/examplesdoc/example_23.html)

Popper makes sure that all the binary dependencies are installed such as python, pip, virtualenv.
Then Popper installs all the requirements needed to run the example in the setup stage.
And finally popper executes the script [example_23_brian2_network.py](./scripts/example_23_brian2_network.py)
in the run stage.

