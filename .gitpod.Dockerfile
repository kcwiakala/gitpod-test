FROM gitpod/workspace-python:latest

# Python dependencies
RUN pip install poetry pandas flake8 black radian pyspark seaborn

# R language support
RUN sudo install-packages dirmngr gnupg apt-transport-https ca-certificates software-properties-common \
 && sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
 && sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/' \
 && sudo install-packages r-base

# Spark
RUN sudo install-packages openjdk-8-jdk \
 && mkdir $HOME/spark && cd $HOME/spark \
 && curl -fsSL https://dlcdn.apache.org/spark/spark-3.1.3/spark-3.1.3-bin-hadoop3.2.tgz | tar xz
ENV SPARK_HOME=$HOME/spark/spark-3.1.3-bin-hadoop3.2
ENV PYTHONPATH=$HOME/spark/spark-3.1.3-bin-hadoop3.2/python/pyspark

# R libraries
RUN sudo R -e "install.packages(('remotest', 'renv', 'languageserver', 'sparklyr', 'data.table', 'httpgd'))"