FROM docker.nih/block:base

ARG SERIAL
ARG CACHE

USER root

ENV http_proxy http://${CACHE}:3128
ENV https_proxy http://${CACHE}:3128

RUN apt-get update -y
RUN apt-get install -y software-properties-common python-software-properties aptitude
RUN env - add-apt-repository -y ppa:git-core/ppa
RUN env - add-apt-repository -y ppa:ubuntu-lxc/lxd-stable
RUN aptitude update -y && aptitude upgrade -y
RUN aptitude install -y net-tools sudo cloud-init git openssh-server curl unzip perl ruby python language-pack-en build-essential vim man screen tmux

ADD etc/99_nonet.cfg /etc/cloud/cloud.cfg.d/99_nonet.cfg
RUN cloud-init init
                                   
USER ubuntu

RUN mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys

USER root

RUN mkdir -p /var/run/sshd

ENTRYPOINT [ "/usr/sbin/sshd", "-De" ]
CMD [ "-p", "2222" ]
