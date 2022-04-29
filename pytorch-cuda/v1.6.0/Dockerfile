FROM nvidia/cuda:10.2-cudnn7-devel-ubi7 

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# install tools
RUN yum update -y \
 && yum install -y wget vim git python38

# install conda
RUN mkdir /workspace \
 && cd /root \
 && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
 && bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda3 \
 && rm Miniconda3-latest-Linux-x86_64.sh

# create virtual env
RUN  source /root/miniconda3/bin/activate base \
 && conda create -n pytorch python=3.6

# install pytorch
# install torch and apex
RUN source /root/miniconda3/bin/activate pytorch \
 && conda install -y pip \
 && pip install ninja torch==1.6.0 torchvision==0.7.0

 # install apex
 RUN cd /root \
  && source /root/miniconda3/bin/activate pytorch \
  && conda install -y -c omgarcia gcc-6 \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

ENV PATH "/root/miniconda3/envs/pytorch/bin:$PATH"

WORKDIR /workspace

