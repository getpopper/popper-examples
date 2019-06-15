FROM bde2020/spark-worker:2.4.1-hadoop2.7
ENV SCALA_VERSION=2.11.8 \
    SCALA_HOME=/usr/share/scala

RUN apk add --no-cache wget libc6-compat && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget "https://github.com/CODAIT/spark-bench/releases/download/v99/spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" -q && \
    tar -xzf "spark-bench_2.3.0_0.4.0-RELEASE_99.tgz" && mv "spark-bench_2.3.0_0.4.0-RELEASE" "spark-bench";\
    cd "/tmp" && wget "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" -q;\
    tar xzf "scala-${SCALA_VERSION}.tgz";\
    mkdir "${SCALA_HOME}"; \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat; \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}"; \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/"; \
    apk del .build-dependencies;\
    rm -rf "/tmp/"*;
