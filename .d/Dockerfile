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
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
RUN apt-get install -y cloud-init sudo net-tools

RUN find /etc/ssh -ls
RUN cloud-init init
RUN find /etc/ssh -ls
RUN cloud-init modules
RUN cloud-init modules -m final
RUN usermod -p '*' ubuntu

ADD etc/rc.local /etc/rc.local
ADD etc/rc.server /etc/rc.server

RUN apt-get install -y -qq \
    bash \
    bash-completion \
    bc \
    biosdevname \
    ca-certificates \
    cloud-init \
    cron \
    curl \
    dbus \
    dstat \
    ethstatus \
    file \
    fio \
    htop \
    ifenslave \
    ioping \
    iotop \
    iperf \
    iptables \
    iputils-ping \
    less \
    locate \
    lsb-release \
    lsof \
    make \
    man-db \
    mdadm \
    mg \
    mosh \
    mtr \
    multipath-tools \
    nano \
    net-tools \
    netcat \
    nmap \
    ntp \
    ntpdate \
    open-iscsi \
    python-apt \
    python-yaml \
    rsync \
    rsyslog \
    screen \
    shunit2 \
    socat \
    software-properties-common \
    ssh \
    sudo \
    sysstat \
    tar \
    tcpdump \
    tmux \
    traceroute \
    unattended-upgrades \
    uuid-runtime \
    vim \
    wget

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*
                                   
ENTRYPOINT [ "/etc/rc.server" ]
CMD [ "-p", "2222" ]
