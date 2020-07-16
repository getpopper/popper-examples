FROM continuumio/miniconda3:4.8.2

LABEL maintainer="apoirel@ucsc.edu"
LABEL description="This images is used as a base for developing data analysis workflows. \
Desired packages should be specified in environment.yml"
LABEL version="0.1"

ENV PYTHONDONTWRITEBYTECODE=true 

# update conda environment with packages and clean up conda installation by removing 
# conda cache/package tarbarlls and python bytecode
COPY environment.yml .
RUN conda env update -f environment.yml \
    && conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete 
CMD [ "/bin/bash" ]