FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install vim \
    && apt-get -y install unzip zip \
    && apt-get -y install net-tools \
    && apt-get -y install liblzma-dev \ 
    && apt -y install build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget \
    && wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tgz \
    && tar -xzvf Python-3.8.13.tgz \
    && cd Python-3.8.13 \
    && ./configure --prefix=/usr/local/src/python38 \
    && make && make install \
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/src/python36/bin/python3.8 /usr/bin/python \
    && ln -s /usr/local/src/python36/bin/pip3.8 /usr/bin/pip 
