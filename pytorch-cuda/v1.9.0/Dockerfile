FROM hpcaitech/cuda-conda:11.1

SHELL ["/bin/bash", "-c"] 

# create virtual env
RUN  source /opt/conda/bin/activate base \
 && conda create -n pytorch python=3.8

# install pytorch
RUN source /opt/conda/bin/activate pytorch \
 && conda install -y pip \
 && pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html

# install apex
 RUN cd /root \
  && source /opt/conda/bin/activate pytorch \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && pip install packaging \
  && pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

ENV PATH "/opt/conda/envs/pytorch/bin:$PATH"
