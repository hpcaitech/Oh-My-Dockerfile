FROM ubuntu:18.04

RUN apt update -y \
    && apt install -y vim git wget \
    && mkdir -p /workspace/packages

# install conda
RUN cd /opt \
  && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
  && rm Miniconda3-latest-Linux-x86_64.sh

ENV PATH "/opt/conda/bin:$PATH"

RUN pip install pypiserver

WORKDIR /workspace

ENTRYPOINT ["/opt/conda/bin/pypi-server", "--log-file", "/workspace/packages/log.txt", "/workspace/packages"]