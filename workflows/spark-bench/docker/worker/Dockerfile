FROM bde2020/spark-worker:2.4.0-hadoop2.8-scala2.12

RUN apt update && \
    apt install -q -y wget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget "https://github.com/CODAIT/spark-bench/releases/download/v99/spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" -q && \
    tar -xzf "spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" && mv "spark-bench_2.3.0_0.4.0-RELEASE" "spark-bench"
ADD minimal.conf /spark-bench