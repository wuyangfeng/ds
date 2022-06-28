FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install vim \
    && apt-get -y install unzip zip \
    && apt-get -y install net-tools \
    && apt-get -y install liblzma-dev \ 
    && apt-get -y install libsndfile1 libsqlite3-dev\
    && apt -y install build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget \
    && wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz \
    && tar -xzvf Python-3.7.6.tgz \
    && cd Python-3.7.6 \
    && ./configure --prefix=/usr/local/src/python37 \
    && make && make install \
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/src/python37/bin/python3.7 /usr/bin/python \
    && ln -s /usr/local/src/python37/bin/pip3.7 /usr/bin/pip \
    && pip install --upgrade pip \
    && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install jieba colorlog colorama seqeval multiprocess datasets>=2.0.0 tqdm paddlefsl sentencepiece paddle2onnx \
    && pip install pymilvus>=1.1.2 \
    && pip install pandas==0.25.1 paddlenlp>=2.1.1 paddlepaddle-gpu>=2.1.3 hnswlib>=0.5.2 numpy>=1.17.2 visualdl>=2.2.2 paddle-serving-app>=0.7.0 paddle-serving-client>=0.7.0 paddle-serving-server-gpu>=0.7.0.post102 pybind11
    && cd /home \
    && git clone https://github.com/PaddlePaddle/PaddleNLP.git
    
