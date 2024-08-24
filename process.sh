#!/bin/bash

blink=`echo -en "\e[5m"`
normal=`echo -en "\e[0m"`
red=`echo -en "\e[31m"`
lightred=`echo -en "\e[91m"`
lightgreen=`echo -en "\e[92m"`
lightyellow=`echo -en "\e[93m"`
lightblue=`echo -en "\e[94m"`
lightpurple=`echo -en "\e[95m"`
RED=`echo -en "\e[41m"`
LIGHTYELLOW=`echo -en "\e[103m"`

isRoot=`id -u`
if [ $isRoot -ne 0 ]
then 
    echo "$red You must have super user privileges. Please sign in with a sudo user.$normal"
    exit 1
fi

if [ "$1" == "--help" ]
then
    echo "${LIGHTYELLOW}Usage: manage <option>${normal}"
    echo
    echo "${lightyellow}Options:"
    echo "  list                         - List all running processes"
    echo "  kill <pid>                   - Kill a process by PID"
    echo "  killname <name>              - Kill a process by name"
    echo "  priority <pid> <priority>    - Change the priority of a process (nice value)"
    echo "  info <pid>                   - Get detailed info about a process"
    echo "  --help                       - Display this help message"
    exit 0
fi

function list_processes {
    echo -e "${lightblue}Running Processes:${normal}"
    ps aux --sort=-%cpu | head -n 20
    echo
}

function kill_process {
    if [ -z "$2" ]; then
        echo "$RED $blink Please provide a PID to kill!! $normal"
    else
        kill -9 $2
        echo "$lightred Process $2 has been killed.$normal"
    fi
}

function kill_process_by_name {
    if [ -z "$2" ]; then
        echo "$RED $blink Please provide a process name to kill!! $normal"
    else
        pkill -9 $2
        echo "$lightred Processes with name $2 have been killed.$normal"
    fi
}

function change_priority {
    if [ -z "$2" ] || [ -z "$3" ]; then
        echo "$RED $blink Please provide both PID and priority value!! $normal"
    else
        renice -n $3 -p $2
        echo "$lightgreen Priority of process $2 has been changed to $3.$normal"
    fi
}

function process_info {
    if [ -z "$2" ]; then
        echo "$RED $blink Please provide a PID to get info!! $normal"
    else
        echo -e "${lightpurple}Process Info for PID $2:${normal}"
        ps -p $2 -o pid,ppid,cmd,%mem,%cpu,stat,etime
        echo
    fi
}

if [ "$1" == "list" ]; then
    list_processes
elif [ "$1" == "kill" ]; then
    kill_process $@
elif [ "$1" == "killname" ]; then
    kill_process_by_name $@
elif [ "$1" == "priority" ]; then
    change_priority $@
elif [ "$1" == "info" ]; then
    process_info $@
else
    echo "$red Invalid option. Use manage --help for more info.$normal"
fi
