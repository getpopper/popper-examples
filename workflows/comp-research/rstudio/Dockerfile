FROM apoirel/popper-rstudio:4.0.0
LABEL maintainer="apoirel@ucsc.edu"
RUN ["install2.r", "versions"]
RUN ["Rscript", "-e", "versions::install.versions('dplyr', '0.8.5')", "-e", "versions::install.versions('forcats', '0.5.0')", "-e", "versions::install.versions('ggplot2', '3.3.0')", "-e", "versions::install.versions('readr', '1.3.1')", "-e", "versions::install.versions('stringr', '1.4.0')", "-e", "versions::install.versions('tibble', '3.0.1')", "-e", "versions::install.versions('tidyr', '1.0.2')", "-e", "versions::install.versions('tidyverse', '1.3.0')"]
WORKDIR /payload/
CMD ["bin/sh"]
