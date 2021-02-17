#!/bin/bash

curl -s -o /opt/reresolve-dns-systemd.sh https://raw.githubusercontent.com/pvcbe/systemd-wireguard-refresh/master/reresolve-dns-systemd.sh
curl -s -o /etc/systemd/system/systemd-wireguard-refresh.service https://raw.githubusercontent.com/pvcbe/systemd-wireguard-refresh/master/systemd-wireguard-refresh.service
curl -s -o /etc/systemd/system/systemd-wireguard-refresh.timer https://raw.githubusercontent.com/pvcbe/systemd-wireguard-refresh/master/systemd-wireguard-refresh.timer
chmod +x /opt/reresolve-dns-systemd.sh
chmod a+r /etc/systemd/system/systemd-wireguard-refresh.*

#systemctl daemon-reload
systemctl enable systemd-wireguard-refresh.timer
systemctl start systemd-wireguard-refresh.timer

