FROM r-base

COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts

CMD ["Rscript", "init_packrat.r"]
CMD ["Rscript", "scripts/generate_map.r"]