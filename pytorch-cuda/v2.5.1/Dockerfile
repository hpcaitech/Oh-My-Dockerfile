FROM hpcaitech/cuda-conda:12.4

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# create virtual env
RUN  source /opt/conda/bin/activate base \
 && conda create -n pytorch python=3.10

# install pytorch
RUN source /opt/conda/bin/activate pytorch \
  && conda install -y pip \
  && conda install -y pytorch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 pytorch-cuda=12.4 -c pytorch -c nvidia


# install apex
RUN cd /root \
  && source /opt/conda/bin/activate pytorch \
  && git clone https://github.com/NVIDIA/apex \
  && cd apex \
  && pip install packaging ninja \
  && pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./ \
  && cd .. \
  && rm -rf ./apex

# install xformer
RUN source /opt/conda/bin/activate pytorch \
    && pip install xformers==v0.0.29

ENV PATH "/opt/conda/envs/pytorch/bin:$PATH"

RUN conda init bash && echo "conda activate pytorch" >> /root/.bashrc
