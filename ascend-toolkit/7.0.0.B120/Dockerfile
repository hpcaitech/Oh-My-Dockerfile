FROM ubuntu:22.04

WORKDIR /tmp

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --no-install-recommends -y ca-certificates build-essential cmake git wget vim curl bc pkg-config unzip \
    libblas3 liblapack3 gfortran liblapack-dev libblas-dev libhdf5-dev libffi-dev \
    libssl-dev zlib1g-dev xz-utils \
    libopenblas-dev libgmpxx4ldbl liblzma-dev \
    libxml2 pciutils libgl1-mesa-glx libbz2-dev && \
    apt clean && rm -rf /var/lib/apt/lists/*

# install python
RUN cd /opt && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh && \
    bash Miniconda3-latest-Linux-aarch64.sh -b -p /opt/conda && \
    rm Miniconda3-latest-Linux-aarch64.sh

# add conda to path
ENV PATH "/opt/conda/bin:$PATH"

# create python 3.9
RUN . /opt/conda/bin/activate base \
    && conda create -y -n torch python=3.9

# python environment
RUN . /opt/conda/bin/activate torch && \
    pip config set global.extra-index-url "https://pypi.tuna.tsinghua.edu.cn/simple" && \
    pip install numpy decorator sympy cffi pyyaml pathlib2 protobuf==3.19.0 attrs attr scipy requests psutil absl-py && \
    rm -rf /root/.cache/pip

ENV PATH "/opt/conda/envs/torch/bin:$PATH"


# copy assets
COPY ./assets /tmp/assets

# environment variables
ENV LD_LIBRARY_PATH=/usr/lib/aarch64-linux-gnu/hdf5/serial:$LD_LIBRARY_PATH

# create linker in lib64 to avoid error when running driver tools on euler host
RUN if [ ! -d "/lib64" ]; \
    then \
        mkdir /lib64 && ln -sf /lib/ld-linux-aarch64.so.1 /lib64/ld-linux-aarch64.so.1; \
    fi

# 1. Driver path environment variable setting
ARG CHIP=all
ARG ASCEND_BASE=/usr/local/Ascend
ENV LD_LIBRARY_PATH=\
$ASCEND_BASE/driver/lib64:\
$ASCEND_BASE/driver/lib64/common:\
$ASCEND_BASE/driver/lib64/driver:\
$LD_LIBRARY_PATH

# 2. install toolkit
ARG TOOLKIT_PKG=assets/Ascend-cann-toolkit_*.run
ARG TOOLKIT_PATH=$ASCEND_BASE/ascend-toolkit/latest
RUN umask 0022 && \
    mkdir -p $ASCEND_BASE/driver && \
    if [ "$CHIP" != "all" ]; \
    then \
        CHIPOPTION="--chip=$CHIP"; \
    else \
        CHIPOPTION=""; \
    fi && \
    chmod +x $TOOLKIT_PKG && \
    ./$TOOLKIT_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all $CHIPOPTION && \
    rm -f $TOOLKIT_PKG

# 3. install kernel package
ARG KERNEL_PKG=assets/Ascend-cann-kernels-910*.run
RUN umask 0022 && \
    chmod +x $KERNEL_PKG && \
    ./$KERNEL_PKG --quiet --install --install-path=$ASCEND_BASE \
    --install-for-all $CHIPOPTION && \
    rm -f $KERNEL_PKG

# 4. install atb
ARG ATB_PKG=assets/Ascend-cann-atb*.run
RUN umask 0022 && \
    chmod +x $ATB_PKG && \
    . /usr/local/Ascend/ascend-toolkit/set_env.sh && \
    ./$ATB_PKG --install && \
    rm -f $ATB_PKG


ENV GLOG_v=2 \
    LD_LIBRARY_PATH=$TOOLKIT_PATH/lib64:$TOOLKIT_PATH/lib64/plugin/opskernel:$TOOLKIT_PATH/lib64/plugin/nnengine:$TOOLKIT_PATH/opp/built-in/op_impl/ai_core/tbe/op_tiling:$TOOLKIT_PATH/fwkacllib/lib64:$LD_LIBRARY_PATH \
    TBE_IMPL_PATH=$TOOLKIT_PATH/opp/op_impl/built-in/ai_core/tbe \
    FWK_PYTHON_PATH=$TOOLKIT_PATH/fwkacllib/python/site-packages \
    PATH=$TOOLKIT_PATH/fwkacllib/ccec_compiler/bin:$TOOLKIT_PATH/fwkacllib/bin:$PATH \
    ASCEND_OPP_PATH=$TOOLKIT_PATH/opp \
    ASCEND_AICPU_PATH=$TOOLKIT_PATH \
    ASCEND_TOOLKIT_HOME=$TOOLKIT_PATH \
    PATH=$TOOLKIT_PATH/bin:$TOOLKIT_PATH/compiler/ccec_compiler/bin:$PATH \
    TOOLCHAIN_HOME=$TOOLKIT_PATH/toolkit \
    ASCEND_HOME_PATH=$TOOLKIT_PATH

ENV PYTHONPATH=\
$TOOLKIT_PATH/python/site-packages:\
$FWK_PYTHON_PATH:\
$FWK_PYTHON_PATH/auto_tune.egg:\
$FWK_PYTHON_PATH/schedule_search.egg:\
$TBE_IMPL_PATH:\
$PYTHONPATH

RUN rm -rf ./*

WORKDIR /root
