FROM bde2020/spark-worker:2.4.0-hadoop2.8-scala2.12

RUN apt update && \
    apt install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget "https://github.com/CODAIT/spark-bench/releases/download/v99/spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" && \
    mkdir -p /spark-bench && tar -xvzf "spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" -C /spark-bench --strip-components=1
ADD minimal.conf /spark-bench