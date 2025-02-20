FROM hpcaitech/ascend-toolkit:8.0.0.beta1-ubuntu22.04-aarch64

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
  pip install torch==2.4.0 --index-url https://download.pytorch.org/whl/cpu && \
  pip install numpy==1.26.4 pyyaml setuptools && \
  pip install torch_npu==2.4.0.post2 && \
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
