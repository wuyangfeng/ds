FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install vim \
    && apt-get -y install unzip zip \
    && apt-get -y install net-tools \
    && apt-get -y install liblzma-dev \ 
    && apt-get install libsndfile1 -y \
    && apt -y install build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget \
    && wget https://www.python.org/ftp/python/3.8.13/Python-3.8.13.tgz \
    && tar -xzvf Python-3.8.13.tgz \
    && cd Python-3.8.13 \
    && ./configure --prefix=/usr/local/src/python38 \
    && make && make install \
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/src/python38/bin/python3.8 /usr/bin/python \
    && ln -s /usr/local/src/python38/bin/pip3.8 /usr/bin/pip \
    && pip install --upgrade pip \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install paddlepaddle-gpu \
    && pip install paddlespeech \
    && pip install ppgan  \
    && pip install opencv-python-headless \
    && wget http://ffmpeg.org/releases/ffmpeg-4.3.4.tar.gz \
    && tar -zxvf ffmpeg-4.3.4.tar.gz \
    && cd ffmpeg-4.3.4 \
    && apt-get install yasm \
    && ./configure \
    && make & make install \
    && pip install grpcio -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install grpcio-tools -i https://pypi.tuna.tsinghua.edu.cn/simple \
    
