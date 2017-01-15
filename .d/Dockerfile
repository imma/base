#      _            _             
#   __| | ___   ___| | _____ _ __ 
#  / _` |/ _ \ / __| |/ / _ \ '__|
# | (_| | (_) | (__|   <  __/ |   
#  \__,_|\___/ \___|_|\_\___|_|   
                                
FROM cache.nih/block:base
                 
#   ___ _ ____   __
#  / _ \ '_ \ \ / /
# |  __/ | | \ V / 
#  \___|_| |_|\_/  

ARG CACHE
ARG SERIAL

RUN echo ${SERIAL}
ENV http_proxy http://${CACHE}:3128
ENV https_proxy http://${CACHE}:3128

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

RUN apt-get update -y
RUN apt-get install -y software-properties-common python-software-properties aptitude
RUN env - add-apt-repository ppa:git-core/ppa
RUN aptitude update -y && aptitude upgrade -y
RUN aptitude install -y net-tools sudo cloud-init git openssh-server curl unzip perl ruby python language-pack-en build-essential vim man screen tmux

ADD etc/99_nonet.cfg /etc/cloud/cloud.cfg.d/99_nonet.cfg
RUN cloud-init init

#        _                 _         
#  _   _| |__  _   _ _ __ | |_ _   _ 
# | | | | '_ \| | | | '_ \| __| | | |
# | |_| | |_) | |_| | | | | |_| |_| |
#  \__,_|_.__/ \__,_|_| |_|\__|\__,_|
                                   
USER ubuntu

RUN mkdir -p ~/.ssh && touch ~/.ssh/authorized_keys

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

RUN mkdir -p /var/run/sshd

ENTRYPOINT exec /usr/sbin/sshd -De -p 2222
