FROM phusion/passenger-customizable:0.9.15
MAINTAINER Jon Gillies <supercoder@gmail.com>

# Originally from https://registry.hub.docker.com/u/haugene/transmission-openvpn/

VOLUME /logs
VOLUME /downloads
VOLUME /incomplete
VOLUME /watch
VOLUME /config

# Update package sources list
RUN apt-get update

# Add transmission ppa repository for latest releases
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:transmissionbt/ppa

# Update packages and install software
RUN apt-get update
RUN apt-get install -y transmission-cli
RUN apt-get install -y transmission-common
RUN apt-get install -y transmission-daemon
RUN apt-get install -y openvpn
RUN apt-get install -y curl
RUN apt-get install -y screen
RUN apt-get install -y lynx

# Transmission service
RUN mkdir -p /etc/service/transmission/
ADD transmission/run.sh /etc/service/transmission/run

# Transmission port updater
RUN mkdir -p /etc/service/portupdater/
ADD transmission/runUpdates.sh /etc/service/portupdater/run

# OpenVPN service
RUN mkdir -p /etc/service/openvpn/
ADD runOpenVpn.sh /etc/service/openvpn/run

VOLUME /config

# Add configuration and scripts
ADD runOpenVpn.sh /etc/openvpn/start.sh
ADD transmission/defaultSettings.json /etc/transmission-daemon/settings.json
#ADD transmission/updateTransmissionPort.sh /etc/transmission-daemon/updatePort.sh
ADD transmission/periodicUpdates.sh /etc/transmission-daemon/periodicUpdates.sh
ADD transmission/updateTransmissionBindAddress.sh /etc/transmission-daemon/updateTransmissionBindAddress.sh

# Expose port and run. Use baseimage-docker's init system
EXPOSE 9091
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
