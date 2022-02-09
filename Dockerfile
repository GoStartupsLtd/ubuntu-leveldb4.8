FROM ubuntu:20.04

ENV TZ=Europe/Sofia
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt upgrade -y
RUN apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git cmake libboost-all-dev libgmp3-dev libzmq3-dev
RUN apt install -y software-properties-common
RUN apt install -y wget curl

# Install LevelDB
WORKDIR /root/leveldb
RUN wget -N http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
RUN tar -xvf db-4.8.30.NC.tar.gz
RUN sed -i s/__atomic_compare_exchange/__atomic_compare_exchange_db/g db-4.8.30.NC/dbinc/atomic.h

WORKDIR /root/leveldb/db-4.8.30.NC/build_unix
RUN mkdir -p build
RUN BDB_PREFIX=/usr/local
RUN ../dist/configure --enable-cxx --prefix=$BDB_PREFIX
RUN make
RUN make install

RUN apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler qrencode

WORKDIR /root
