FROM gitpod/workspace-python:latest

# Spark
RUN mkdir $HOME/spark && cd $HOME/spark \
 && curl -fsSL https://dlcdn.apache.org/spark/spark-3.1.3/spark-3.1.3-bin-hadoop3.2.tgz | tar xz
ENV SPARK_HOME=$HOME/spark/spark-3.1.3-bin-hadoop3.2
ENV PYTHONPATH=$HOME/spark/spark-3.1.3-bin-hadoop3.2/python/pyspark