FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install \
  make \
  pandoc \
  default-jre-headless \
  graphviz \
  texlive-latex-extra \
  texlive-fonts-recommended \
  texlive-lang-french \
  wget

RUN wget https://github.com/mikefarah/yq/releases/download/v4.16.1/yq_linux_amd64.tar.gz -O - |\
  tar xz && mv yq_linux_amd64 /usr/bin/yq

RUN useradd -m --uid=1000 user 

RUN wget https://sourceforge.net/projects/plantuml/files/plantuml-jar-gplv2-1.2022.14.zip -O /tmp/plantuml.zip \
  && mkdir /usr/share/plantuml \
  && cd /usr/share/plantuml \
  && unzip /tmp/plantuml.zip \
  && rm /tmp/plantuml.zip \
  && echo "#!/bin/sh\njava -jar /usr/share/plantuml/plantuml.jar \"\$@\"" > /usr/bin/plantuml \
  && chmod +x /usr/bin/plantuml

RUN apt-get remove -y wget && apt-get -y autoremove

USER 1000:1000

# Configure LateX fonts
RUN mktexpk --mfmode / --bdpi 600 --mag 1+0/600 --dpi 600 tctt1200
RUN mktexpk --mfmode / --bdpi 600 --mag 1+0/600 --dpi 600 ectt1200
