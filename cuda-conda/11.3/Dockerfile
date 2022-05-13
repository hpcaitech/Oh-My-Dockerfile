FROM nvidia/cuda:11.3.0-cudnn8-devel-ubi8

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# install tools
RUN yum install -y wget vim git gettext unzip 

# install conda
RUN cd /opt \
  && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
  && rm Miniconda3-latest-Linux-x86_64.sh

RUN mkdir /workspace

ENV PATH "/opt/conda/bin:$PATH"
ENV CUDA_HOME "/usr/local/cuda"
WORKDIR /workspace

