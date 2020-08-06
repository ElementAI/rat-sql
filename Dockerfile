FROM  pytorch/pytorch:1.5-cuda10.1-cudnn7-devel
# Using a Pytorch base image because it has both Python and CUDA

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && apt-get install -y \
    build-essential \
    cifs-utils \
    curl \
    default-jdk \
    dialog \
    dos2unix \
    git \
    sudo

# Install app requirements first to avoid invalidating the cache
COPY requirements.txt setup.py /app/
WORKDIR /app
RUN pip install -r requirements.txt && \
    pip install entmax

# Make sure to download nltk data in a globally available location
RUN python -m nltk.downloader -d /usr/local/share/nltk_data punkt stopwords

# Download & cache StanfordNLP
RUN mkdir -p /app/third_party && \
    cd /app/third_party && \
    curl https://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip | jar xv

# Now copy the rest of the app
COPY . /app/

# Assume that there is a data directory to which Glove vectors will be downloaded
ENV CACHE_DIR=data

# Convert all shell scripts to Unix line endings, if any
RUN /bin/bash -c 'if compgen -G "/app/**/*.sh" > /dev/null; then dos2unix /app/**/*.sh; fi' 
