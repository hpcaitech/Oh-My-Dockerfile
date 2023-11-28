FROM hpcaitech/ascend-toolkit:7.0.rc1-ubuntu22.04-aarch64

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

# install tools
RUN apt update -y && \
  apt install -y software-properties-common && \
  apt update -y && \
  apt install -y openssh-server libcurl4-gnutls-dev libexpat1-dev gettext libz-dev && \
  apt clean && rm -rf /var/lib/apt/lists/*

# install conda
RUN cd /opt && \
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh && \
  bash Miniconda3-latest-Linux-aarch64.sh -b -p /opt/conda && \
  rm Miniconda3-latest-Linux-aarch64.sh

ENV PATH "/opt/conda/bin:$PATH"

# create virtual env
RUN  source /opt/conda/bin/activate base && \
 conda create -n pytorch python=3.10

# install pytorch
RUN source /opt/conda/bin/activate pytorch && \
  pip install -U pip && \
  pip install numpy decorator sympy cffi pyyaml pathlib2 protobuf==3.19.0 attrs attr scipy requests psutil absl-py torch==2.1.0 torch-npu==2.1.0rc1 torchvision==0.16.0 torchaudio==2.1.0 packaging ninja cloudpickle synr==0.5.0 tornado setuptools==65.7.0 && \
  rm -rf /root/.cache/pip

# install apex
RUN source /opt/conda/bin/activate pytorch && \
  git clone -b master https://gitee.com/ascend/apex.git && \
  cd apex/ && \
  bash scripts/build.sh --python=3.10 && \
  cd apex/dist/ && \
  pip install apex-0.1*.whl && \
  cd /root && \
  rm -rf apex

ENV PATH "/opt/conda/envs/pytorch/bin:$PATH"

RUN conda init bash && echo "conda activate pytorch" >> /root/.bashrc