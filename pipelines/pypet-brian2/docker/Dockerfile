FROM python:3.6-slim-stretch

RUN apt update \
 && apt install -y --no-install-recommends --no-install-suggests libhdf5-cpp-100 \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir \
      pypet==0.4.3 \
      Brian2==2.2.1 \
      matplotlib==3.0.2 \
      numpy==1.15.4 \
      tables==3.4.4
