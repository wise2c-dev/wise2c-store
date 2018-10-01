FROM alpine:3.8
MAINTAINER zhouyi

RUN mkdir /store
COPY ./store/alanpeng-keepalived-2.0.tar           /store
COPY ./store/haproxy-1.7.tar.bz2                   /store
COPY ./store/harbor-offline-installer-v1.5.1.tgz   /store
COPY ./store/k8s.tar.bz2                           /store
COPY ./store/mysql-5.7.tar.bz2                     /store

RUN ls /store