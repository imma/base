#      _            _             
#   __| | ___   ___| | _____ _ __ 
#  / _` |/ _ \ / __| |/ / _ \ '__|
# | (_| | (_) | (__|   <  __/ |   
#  \__,_|\___/ \___|_|\_\___|_|   
                                
FROM 172.28.128.1:5000/block:xenial
                 
#   ___ _ ____   __
#  / _ \ '_ \ \ / /
# |  __/ | | \ V / 
#  \___|_| |_|\_/  

ARG http_proxy

ENV http_proxy ${http_proxy}
ENV https_proxy ${http_proxy}

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

RUN apt-get update -y
RUN apt-get install -y aptitude
RUN aptitude upgrade -y

RUN aptitude install -y net-tools sudo cloud-init
ADD etc/99_nonet.cfg /etc/cloud/cloud.cfg.d/99_nonet.cfg
RUN cloud-init init

RUN aptitude install -y openssh-server
RUN mkdir -p /var/run/sshd

RUN aptitude install -y git
RUN aptitude install -y curl unzip perl language-pack-en build-essential
RUN aptitude install -y python ruby
RUN aptitude install -y vim

#        _                 _         
#  _   _| |__  _   _ _ __ | |_ _   _ 
# | | | | '_ \| | | | '_ \| __| | | |
# | |_| | |_) | |_| | | | | |_| |_| |
#  \__,_|_.__/ \__,_|_| |_|\__|\__,_|
                                   
USER ubuntu

RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/authorized_keys

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

ENTRYPOINT exec /usr/sbin/sshd -De
EXPOSE 22
VOLUME /vagrant
