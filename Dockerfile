FROM php:5.6-apache
MAINTAINER Klinnex

RUN apt-get update && \
      apt-get install -y\
      rrdtool\
      rm -rf /var/lib/apt/lists/*
      
EXPOSE 80
