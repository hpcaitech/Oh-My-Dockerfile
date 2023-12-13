FROM hpcaitech/ascend-toolkit:7.0.0.alpha002-ubuntu22.04-aarch64

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

ARG DEBIAN_FRONTEND=noninteractive

# install tools
RUN apt update -y && \
  apt install -y software-properties-common && \
  apt update -y && \
  apt install -y openssh-server libcurl4-gnutls-dev libexpat1-dev gettext libz-dev && \
  apt clean && rm -rf /var/lib/apt/lists/*


# install pytorch
RUN pip install -U pip && \
  pip install numpy decorator sympy cffi pyyaml pathlib2 protobuf==3.19.0 attrs attr scipy requests psutil absl-py torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 packaging ninja cloudpickle synr==0.5.0 tornado setuptools==65.7.0 && \
  git clone https://gitee.com/ascend/pytorch.git -b v2.1.0 --depth 1 && \
  cd pytorch && \
  bash ci/build.sh --python=3.10 && \
  pip install dist/torch_npu-2.1.0*.whl && \
  cd /root && \
  rm -rf pytorch && \
  rm -rf /root/.cache/pip


# install apex
# hack apex install
RUN ln -s /usr/local/lib/python3.10/dist-packages /usr/lib/python3.10/site-packages && \
 git clone -b master https://gitee.com/ascend/apex.git && \
  cd apex/ && \
  bash scripts/build.sh --python=3.10 && \
  cd apex/dist/ && \
  pip install apex-0.1*.whl && \
  cd /root && \
  rm -rf apex
