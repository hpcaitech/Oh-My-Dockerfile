FROM hpcaitech/cuda-conda:11.7

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# create virtual env
RUN  source /opt/conda/bin/activate base \
 && conda create -n pytorch python=3.8

# install pytorch
RUN source /opt/conda/bin/activate pytorch \
  && conda install -y pip \
  && conda install pytorch==2.0.0 torchvision==0.15.0 torchaudio==2.0.0 pytorch-cuda=11.7 -c pytorch -c nvidia

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
