FROM ubuntu:18.04

ENV PYTHONPATH=lib
ENV SPARK_HOME=/opt/spark/
ENV PYSPARK_DRIVER_PYTHON=python3
ENV PYSPARK_PYTHON=python3
ENV LC_ALL=en_US.UTF-8

COPY requirements.txt /requirements.txt

RUN apt-get update \
    && apt-get install -y \
    curl \
    locales-all \
    python3 \
    python3-pip \
    sudo \
    unzip \
    wget \
    && pip3 install -r /requirements.txt >/dev/null
