#!/bin/sh

exec openvpn --config /config/config.ovpn --auth-user-pass /config/auth.txt --log /logs/openvpn.log
