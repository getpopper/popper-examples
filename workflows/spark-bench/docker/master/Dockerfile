FROM bde2020/spark-master:2.4.0-hadoop2.8-scala2.12

RUN apt update && \
    apt install -y git && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget "https://github.com/CODAIT/spark-bench/releases/download/v99/spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" -q --show-progress && \
    tar -xzf "spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" && mv "spark-bench_2.3.0_0.4.0-RELEASE_99" "spark-bench"
ADD minimal.conf /spark-bench