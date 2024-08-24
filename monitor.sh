#!/bin/bash

normal=`echo -en "\e[0m"`
red=`echo -en "\e[31m"`
lightgreen=`echo -en "\e[92m"`
lightyellow=`echo -en "\e[93m"`
lightblue=`echo -en "\e[94m"`
lightpurple=`echo -en "\e[95m"`
LIGHTYELLOW=`echo -en "\e[103m"`

isRoot=`id -u`
if [ $isRoot -ne 0 ]
then 
    echo "$red You must have super user privileges. Please sign in with a sudo user.$normal"
    exit 1
fi

if [ "$1" == "--help" ]
then
    echo "${LIGHTYELLOW}Usage: monitor.sh <option>${normal}"
    echo
    echo "${lightyellow}Options:"
    echo "  cpu                          - Display CPU usage"
    echo "  memory                       - Display memory usage"
    echo "  disk                         - Display disk usage"
    echo "  all                          - Display all of the above"
    echo "  --help                       - Display this help message"
    exit 0
fi

function cpu_usage {
    echo -e "${lightblue}CPU Usage:${normal}"
    top -b -n1 | grep "Cpu(s)" | awk '{print "  User: " $2 "%, System: " $4 "%, Idle: " $8 "%"}'
    echo
}

function memory_usage {
    echo -e "${lightpurple}Memory Usage:${normal}"
    free -m | awk 'NR==2{printf "  Total: %sMB, Used: %sMB, Free: %sMB\n", $2,$3,$4}'
    echo
}

function disk_usage {
    echo -e "${lightgreen}Disk Usage:${normal}"
    df -h | grep "^/dev/" | awk '{print "  "$1": "$5" used ("$3"/"$2")"}'
    echo
}



if [ "$1" == "cpu" ]; then
    cpu_usage
elif [ "$1" == "memory" ]; then
    memory_usage
elif [ "$1" == "disk" ]; then
    disk_usage
elif [ "$1" == "all" ]; then
    cpu_usage
    memory_usage
    disk_usage
else
    echo "$red Invalid option. Use monitor --help for more info.$normal"
fi
