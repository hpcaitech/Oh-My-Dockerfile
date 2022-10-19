ARG IMAGE_TAG
FROM hpcaitech/pytorch-cuda:${IMAGE_TAG}

ARG COLO_VERSION
ARG TORCH_SHORT_VERSION
ARG CUDA_SHORT_VERSION

# install colossalai
RUN pip install colossalai==${COLO_VERSION}+torch${TORCH_SHORT_VERSION}cu${CUDA_SHORT_VERSION} -f https://release.colossalai.org 
