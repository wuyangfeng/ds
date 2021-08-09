FROM ubuntu:18.04
RUN apt-get update && apt-get -y upgrade \
    && apt-get -y install vim \
    && apt-get -y install unzip zip \
    && apt-get -y install net-tools \
    && apt -y install build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget \
    && wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
    && tar -xzvf Python-3.7.4.tgz \
    && cd Python-3.7.4 \
    && ./configure --prefix=/usr/local/src/python37 \
    && make && make install \
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/src/python37/bin/python3.7 /usr/bin/python \
    && ln -s /usr/local/src/python37/bin/pip3.7 /usr/bin/pip \
    && pip install --upgrade pip \
    && pip install torch==1.7.0 torchvision==0.8.0 torchaudio==0.7.0\
    && pip install opencv-contrib-python==4.2.0.34 \
    && apt-get -y install libglib2.0-dev libsm6 libxrender1 libxext-dev \
    && pip install pillow==7.1.2 \
    && pip install pyyaml==5.3.1 \
    && pip install scipy==1.3.1 \
    && pip install requests \
    && pip install flask \
    && pip install fastapi \
    && pip install uvicorn \
    && cd /root/.cacche && mkdir torch && cd torch && mkdir hub && cd hub && mkdir checkpoints
    
EXPOSE 80 81
