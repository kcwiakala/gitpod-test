FROM gitpod/workspace-base:latest

USER gitpod
# Dazzle does not rebuild a layer until one of its lines are changed. Increase this counter to rebuild this layer.
ENV TRIGGER_REBUILD=1

RUN sudo install-packages python3-pip

ENV PATH=$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH
RUN curl -fsSL https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
    && { echo; \
        echo 'eval "$(pyenv init -)"'; \
        echo 'eval "$(pyenv virtualenv-init -)"'; } >> /home/gitpod/.bashrc.d/60-python \
    && pyenv update \
    && pyenv install 3.8.12 \
    && pyenv global 3.8.12 \
    && python3 -m pip install --no-cache-dir --upgrade pip \
    && python3 -m pip install --no-cache-dir --upgrade \
        setuptools wheel virtualenv pipenv pylint rope flake8 \
        mypy autopep8 pep8 pylama pydocstyle bandit notebook \
        twine poetry \
    && sudo rm -rf /tmp/*
ENV PIP_USER=no
ENV PIPENV_VENV_IN_PROJECT=true
ENV PYTHONUSERBASE=/workspace/.pip-modules
ENV PATH=$PYTHONUSERBASE/bin:$PATH

# Spark
RUN mkdir $HOME/spark && cd $HOME/spark \
 && curl -fsSL https://www.apache.org/dyn/closer.lua/spark/spark-3.1.3/spark-3.1.3-bin-hadoop3.2.tgz | tar xz
ENV SPARK_HOME=$HOME/spark/spark-3.1.3-bin-hadoop3.2
ENV PYTHONPATH=$HOME/spark/spark-3.1.3-bin-hadoop3.2/python/pyspark

USER root

RUN mkdir -p $PYTHONUSERBASE && chown gitpod $PYTHONUSERBASE

USER gitpod