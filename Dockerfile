FROM ubuntu:18.04

ENV \
  PYTHONPATH=lib \
  SPARK_HOME=/opt/spark/ \
  PYSPARK_DRIVER_PYTHON=python3 \
  PYSPARK_PYTHON=python3 \
  LC_ALL=en_US.UTF-8

COPY requirements.txt /requirements.txt

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    locales-all \
    python3 \
    python3-pip \
    sudo \
    unzip \
    wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* && \
  curl -sk https://bootstrap.pypa.io/get-pip.py | python3

RUN pip3 install -r /requirements.txt
