#!/usr/bin/env bash
#set -x
# ---------------------------------------------------------------------------------------- 
# 
# ---------------------------------------------------------------------------------------- 

# ---------------------------------------------------------------------------------------- 
# Define the configuration file
# ---------------------------------------------------------------------------------------- 
CONFIGFILE=~/.sshconnectrc

# ---------------------------------------------------------------------------------------- 
# Function: add_entry - Provides a series of prompts for adding a connection entry to the
# config file.
# ---------------------------------------------------------------------------------------- 
add_entry ()
{
   echo " * Adding entry to $(echo $CONFIGFILE)..."
   read -rep "Connection Name: " connname
   read -rep "Username: " username
   read -rep "Hostname: " hostname
   read -rep "Hostname for port forwarding: " pfhostname
   read -rep "Port to use: " portnum
   nlines=$(( $(cat $HOME/.sshconnectrc | wc -l) + 1 ))
   if [ -z $pfhostname ]; then pfhostname=$hostname; fi
   echo "$nlines:$connname:$username:$hostname:$pfhostname:$portnum" >> $CONFIGFILE
   read -rep "Do you want to add another entry? [y|n]: " response
   case $response in
      [Yy]*) add_entry ;;
      [Nn]*) ;;
          *) ;;
   esac
}

# ---------------------------------------------------------------------------------------- 
# Function: check_port -  
# ---------------------------------------------------------------------------------------- 
check_port ()
{
   if [[ $(uname -s) == "Darwin" ]]; then
      # FreeBSD or macOS
      netstat -anp tcp 2>/dev/null | grep LISTEN | grep $portnum 1> /dev/null 2>&1
   elif [[ $(uname -s) == "Linux" ]]; then
      # GNU Linux
      netstat -tulpn 2>/dev/null | grep LISTEN | grep $portnum 1> /dev/null 2>&1
   fi
   echo $?
}
# ---------------------------------------------------------------------------------------- 
# Function: print_menu - 
# ---------------------------------------------------------------------------------------- 
print_menu ()
{
   clear
   echo ""
   echo "****************************"
   echo "*   SELECT HOST COMPUTER   *"
   echo "*          ****            *"
   while read -r line
   do
      num=$(echo "$line" | cut -d":" -f 1)
      con=$(echo "$line" | cut -d":" -f 2 | sed 's/\"//g')
      printf "* %2d) %-20s *\n" $num "$con"
   done < $CONFIGFILE
   echo "*                          *"
   echo "*  A) Add entry            *"
   echo "****************************"
}

# ---------------------------------------------------------------------------------------- 
# Main Script
# ---------------------------------------------------------------------------------------- 
if [ ! -f $CONFIGFILE ]; then
   echo " * Creating $(echo $CONFIGFILE) ..."
   echo "" > $CONFIGFILE
   add_entry
fi

print_menu
read -rep "Select option: " selection

if [[ $selection == "A" ]]; then
   add_entry
else
   line=$(grep ^$selection $CONFIGFILE)
   user=$(echo $line | cut -d":" -f 3)
   host=$(echo $line | cut -d":" -f 4)
   porthost=$(echo $line | cut -d":" -f 5)
   portnum=$(echo $line | cut -d":" -f 6)

   port_in_use=$(check_port)
   if [ $port_in_use -eq 0 ]; then
      # Port is in use
      ssh $user@$host
   elif [ $port_in_use -eq 1 ];then
      # Port NOT in use, so port forward here
      echo " * Port $portnum is available..."
      echo " * Connecting to $host binding port $portnum..."
      sshportfwd="-L $portnum:$porthost:22"
      ssh $sshportfwd $user@$host
   fi
fi

exit 0
