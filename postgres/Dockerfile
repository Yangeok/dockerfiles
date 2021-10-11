ARG POSTGIS_VERSION
FROM postgis/postgis:$POSTGIS_VERSION

# Install Mecab Ko
RUN apt-get update &&\
    apt-get install --no-install-recommends -y build-essential git ca-certificates &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    git clone https://bitbucket.org/eunjeon/mecab-ko.git

WORKDIR /mecab-ko

RUN ./configure &&\
    make all &&\ 
    make install

# Install Mecab Ko Dict
WORKDIR /

RUN apt-get update &&\
    apt-get install --no-install-recommends -y wget apt-transport-https &&\
    wget --progress=dot:giga https://bitbucket.org/eunjeon/mecab-ko-dic/downloads/mecab-ko-dic-2.1.1-20180720.tar.gz &&\
    tar xzf mecab-ko-dic-2.1.1-20180720.tar.gz

WORKDIR /mecab-ko-dic-2.1.1-20180720

RUN ldconfig &&\
    ldconfig -p | grep /usr/local/lib &&\
    apt-get update &&\ 
    apt-get install --no-install-recommends -y dh-autoreconf &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    autoreconf &&\
    ./configure &&\
    make all && make install

# Install Postgres Extention
WORKDIR /

RUN git clone https://github.com/i0seph/textsearch_ko.git

WORKDIR /textsearch_ko

RUN apt-get update &&\
    apt-get install -y postgresql-server-dev-12 &&\
    make USE_PGXS=1 &&\
    make USE_PGXS=1 install &&\
    ldconfig
