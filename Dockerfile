FROM ubuntu:18.04

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y \
      bzip2 \
      ca-certificates \
      ca-certificates-java \
      locales \
      openjdk-8-jre-headless \
      python3 \
      python3-pip \
      python3-setuptools \
      sudo \
      unzip \
      wget \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

ENV SPARK_HOME /usr/local/spark
ENV \
  APACHE_SPARK_VERSION=2.3.1 \
  DEBIAN_FRONTEND=noninteractive \
  HADOOP_VERSION=2.7 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  PYTHONPATH="lib:${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.7-src.zip" \
  SPARK_OPTS="--driver-java-options=-Xms1024M --driver-java-options=-Xmx4096M --driver-java-options=-Dlog4j.logLevel=info"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -q "http://mirrors.ukfast.co.uk/sites/ftp.apache.org/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
        echo "DC3A97F3D99791D363E4F70A622B84D6E313BD852F6FDBC777D31EAB44CBC112CEEAA20F7BF835492FB654F48AE57E9969F93D3B0E6EC92076D1C5E1B40B4696 *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \
        tar xzf "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" -C /usr/local --owner root --group root --no-same-owner && \
        rm "spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz"
RUN ln -s /usr/local/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/local/spark

COPY requirements*.txt /
RUN pip3 install -r /requirements.txt
RUN pip3 install -r /requirements.development.txt

# Check if spark context can be created
RUN python3 -c 'from pyspark import SparkContext; sc = SparkContext("local", "test"); print(sc.version)'
