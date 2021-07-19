FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade \
    && apt install build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget \
    && wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
    && tar -xzvf Python-3.7.4.tgz \
    && cd Python-3.7.4 \
    && ./configure --prefix=/usr/local/src/python37 \
    && make && make install \
    && rm -rf /usr/bin/python \
    && ln -s /usr/local/src/python37/bin/python3.7 /usr/bin/python \
    && ln -s /usr/local/src/python37/bin/pip3.7 /usr/bin/pip \
    && pip install torch==1.6.0 torchvision==0.7.0 \
    && pip install opencv-contrib-python==4.2.0.34 \
    && pip install pillow==7.1.2 
    
