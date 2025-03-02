# FROM ubuntu:18.04
# RUN apt-get update && apt-get -y upgrade \
#     && apt-get -y install vim \
#     && apt-get -y install unzip zip \
#     && apt-get -y install net-tools \
#     && apt-get -y install liblzma-dev \ 
#     && apt-get -y install libsndfile1 libsqlite3-dev\
#     && apt -y install build-essential zlib1g-dev libbz2-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget \
#     && wget https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz \
#     && tar -xzvf Python-3.7.6.tgz \
#     && cd Python-3.7.6 \
#     && ./configure --prefix=/usr/local/src/python37 \
#     && make && make install \
#     && rm -rf /usr/bin/python \
#     && ln -s /usr/local/src/python37/bin/python3.7 /usr/bin/python \
#     && ln -s /usr/local/src/python37/bin/pip3.7 /usr/bin/pip \
#     && pip install --upgrade pip \
#     && pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
#     && pip install jieba colorlog colorama seqeval multiprocess datasets>=2.0.0 tqdm paddlefsl sentencepiece paddle2onnx \
#     && pip install pymilvus>=1.1.2 \
#     && pip install pandas==0.25.1 paddlenlp>=2.1.1 paddlepaddle-gpu>=2.1.3 hnswlib>=0.5.2 numpy>=1.17.2 visualdl>=2.2.2 paddle-serving-app>=0.7.0 paddle-serving-client>=0.7.0 paddle-serving-server-gpu>=0.7.0.post102 pybind11 

# FROM nvidia/cuda:11.7.1-cudnn8-devel-ubuntu18.04

# RUN apt update && \
#     apt install -y \
#         wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
#         libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev

# WORKDIR /temp

# # 下载python
# RUN wget https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz && \
#     tar -xvf Python-3.8.10.tgz

# # 编译&安装python
# RUN cd Python-3.8.10 && \
#     ./configure --enable-optimizations && \
#     make && \
#     make install

# WORKDIR /workspace

# RUN rm -r /temp && \
#     ln -s /usr/local/bin/python3 /usr/local/bin/python && \
#     ln -s /usr/local/bin/pip3 /usr/local/bin/pip


# # 安装pytorch
# # https://pytorch.org/get-started/locally/
# RUN pip install torch==1.13.0+cu117 torchvision==0.14.0+cu117 torchaudio==0.13.0 --extra-index-url https://download.pytorch.org/whl/cu117

#syntax = docker/dockerfile:1.4

# FROM ollama/ollama:latest AS ollama
# FROM babashka/babashka:latest

# # just using as a client - never as a server
# COPY --from=ollama /bin/ollama ./bin/ollama

# COPY <<EOF pull_model.clj
# (ns pull-model
#   (:require [babashka.process :as process]
#             [clojure.core.async :as async]))

# (try
#   (let [llm (get (System/getenv) "LLM")
#         url (get (System/getenv) "OLLAMA_BASE_URL")]
#     (println (format "pulling ollama model %s using %s" llm url))
#     (if (and llm url (not (#{"gpt-4" "gpt-3.5" "claudev2"} llm)))

#       ;; ----------------------------------------------------------------------
#       ;; just call `ollama pull` here - create OLLAMA_HOST from OLLAMA_BASE_URL
#       ;; ----------------------------------------------------------------------
#       ;; TODO - this still doesn't show progress properly when run from docker compose

#       (let [done (async/chan)]
#         (async/go-loop [n 0]
#           (let [[v _] (async/alts! [done (async/timeout 5000)])]
#             (if (= :stop v) :stopped (do (println (format "... pulling model (%ss) - will take several minutes" (* n 10))) (recur (inc n))))))
#         (process/shell {:env {"OLLAMA_HOST" url} :out :inherit :err :inherit} (format "bash -c './bin/ollama show %s --modelfile > /dev/null || ./bin/ollama pull %s'" llm llm))
#         (async/>!! done :stop))

#       (println "OLLAMA model only pulled if both LLM and OLLAMA_BASE_URL are set and the LLM model is not gpt")))
#   (catch Throwable _ (System/exit 1)))
# EOF

# ENTRYPOINT ["bb", "-f", "pull_model.clj"]

# FROM tugraph/tugraph-runtime-centos7:latest

# FROM  dalf/morty:latest
# USER  root

