FROM hpcaitech/cuda-conda:11.6

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# create virtual env
RUN  source /opt/conda/bin/activate base \
  && conda create -n pytorch python=3.8

# install pytorch
RUN source /opt/conda/bin/activate pytorch \
  && conda install -y pip \
  && conda install pytorch==1.13.0 torchvision==0.14.0 torchaudio==0.13.0 pytorch-cuda=11.6 -c pytorch -c nvidia \
  && pip install packaging

# install apex
RUN cd /root \
  && source /opt/conda/bin/activate pytorch \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && git reset 2958e06e094146798ae42a748a77a509fd4695a0 \
  && pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

# install xformer
RUN source /opt/conda/bin/activate pytorch \ 
  && pip install -v -U git+https://github.com/facebookresearch/xformers.git@main#egg=xformers

ENV PATH "/opt/conda/envs/pytorch/bin:$PATH"
