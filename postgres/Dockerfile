ARG POSTGIS_VERSION
FROM postgis/postgis:$POSTGIS_VERSION

# Install Mecab Ko
RUN apt-get clean &&\
    apt-get update &&\
    apt-get install -y build-essential git &&\
    git clone https://bitbucket.org/eunjeon/mecab-ko.git

WORKDIR /mecab-ko

RUN ./configure &&\
    make all &&\ 
    make install

# Install Mecab Ko Dict
WORKDIR /

RUN apt install wget &&\
    wget https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz &&\
    tar xzf mecab-ko-dic-2.1.1-20180720.tar.gz

WORKDIR /mecab-ko-dic-2.1.1-20180720

RUN ldconfig &&\
    ldconfig -p | grep /usr/local/lib
    
RUN apt update &&\
    apt install -y dh-autoreconf &&\
    autoreconf &&\
    ./configure &&\
    make all && make install

# Install Postgres Extention
WORKDIR /

RUN git clone https://github.com/i0seph/textsearch_ko.git &&\
    cd textsearch_ko &&\
    apt install -y postgresql-server-dev-12 &&\
    make USE_PGXS=1 &&\
    make USE_PGXS=1 install

RUN ldconfig
