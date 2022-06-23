FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# setup repository
RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg lsb-release && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# install docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


# setup nv repo
RUN curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | apt-key add - && \
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | tee /etc/apt/sources.list.d/nvidia-container-runtime.list

# install nv runtime
RUN apt-get update && \
    apt-get install -y nvidia-container-toolkit && \
    apt-get install -y nvidia-container-runtime

RUN mkdir /workspace && mkdir /etc/docker

COPY daemon.json /etc/docker/daemon.json

WORKDIR /workspace