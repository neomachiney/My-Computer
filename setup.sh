#!/bin/bash
shopt -s expand_aliases
source ~/.bashrc
source ~/.bash_aliases
source ~/.bash_profile

CURRENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG="/var/log/setup"
PASSMEPASS="$GITHUB_ACCESS_TOKEN"
if [[ $PASSMEPASS == "" ]]; then
	echo "Replace PASSMEPASS with github access token"
	exit
fi
GITHUB_PASSWORD=":""$PASSMEPASS""@"

echo "Cloning repostitores... "
cat README.md |  awk -F '(' '{print $2}' | awk -F ')**' '{print $1}' | sort -u | while read repository
do
	if [ ! -z "$repository" ]; then
		git clone `echo "$repository"".git" | sed s/'github.com'/"neomachiney:$PASSMEPASS@github.com"/g | sed s/':@'/$GITHUB_PASSWORD/g`
	fi
done

echo "Installing required tools... "
cd "$CURRENTDIR""/My-Knowledge/KaliSetup/"
	bash pre-config.data |& tee -a "$LOG"
	bash apt.data |& tee -a "$LOG" 
	bash pip.data  |& tee -a "$LOG"
	bash post-config.data |& tee -a "$LOG"
cd $CURRENTDIR

cd "$CURRENTDIR""/My-Knowledge/KaliSetup/"
	bash tool.data |& tee -a "$LOG"
cd $CURRENTDIR

read -p "Create symbolic links? "
rm "/root/Pictures" && ln -s "/root/MachineYadav/My-Pictures" "/root/Pictures" 
rm "/root/Music" && ln -s "/root/MachineYadav/My-Music" "/root/Music" 
sleep 3 && clear
