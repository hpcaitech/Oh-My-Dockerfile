FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

# install tools
RUN apt update -y \
  && apt install -y wget vim git openssh-server build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip libz-dev

# install conda
RUN cd /opt \
  && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
  && rm Miniconda3-latest-Linux-x86_64.sh

RUN mkdir /workspace

ENV PATH "/opt/conda/bin:$PATH"
ENV CUDA_HOME "/usr/local/cuda"
WORKDIR /workspace

