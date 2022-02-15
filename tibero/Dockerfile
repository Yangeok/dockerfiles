FROM ubuntu:20.04

USER root

ADD profile /etc/profile

COPY tmax /usr/local

WORKDIR /usr/local

RUN apt update &&\
  apt install -y vim xclip libaio1 libncurses5 openjdk-8-jre language-pack-ko

RUN tar -xvzf tibero6-bin-FS07_CS_2005-linux64-186930-opt-tested.tar.gz

USER root