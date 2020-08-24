FROM rocker/verse:3.6.3

LABEL maintainer="apoirel@ucsc.edu"
LABEL description="This images is used as a base for developing data analysis workflows. \
Desired packages should be specified in renv.lock"
LABEL version="0.1"

# move configuration file where rstudio server will find it
COPY rsession.conf /etc/rstudio/

# create director holding packages installed by renv
# ENV RENV_PATH_LIBRARY /rpackages
# WORKDIR /rpackages

# install renv
ENV RENV_VERSION 0.11.0-24
RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))" \
    R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')" 

# install project files
# COPY renv.lock renv.lock
# RUN R -e "renv::restore(lockfile = \"renv.lock\", actions = c(\"install\", \"upgrade\"), library = \"${RENV_PATH_LIBRARY}\")"

EXPOSE 8787
CMD ["bin/sh"]