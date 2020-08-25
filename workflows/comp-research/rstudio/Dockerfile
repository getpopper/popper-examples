FROM asachet/rocker-tidymodels:3.6.1

LABEL maintainer="apoirel@ucsc.edu"
LABEL description="This images is used as a base for developing data analysis workflows. \
Organization follows the R packages convention"
LABEL version="0.1"

# move configuration file where rstudio server will find it
COPY rsession.conf /etc/rstudio 

# install R packages specified in DESCRIPTION
WORKDIR /dummy
COPY DESCRIPTION .
RUN R -e "devtools::install_deps()"

EXPOSE 8787
CMD ["bin/sh"] 