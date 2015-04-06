# docker transmission

All credits for this goes to Jon Gillies (see the "Forked from" section)
This git only goes for testing his work with some modifications i need.


This is a Dockerfile to set up "Transmission" and "OpenVPN"  - (https://www.transmissionbt.com)

You must put 2 files in the "config" folder:

* /config/config.ovpn
* /config/auth.txt

Build from docker file:

```
git clone git@github.com:koomik/docker-transmission-openvpn.git
cd docker-transmission-openvpn
docker build -t transmission-openvpn .
```

```
docker run -d --privileged \
    -v $TRANSMISSION_MOVIES_WATCH:/watch \
    -v $TRANSMISSION_MOVIES_COMPLETE:/downloads \
    -v $TRANSMISSION_MOVIES_INCOMPLETE:/incomplete \
    -v $TRANSMISSION_MOVIES_CONFIG:/config  \
    -v $TRANSMISSION_MOVIES_LOGS:/logs \
    -p 9091:9091 \
    --name transmission transmission-openvpn
```
