#!/bin/bash

systemctl stop systemd-wireguard-refresh.timer
systemctl disable systemd-wireguard-refresh.timer

rm /opt/reresolve-dns-systemd.sh
rm /etc/systemd/system/systemd-wireguard-refresh.service
rm /etc/systemd/system/systemd-wireguard-refresh.timer

