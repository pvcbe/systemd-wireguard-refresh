# systemd-wireguard-refresh

check all systemd-networkd defined wireguard peers if needed.


refresh all peers endpoints in `/etc/systemd/network/*.netdev` with a *kind* of `wireguard`.    
If the latest handshake is older then 135 seconds, re-apply the endpoint.  This wil force a dns lookup.
This script is intended for wireguard endpoints who have a dynamic dns peer.

see https://git.zx2c4.com/WireGuard/tree/contrib/examples/reresolve-dns/reresolve-dns.sh for a wireguard.conf native version.  


## installation

to install, as root execute the following:

    curl -s https://raw.githubusercontent.com/pvcbe/systemd-wireguard-refresh/master/install.sh | bash

to remove the script's and timers:

    curl -s https://raw.githubusercontent.com/pvcbe/systemd-wireguard-refresh/master/remove.sh | bash


