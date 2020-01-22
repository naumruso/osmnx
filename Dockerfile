FROM python:3.7-slim-buster

WORKDIR /osmnx
COPY . /osmnx

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y libproj-dev libproj13
RUN apt-get install -y libpq-dev 
RUN apt-get install -y libspatialindex-c5 libspatialindex-dev libspatialindex5
RUN apt-get install -y libgeos++-dev libgeos-3.7.1 libgeos-c1v5 libgeos-dev
RUN apt-get install -y libblas3 libblas-dev liblapack3 liblapack-dev
RUN apt-get install -y libigraph0v5 libigraph0-dev

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir cython numpy pandas
RUN python3 -m pip install --no-cache-dir -r /osmnx/docker/requirements.txt
RUN python3 -m pip install --no-cache-dir igraph-python

RUN python3 setup.py build
RUN python3 setup.py install

# docker build -t osmnx:python3 .