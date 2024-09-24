#!/bin/bash
traceroute -n $1 | awk '{print $2}' | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | while read ip; do
    echo -e "\e[1;34mIP: $ip\e[0m"
    
    # Check if it's a private IP
    if [[ $ip =~ ^(10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.) ]]; then
        echo -e "\e[1;33mPrivate IP (Internal Hop)\e[0m"
    else
        asn=$(whois $ip | grep -i 'origin')
        if [ -z "$asn" ]; then
            echo -e "\e[1;31mASN: Not Found\e[0m"
        else
            echo -e "\e[1;32m$asn\e[0m"
        fi
    fi
    echo "----------------------------"
done
