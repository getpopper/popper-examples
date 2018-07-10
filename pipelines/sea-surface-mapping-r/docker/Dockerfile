FROM r-base:latest

COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts


# CMD ["Rscript", "scripts/init_packrat.r"]

RUN apt-get update -y \
    && apt-get install -y libssl-dev libcurl4-openssl-dev libnetcdf-dev libnetcdf13 r-cran-ncdf4 netcdf-bin libssh2-1-dev libudunits2-dev \
                          libgdal-dev


RUN Rscript -e "install.packages('rgdal', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('sf', repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('ncdf4' , repos='http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('units' , repos='http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('plotly' , repos='http://cran.us.r-project.org')"
RUN Rscript -e "install.packages('packrat' , repos='http://cran.us.r-project.org')"

