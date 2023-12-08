FROM hpcaitech/cuda-conda:11.7

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# create virtual env
RUN  source /opt/conda/bin/activate base \
  && conda create -n pytorch python=3.8

# install pytorch
RUN source /opt/conda/bin/activate pytorch \
  && conda install -y pip \
  && conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.7 -c pytorch -c nvidia \
  && pip install packaging

# install apex
RUN cd /root \
  && source /opt/conda/bin/activate pytorch \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && git checkout 2386a912164b0c5cfcd8be7a2b890fbac5607c82 \
  && pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

# install xformer
RUN source /opt/conda/bin/activate pytorch \
  && pip install ninja \
  && pip install -v git+https://github.com/facebookresearch/xformers.git@82254f4b0d9c625f7efa8d6671f58144e441901d

# install flash-attention
RUN cd /root \
  && source /opt/conda/bin/activate pytorch \
  && git clone -b v2.0.5 https://github.com/Dao-AILab/flash-attention \
  && cd flash-attention/ \
  && python setup.py install \
  && rm -rf /root/flash-attention

ENV PATH "/opt/conda/envs/pytorch/bin:$PATH"

RUN conda init bash && echo "conda activate pytorch" >> /root/.bashrc
