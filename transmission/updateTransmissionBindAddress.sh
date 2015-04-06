#!/usr/bin/env bash

CURRENT_VPNADDR=`grep bind-address-ipv4 /etc/transmission-daemon/settings.json | awk '{ print $2 }' | sed 's/\"//g' | sed 's/,//g'`

VPNADDR=`ifconfig | grep -A 5 "tun" | grep "inet" | cut -f2 -d ':' | awk '{print $1}'`

if [ -z "$CURRENT_VPNADDR" ]; then
    CURRENT_VPNADDR=127.0.0.1
fi

if [ -z "$VPNADDR" ]; then
    VPNADDR=127.0.0.1
fi

if [ "$VPNADDR" == "0.0.0.0" ]; then
    VPNADDR=127.0.0.1
fi

if [ "$CURRENT_VPNADDR" != "$VPNADDR" ]; then
  echo "`date` Restarting Tranmission... old addr $CURRENT_VPNADDR new addr $VPNADDR" >> /logs/transmission.log
  #/etc/init.d/transmission-daemon stop
  #sed -i "s/.*bind-address-ipv4.*/    \"bind-address-ipv4\"\: \"$VPNADDR\",/g" /etc/transmission-daemon/settings.json
  #/etc/init.d/transmission-daemon start
fi