# WORKDIR /ragflow

# ADD ./web ./web
# RUN cd ./web && npm i --force && npm run build

# ADD ./api ./api
# ADD ./conf ./conf
# ADD ./deepdoc ./deepdoc
# ADD ./rag ./rag
# ADD ./graph ./graph

# ENV PYTHONPATH=/ragflow/
# ENV HF_ENDPOINT=https://hf-mirror.com

# ADD docker/entrypoint.sh ./entrypoint.sh
# # ADD docker/.env ./
# RUN chmod +x ./entrypoint.sh

# ENTRYPOINT ["./entrypoint.sh"]

# Basic setup
# FROM python:3.11-slim-bookworm

# # add git lhs to apt
# RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash

# # Update and install necessary packages
# RUN apt-get update && apt-get -y update
# # added vim and nano for convenience
# RUN apt-get install -y sudo git npm vim nano curl wget git-lfs

# # Setup a non-root user 'autogen' with sudo access
# RUN adduser --disabled-password --gecos '' autogen
# RUN adduser autogen sudo
# RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# USER autogen
# WORKDIR /home/autogen

# # Set environment variable
# # ENV OPENAI_API_KEY="{OpenAI-API-Key}"

# # Clone the AutoGen repository
# # RUN git clone https://github.com/microsoft/autogen.git /home/autogen/autogen
# # WORKDIR /home/autogen/autogen

# # Install AutoGen in editable mode with extra components
# # RUN sudo pip install -e .[test,teachable,lmm,retrievechat,mathchat,blendsearch]

# # Install pre-commit hooks
# # RUN pre-commit install

# # Setup Docusaurus and Yarn for the documentation website
# RUN sudo npm install --global yarn
# RUN sudo pip install pydoc-markdown
# RUN cd website
# RUN yarn install --frozen-lockfile --ignore-engines

# RUN arch=$(arch | sed s/aarch64/arm64/ | sed s/x86_64/amd64/) && \
#     wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.23/quarto-1.5.23-linux-${arch}.tar.gz && \
#     mkdir -p /home/autogen/quarto/ && \
#     tar -xzf quarto-1.5.23-linux-${arch}.tar.gz --directory /home/autogen/quarto/ && \
#     rm quarto-1.5.23-linux-${arch}.tar.gz

# ENV PATH="${PATH}:/home/autogen/quarto/quarto-1.5.23/bin/"

# # Exposes the Yarn port for Docusaurus
# EXPOSE 3000

# # Pre-load popular Python packages
# RUN pip install --upgrade pip
# RUN pip install numpy pandas matplotlib seaborn scikit-learn requests urllib3 nltk pillow pytest beautifulsoup4

# # Set the default command to bash
# CMD ["/bin/bash"]


# Stage 1: Build stage
# FROM  mongodb/mongodb-community-server:latest
# FROM nvcr.io/nvidia/cuda:12.3.2-cudnn9-devel-ubuntu22.04

# RUN apt update && \
#     apt install -y \
#         wget build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
#         libreadline-dev libffi-dev libsqlite3-dev libbz2-dev liblzma-dev vim git

# WORKDIR /temp

# # 下载python
# RUN wget https://www.python.org/ftp/python/3.11.7/Python-3.11.7.tgz && \
#     tar -xvf Python-3.11.7.tgz

# # 编译&安装python
# RUN cd Python-3.11.7 && \
#     ./configure --enable-optimizations && \
#     make && \
#     make install

# WORKDIR /workspace

# RUN rm -r /temp && \
#     ln -s /usr/local/bin/python3 /usr/local/bin/python && \
#     ln -s /usr/local/bin/pip3 /usr/local/bin/pip && \
#     pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \ 
#     git clone https://github.com/chatchat-space/Langchain-Chatchat.git && cd Langchain-Chatchat && git checkout v0.2.10 && \  
#     pip install -r requirements.txt && pip install -r requirements_api.txt &&  pip install -r requirements_webui.txt && pip install pymongo && \
#     cd .. && rm -rf Langchain-Chatchat
# EXPOSE 7861 8501

FROM nvcr.io/nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# RUN apt update && apt install -y cmake && apt install -y pkg-config && \
# cd llama.cpp-* && \
# cmake -B build -DGGML_CUDA=ON && \ 
# cmake --build build --config Release -j$(nproc)
