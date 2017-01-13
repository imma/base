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
ENV http_proxy ${CACHE}
ENV https_proxy ${CACHE}

#                  _   
#  _ __ ___   ___ | |_ 
# | '__/ _ \ / _ \| __|
# | | | (_) | (_) | |_ 
# |_|  \___/ \___/ \__|

USER root

RUN apt-get update -y && apt-get install -y aptitude && aptitude upgrade -y

RUN aptitude install -y net-tools sudo cloud-init
ADD etc/99_nonet.cfg /etc/cloud/cloud.cfg.d/99_nonet.cfg
RUN cloud-init init

RUN aptitude install -y openssh-server && mkdir -p /var/run/sshd

RUN aptitude install -y git curl unzip perl language-pack-en build-essential python ruby vim man screen tmux

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

ENTRYPOINT exec /usr/sbin/sshd -De -p 2222
