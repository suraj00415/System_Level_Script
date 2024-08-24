#!/bin/bash

blink=`echo -en "\e[5m"`
normal=`echo -en "\e[0m"`
red=`echo -en "\e[31m"`
green=`echo -en "\e[32m"`
orange=`echo -en "\e[33m"`

isRoot=`id -u`
if [ $isRoot -ne 0 ]
then 
    echo "${red}You must have super user privileges. Please sign in with sudo user.${normal}"
    exit 1
fi

if [ "$1" == "--help" ]; then
    echo "${orange}Usage: network.sh <command> [options]${normal}"
    echo
    echo "${orange}Commands:"
    echo "  up <interface>               - Bring a network interface up"
    echo "  down <interface>             - Bring a network interface down"
    echo "  ip <interface> <address>     - Assign an IP address to an interface"
    echo "  gw <address>                 - Set the default gateway"
    echo "  delgw <address>              - Delete the default gateway"
    echo "  restart                      - Restart the network service"
    echo "  status                       - Show the status of network interfaces"
    echo "  route                        - Show the routing table"
    echo "  --help                       - Display this help message"
    exit 0
fi

if [ "$1" == "up" ]; then 
    if [ -z "$2" ]; then 
        echo "${red}${blink}Please enter the interface name!${normal}"
    else 
        echo -n "${orange}"
        ip link set $2 up
        echo "Interface $2 brought up successfully!"
    fi

elif [ "$1" == "down" ]; then 
    if [ -z "$2" ]; then 
        echo "${red}${blink}Please enter the interface name!${normal}"
    else 
        echo -n "${orange}"
        ip link set $2 down
        echo "Interface $2 brought down successfully!"
    fi

elif [ "$1" == "ip" ]; then 
    if [ -z "$2" ]; then 
        echo "${red}${blink}Please enter the interface name!${normal}"
    elif [ -z "$3" ]; then 
        echo "${red}${blink}Please enter the IP address!${normal}"
    else 
        echo -n "${orange}"
        ip addr add $3 dev $2
        echo "IP address $3 assigned to interface $2 successfully!"
    fi

elif [ "$1" == "gw" ]; then 
    if [ -z "$2" ]; then 
        echo "${red}${blink}Please enter the gateway address!${normal}"
    else 
        echo -n "${orange}"
        ip route add default via $2
        echo "Default gateway set to $2 successfully!"
    fi
elif [ "$1" == "delgw" ]; then 
    if [ -z "$2" ]; then 
        echo "${red}${blink}Please enter the gateway address!${normal}"
    else 
        echo -n "${orange}"
        ip route del default via $2
        echo "Default gateway Deleted to $2 successfully!"
    fi

elif [ "$1" == "restart" ]; then 
    echo -n "${orange}"
    systemctl restart networking
    echo "Network service restarted successfully!"

elif [ "$1" == "status" ]; then 
    echo -n "${orange}"
    ip addr show
    echo "Network interface status displayed successfully!"

elif [ "$1" == "route" ]; then 
    echo -n "${orange}"
    ip route show
    echo "Routing table displayed successfully!"

else
    echo "${red}Invalid option. Use net --help for more info.${normal}"
fi
