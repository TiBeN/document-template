FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
  make \
  pandoc \
  plantuml \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-lang-french \
  wget

RUN wget https://github.com/mikefarah/yq/releases/download/v4.16.1/yq_linux_amd64.tar.gz -O - |\
  tar xz && mv yq_linux_amd64 /usr/bin/yq

RUN apt-get remove -y wget && apt-get -y autoremove

RUN useradd -m --uid=1000 user 

USER 1000:1000

# Configure LateX fonts
RUN mktexpk --mfmode / --bdpi 600 --mag 1+0/600 --dpi 600 tctt1200
RUN mktexpk --mfmode / --bdpi 600 --mag 1+0/600 --dpi 600 ectt1200
