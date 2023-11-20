# syntax=docker/dockerfile:1
FROM ubuntu:22.04
RUN apt-get -y update && apt-get install -y python
