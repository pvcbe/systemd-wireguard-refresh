#!/bin/bash
#
# Philip Vanmontfort 2019
#
# check's if a systemd-networkd defined peer needs a refresh.

# #reference
# https://git.zx2c4.com/WireGuard/tree/contrib/examples/reresolve-dns/reresolve-dns.sh
# https://stackoverflow.com/questions/19482123/extract-part-of-a-string-using-bash-cut-split


timeout=135


for dev in /etc/systemd/network/*.netdev;
do
    if grep -qiE "Kind\s+?=\s+?wireguard" "${dev}"
    then
        #echo "checking ${dev}"
        regex_interface="Name\s+?=\s+?(\w+)"
        regex_peer_block="\[WireGuardPeer\]"
        regex_endpoint="Endpoint\s+?=\s+?(.*)"
        regex_publickey="PublicKey\s+?=\s+?(.*)"
        regex_handshake="\w.*\s+(.*)"

        while read -r line; do
            if [[ ${line} =~ ${regex_interface} ]]
            then
                interface=${BASH_REMATCH[1]}
            elif [[ ${line} =~ ${regex_peer_block} ]]
            then
                publickey=""
                endpoint=""
            elif [[ ${line} =~ ${regex_endpoint} ]]
            then
                endpoint=${BASH_REMATCH[1]}
            elif [[ ${line} =~ ${regex_publickey} ]]
            then
                publickey=${BASH_REMATCH[1]}
            else
                # skip all other lines
                continue
            fi

            if [[ -n "${interface}" && -n "${publickey}" && -n "${endpoint}" ]]
            then
                if [[ $(wg show "${interface}" latest-handshakes|grep "${publickey}") =~ ${regex_handshake} ]]
                then
                    latest_handshake=${BASH_REMATCH[1]}
                    time_now=$(date +%s)
                    time_delta=$(( time_now - latest_handshake ))
                    echo "${interface} >> ${publickey}  stat $time_now , $latest_handshake ,  $time_delta"

                    if [ ${time_delta} -gt ${timeout} ]
                    then
                        echo "${interface} ${publickey} refresh with ${endpoint} (time_delta=${time_delta})"
                        wg set "${interface}" peer "${publickey}" endpoint "${endpoint}"
                    fi
                fi
            fi
        done < "${dev}"
    fi
done
