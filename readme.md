# systemd-wireguard-refresh

check all systemd-networkd defined wireguard peers if needed.


refresh all peers endpoints in `/etc/systemd/network/*.netdev` with a *kind* of `wireguard`.    
If the latest handshake is older then 135 seconds, re-apply the endpoint.  This wil force a dns lookup.
This script is intended for wireguard endpoints who have a dynamic dns peer.

see https://git.zx2c4.com/WireGuard/tree/contrib/examples/reresolve-dns/reresolve-dns.sh for a wireguard.conf native version.  


## installation

to install, as root execute the following:

    curl -o /opt/reresolve-dns-systemd.sh https://raw.githubusercontent.com/pvcbe/systemd-wireguard-refresh/master/reresolve-dns-systemd.sh
    chmod +x /opt/reresolve-dns-systemd.sh    
    echo "$(crontab -l ; echo '* * * * *   /opt/reresolve-dns-systemd.sh')" | crontab - 
    
