FROM alpine

RUN set -x \
    && apk update \
    && apk --no-cache add \
        bash \
        fltk \
        ghostscript \
        gnuplot \
        lapack \
        less \
        python3 \
        py3-zmq \
        su-exec \ 
        tini \
        xvfb \
    && apk --no-cache add \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
        octave \
    && pip3 install --upgrade pip \
    && pip3 install metakernel \
    && pip3 install ipywidgets \
    && pip3 install jupyter-console \
    && pip3 install octave_kernel \
    && mkdir -p /etc/jupyter \
    && adduser -D  -g '' -s /sbin/nologin -u 1000 docker \
    && adduser -D  -g '' -s /sbin/nologin octave \
    && adduser -D  -g '' -s /sbin/nologin jupyter 

WORKDIR /code

COPY entrypoint.sh  /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

EXPOSE 8888

ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["jupyter", "notebook"]
