#      _            _             
#   __| | ___   ___| | _____ _ __ 
#  / _` |/ _ \ / __| |/ / _ \ '__|
# | (_| | (_) | (__|   <  __/ |   
#  \__,_|\___/ \___|_|\_\___|_|   
                                
FROM ubuntu:xenial
                 
#   ___ _ ____   __
#  / _ \ '_ \ \ / /
# |  __/ | | \ V / 
#  \___|_| |_|\_/  

ENV http_proxy http://172.28.128.1:3128/
ENV https_proxy http://172.28.128.1:3128/

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
