FROM nvidia/cuda:11.0.3-cudnn8-devel-ubuntu18.04

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "-c"]

RUN apt update -y && apt install -y git wget

# install conda
RUN mkdir /workspace \
  && cd /root \
  && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda3 \
  && rm Miniconda3-latest-Linux-x86_64.sh

# create virtual env
RUN  source /root/miniconda3/bin/activate base \
  && conda create -n pytorch python=3.8

# install pytorch
# install torch and apex
RUN source /root/miniconda3/bin/activate pytorch \
  && conda install -y pip \
  && pip install ninja torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

# install apex
 RUN cd /root \
  && source /root/miniconda3/bin/activate pytorch \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

ENV PATH "/root/miniconda3/envs/pytorch/bin:$PATH"
  
WORKDIR /workspace

