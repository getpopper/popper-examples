FROM rocker/rstudio:3.6.3

LABEL maintainer="apoirel@ucsc.edu"
LABEL description="This images is used as a base for developing data analysis workflows. \
Desired packages should be specified in renv.lock"
LABEL version="0.1"

COPY ression.conf /etc/rstudio

ENV RENV_VERSION 0.11.0-23

COPY renv.lock .
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" \
    R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')" \
    R -e 'renv::restore()'

EXPOSE 8787
CMD ["bin/sh"]