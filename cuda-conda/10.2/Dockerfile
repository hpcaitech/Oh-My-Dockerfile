FROM nvidia/cuda:10.2-devel-ubuntu18.04

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# install tools
RUN apt update -y \
  && apt install -y software-properties-common \
  && apt update -y \
  && apt install -y wget vim build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip libz-dev

# install git
RUN wget https://github.com/git/git/archive/v2.18.0.zip \
  && unzip v2.18.0.zip \
  && cd ./git-2.18.0 \
  && make prefix=/usr/local all \
  && make prefix=/usr/local install

# install conda
RUN cd /opt \
  && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
  && rm Miniconda3-latest-Linux-x86_64.sh

RUN mkdir /workspace

ENV PATH "/opt/conda/bin:$PATH"
ENV CUDA_HOME "/usr/local/cuda"
WORKDIR /workspace
