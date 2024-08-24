#!/bin/bash

 blink=`echo -en "\e[5m"`
 normal=`echo -en "\e[0m"`
 red=`echo -en "\e[31m"`
 orange=`echo -en "\e[33m"`
 lightyellow=`echo -en "\e[93m"`
 RED=`echo -en "\e[41m"`
 LIGHTYELLOW=`echo -en "\e[103m"`

isRoot=`id -u`
if [ $isRoot -ne 0 ]
then 
    echo "You must have super user privileges. Please sign in with sudo user."
    exit 1
fi

if [ "$1" == "--help" ]
then
    echo "${LIGHTYELLOW}Usage: ch <u/g> option ${normal}"
    echo
    echo "${lightyellow}u--->user"
    echo "g--->group"
    echo
    echo "Options:"
    echo "  add <name>                   - Add new user/group"
    echo "  delete <name>                - Delete a user/group"
    echo "  shell <name> <shellLoc>      - Change user's shell"
    echo "  super <name>                 - Change a user to super user"
    echo "  rename <oldName> <newName>   - Rename user/group and also change the uid/gid if user"
    echo "  adduser <uname> <gname>      - Add user to a group"
    echo "  --help                       - Display this help message"
    exit 0
fi

if [ "$1" == "u" ]; then 
    if [ "$2" == "add" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the user name!! $normal"
        else 
            echo -n "$orange"
            useradd -m -s "/bin/bash" $3
            echo "User added successfully! By default directory of the user is created and the default shell is /bin/bash "
        fi
    elif [ "$2" == "delete" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the user name!! $normal"
        else 
            echo -n "$red"
            deluser $3
            echo "User Deleted successfully!"
        fi
    elif [ "$2" == "shell" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the user name $normal"
        elif [ -z "$4" ] ; then 
            echo "$RED $blink Please enter the Shell Name $normal"
        else 
            echo -n "$orange"
            chsh -s $4 $3
            echo "Shell Changed Successfully for the user $3 to $4"
        fi
    elif [ "$2" == "super" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the user name $normal"
        else 
            echo -n "$orange"
            passwd $3
            usermod -aG "sudo" $3 
            echo "$3 became Superuser successfully!!"
        fi
    elif [ "$2" == "adduser" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the user name $normal"
        elif [ -z "$4" ] ; then 
            echo "$RED $blink Please enter the group Name $normal"
        else 
            echo -n "$orange"
            adduser $3 $4
            echo "User added Successfully to the group $4"
        fi
    elif [ "$2" == "rename" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the old user name $normal"
        elif [ -z "$4" ] ; then 
            echo "$RED $blink Please enter the new user name $normal"
        else 
            echo -n "$orange"
            usermod -l $4 $3
            usermod -d /home/$4 -m $4
            echo "User renamed successfully from $3 to $4"
        fi
    else
        echo "$red Invalid option for user. Use ch --help for more info."
    fi
elif [ "$1" == "g" ]; then 
    if [ "$2" == "add" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the group name!! $normal"
        else 
            echo -n "$orange"
            groupadd $3
            echo "Group added successfully!"
        fi
    elif [ "$2" == "delete" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the group name!! $normal"
        else 
            echo -n "$red"
            groupdel $3
            echo "Group Deleted successfully!"
        fi
    elif [ "$2" == "rename" ]; then 
        if [ -z "$3" ] ;then 
            echo "$RED $blink Please enter the old group name $normal"
        elif [ -z "$4" ] ; then 
            echo "$RED $blink Please enter the new group name $normal"
        else 
            echo -n "$orange"
            groupmod -n $4 $3
            echo "Group renamed successfully from $3 to $4"
        fi
    else
        echo "$red Invalid option for group. Use ch --help for more info."
    fi
else
    echo "$red Invalid main option. Use ch --help for more info."
fi