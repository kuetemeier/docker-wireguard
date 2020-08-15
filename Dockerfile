FROM ubuntu:20.04

ARG wireguard_version=v1.0.20200729

#RUN apt-get update -qq \
#	&& apt-get install -y -qq software-properties-common \
#	&& add-apt-repository ppa:wireguard/wireguard \
#	&& apt-get update -qq \
#	&& apt-get install -y -qq wireguard libmnl-dev libelf-dev build-essential pkg-config wget iproute2 net-tools \
#	&& wget -O /wireguard.tar.xz https://git.zx2c4.com/WireGuard/snapshot/WireGuard-${wireguard_version}.tar.xz \
#	&& cd / \
#	&& tar -xf /wireguard.tar.xz

COPY entrypoint.sh /
COPY start.sh /

RUN apt-get update -qq \
	&& apt-get install -y -qq software-properties-common \
	&& apt-get install -y -qq wireguard libmnl-dev libelf-dev build-essential pkg-config wget iproute2 net-tools git \
	&& git clone https://git.zx2c4.com/wireguard-linux-compat

WORKDIR /wireguard-linux-compat/src
RUN git checkout ${wireguard_version}


ENV INTERFACE wg0
ENV LISTEN_PORT 51820

#WORKDIR /WireGuard-${wireguard_version}/src

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/start.sh" ]
