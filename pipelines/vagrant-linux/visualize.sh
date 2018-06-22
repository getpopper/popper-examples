cd results
docker run --rm -p 8888:8888 -v "$PWD":/experiment --workdir=/experiment --user=root --entrypoint=jupyter jupyter/scipy-notebook nbconvert --execute visualize.ipynb --ExecutePreprocessor.timeout=-1 --inplace

