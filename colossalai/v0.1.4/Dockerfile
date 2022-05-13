FROM frankleeeee/pytorch-cuda:1.10.1-11.3.0

# install dependencies
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
 && pip install -U pip setuptools wheel \
 && pip install pytest tensorboard

# install colossalai
RUN pip install colossalai==0.1.4+torch1.10cu11.3 -f https://release.colossalai.org 
