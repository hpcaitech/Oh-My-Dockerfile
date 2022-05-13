FROM frankleeeee/pytorch-cuda:1.10.1-11.3.0

# install dependencies
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
 && pip install -U pip setuptools wheel \
 && pip install pytest tensorboard

# install colossalai
RUN git clone https://github.com/hpcaitech/ColossalAI.git \
 && cd ./ColossalAI \
 && pip install -v .