FROM bde2020/spark-master:2.4.0-hadoop2.8-scala2.12

RUN apt update && \
    apt install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    git clone --branch v99 "https://github.com/CODAIT/spark-bench"
ADD minimal.conf /spark-bench