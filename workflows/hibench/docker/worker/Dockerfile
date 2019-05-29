FROM bde2020/spark-worker:2.4.1-hadoop2.7

RUN apk update && \
    apk upgrade && \
    apk add --no-cache wget && \
    wget "https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.tgz" && \
    tar xvf "scala-2.12.8.tgz" && \
    wget "http://mirrors.estointernet.in/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz" && \
    tar xvf "spark-2.4.3-bin-hadoop2.7.tgz" && \
    wget "https://github.com/CODAIT/spark-bench/releases/download/v99/spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" && \
    tar -xvzf "spark-bench_2.3.0_0.4.0-RELEASE_99.tgz"