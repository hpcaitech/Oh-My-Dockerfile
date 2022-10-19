#!/usr/bin/env bash

COLO_VERSION=$1
TORCH_VERSION=$2
CUDA_VERSION=$3

[ -z "$COLO_VERSION" ] && echo "Colossal-AI version is not given in argument 1" && exit
[ -z "$TORCH_VERSION" ] && echo "PyTorch version is not given in argument 2" && exit
[ -z "$CUDA_VERSION" ] && echo "CUDA version is not given in argument 3" && exit

IMAGE_TAG=${TORCH_VERSION}-${CUDA_VERSION}
TORCH_SHORT_VERSION=$(echo $TORCH_VERSION | cut -d "." -f 1,2)
CUDA_SHORT_VERSION=$(echo $CUDA_VERSION | cut -d "." -f 1,2)

docker build -t hpcaitech/colossalai:${COLO_VERSION}-torch${TORCH_SHORT_VERSION}-cu${CUDA_SHORT_VERSION} \
    --build-arg COLO_VERSION=$COLO_VERSION \
    --build-arg TORCH_SHORT_VERSION=$TORCH_SHORT_VERSION \
    --build-arg CUDA_SHORT_VERSION=$CUDA_SHORT_VERSION \
    --build-arg IMAGE_TAG=$IMAGE_TAG \
    $PWD
