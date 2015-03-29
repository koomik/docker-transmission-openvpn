#!/usr/bin/env bash

export BASE=~/tmp

export TRANSMISSION_MOVIES_CONFIG=$BASE/transmission-movies/config
export TRANSMISSION_MOVIES_INCOMPLETE=$BASE/transmission-movies/incomplete
export TRANSMISSION_MOVIES_COMPLETE=$BASE/transmission-movies/complete
export TRANSMISSION_MOVIES_WATCH=$BASE/transmission-movies/watch
export TRANSMISSION_MOVIES_LOGS=$BASE/transmission-movies/logs

docker run -d --privileged   \
    -v $TRANSMISSION_MOVIES_WATCH:/watch \
    -v $TRANSMISSION_MOVIES_COMPLETE:/downloads \
    -v $TRANSMISSION_MOVIES_INCOMPLETE:/incomplete \
    -v $TRANSMISSION_MOVIES_CONFIG:/config  \
    -v $TRANSMISSION_MOVIES_LOGS:/logs  \
    -p 9091:9091 \
    --name transmission transmission-openvpn


docker run --privileged   \
    -v $TRANSMISSION_MOVIES_WATCH:/watch \
    -v $TRANSMISSION_MOVIES_COMPLETE:/downloads \
    -v $TRANSMISSION_MOVIES_INCOMPLETE:/incomplete \
    -v $TRANSMISSION_MOVIES_CONFIG:/config  \
    -v $TRANSMISSION_MOVIES_LOGS:/logs  \
    -p 9091:9091 \
    -it --entrypoint=/bin/bash transmission-openvpn