ARG BASE_IMAGE="ubuntu:16.04"

FROM ${BASE_IMAGE}

MAINTAINER Michael Mock <michael.mock@gate-7.de>

ENV HOME /root

###################################################################
# cleanup and preparation
#RUN apt-get clean                                      && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*      && \
#    apt-get update                                     && \
#    apt-get -y upgrade                                 && \
#    apt-get -y install locales software-properties-common
RUN apt-get clean                                      && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*      && \
    apt-get -y update                                  && \
    apt-get -y install locales software-properties-common


#RUN echo "Europe/Berlin"  > /etc/timezone
#RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
#RUN locale-gen de_DE de_DE.UTF-8
#ENV LANG     de_DE.UTF-8
#ENV LANGUAGE de_DE.UTF-8
##################################################################
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python wget vim git build-essential sudo net-tools inetutils-ping netcat                      
#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install python wget vim git build-essential sudo net-tools inetutils-ping netcat                      
##############################################################
# install cppcheck
#
ARG CPP_CHECK_VER="1.74"
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libpcre3 libpcre3-dev python wget build-essential sudo                                                          && \
    mkdir -p /xxx/cppcheck                                                                                                              && \
    cd /xxx/cppcheck                                                                                                                    && \
    wget https://sourceforge.net/projects/cppcheck/files/cppcheck/${CPP_CHECK_VER}/cppcheck-${CPP_CHECK_VER}.tar.bz2                    && \
    tar -xjvf cppcheck-${CPP_CHECK_VER}.tar.bz2                                                                                         && \
    cd ./cppcheck-${CPP_CHECK_VER}                                                                                                      && \
    make SRCDIR=build CFGDIR=/usr/share/cppceck HAVE_RULES=yes CXXFLAGS="-O2 -DNDEBUG -Wall -Wno-sign-compare -Wno-unused-function"     && \
    make install CFGDIR=/usr/share/cppceck                                                                                              && \
    cd /                                                                                                                                && \
    rm -rf /xxx/cppcheck
##############################################################
# oselas.toolchain fuer TQ-Board
ARG OSELAS_TOOL_CHAIN=oselas.toolchain-2016.06.1-arm-v7a-linux-gnueabihf-gcc-5.4.0-glibc-2.23-binutils-2.26-kernel-4.6-sanitized
RUN echo "deb http://debian.pengutronix.de/debian/ sid main contrib non-free" > /etc/apt/sources.list.d/pengutronix.list    && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated pengutronix-archive-keyring &&\
    apt-get install -y --allow-unauthenticated ${OSELAS_TOOL_CHAIN}
##############################################################
# others
RUN apt-get install -y autoconf lcov valgrind cmake git telnet
##############################################################

RUN apt-get install -y iputils-ping openssh-client

# cleanup
RUN apt-get clean                                      && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "ALL ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
RUN chmod a+s /usr/sbin/useradd /usr/sbin/groupadd /bin/chmod /bin/chown
RUN mkdir -p /workspace
VOLUME /workspace
WORKDIR /workspace

COPY ./entry.sh /entry.sh
RUN chmod a+x /entry.sh
ENTRYPOINT ["/entry.sh"]


