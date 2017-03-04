FROM docker.nih/block:base

ARG CACHE

USER root

ENV http_proxy http://${CACHE}:3128
ENV https_proxy http://${CACHE}:3128

ADD etc/99_nonet.cfg /etc/cloud/cloud.cfg.d/99_nonet.cfg
ADD cidata/user-data /var/lib/cloud/seed/nocloud/user-data
ADD cidata/meta-data /var/lib/cloud/seed/nocloud/meta-data
RUN apt-get update
RUN apt-get install -y cloud-init sudo net-tools
RUN cloud-init init
RUN cloud-init modules
RUN cloud-init modules -m final
                                   
ENTRYPOINT [ "/usr/sbin/sshd", "-De" ]
CMD [ "-p", "2222" ]
