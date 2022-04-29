FROM nvidia/cuda:11.3.0-cudnn8-devel-ubi8

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# install tools
RUN yum install -y wget vim git python38

# install conda
RUN cd /opt \
  && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
  && rm Miniconda3-latest-Linux-x86_64.sh

# install pytorch
# install torch and apex
RUN source /opt/conda/bin/activate base \
  && conda install -y pip \
  && conda install pytorch==1.10.1 torchvision==0.11.2 torchaudio==0.10.1 cudatoolkit=11.3 -c pytorch -c conda-forge

# install apex
RUN cd /root \
  && source /opt/conda/bin/activate base \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

RUN mkdir /workspace

ENV PATH "/opt/conda/bin:$PATH"
ENV CUDA_HOME "/usr/local/cuda"
WORKDIR /workspace

