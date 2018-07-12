# sea-surface-mapping-r


A pipeline showing how to make use of R's packrat package to create a portablie pipeline. The pipeline is a port of this other pipeline implemented in [Python](https://github.com/popperized/swc-lesson-pipelines/tree/master/pipelines/sea-surface-mapping). The R scripts create weather maps using rgeos, sf, maptools, and netcdf. In this case, the pipeline makes use of packrat to install dependencies in isolation.
