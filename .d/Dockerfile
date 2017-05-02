FROM docker.nih/block:base

ARG CACHE

USER root

ENV http_proxy http://${CACHE}:3128
ENV https_proxy http://${CACHE}:3128

ENV DEBIAN_FRONTEND=noninteractive

ADD etc/99_nonet.cfg /etc/cloud/cloud.cfg.d/99_nonet.cfg
ADD cidata/user-data /var/lib/cloud/seed/nocloud/user-data
ADD cidata/meta-data /var/lib/cloud/seed/nocloud/meta-data

RUN echo 1

RUN apt-get update
RUN apt-get install -y cloud-init sudo net-tools locales
RUN apt-get upgrade -y
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

RUN cloud-init init
RUN cloud-init modules
RUN cloud-init modules -m final
RUN usermod -p '*' ubuntu

ADD etc/rc.local /etc/rc.local
ADD etc/rc.server /etc/rc.server

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*

USER ubuntu
RUN ssh -o StrictHostKeyChecking=no git@github.com true 2>/dev/null || true

USER root
ENTRYPOINT [ "/etc/rc.server" ]
CMD [ "-p", "2222" ]

