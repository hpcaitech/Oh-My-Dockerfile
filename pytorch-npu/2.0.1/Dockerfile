FROM hpcaitech/ascend-toolkit:7.0.0.B120-ubuntu22.04-aarch64

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

# install tools
RUN apt update -y && \
  apt install -y software-properties-common && \
  apt update -y && \
  apt install -y openssh-server libcurl4-gnutls-dev libexpat1-dev gettext libz-dev && \
  apt clean && rm -rf /var/lib/apt/lists/*

COPY assets/torch_npu-2.0.1.post3+git8462894-cp39-cp39-linux_aarch64.whl /tmp

# install pytorch
RUN pip install -U pip setuptools && \
  pip install numpy decorator sympy cffi pyyaml pathlib2 protobuf==3.19.0 attrs attr scipy requests psutil absl-py packaging ninja cloudpickle synr==0.5.0 tornado setuptools==65.7.0 && \
  pip install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cpu && \
  pip install /tmp/torch_npu-2.0.1.post3+git8462894-cp39-cp39-linux_aarch64.whl && \
  rm -rf /root/.cache/pip && \
  rm /tmp/torch_npu-2.0.1.post3+git8462894-cp39-cp39-linux_aarch64.whl

# install apex
RUN git clone -b master https://gitee.com/ascend/apex.git && \
  cd apex/ && \
  bash scripts/build.sh --python=3.9 && \
  cd apex/dist/ && \
  pip install apex-0.1*.whl && \
  cd /root && \
  rm -rf apex
