#!/bin/bash

while [ 1 ]
do
  exec /etc/transmission-daemon/updateTransmissionBindAddress.sh
  sleep 1m
done
