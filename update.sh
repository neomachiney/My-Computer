#!/bin/bash
shopt -s expand_aliases
source ~/.bashrc
source ~/.bash_aliases
source ~/.bash_profile

CURRENT="`pwd`"
cat .gitignore | while read REPOSITORY
do
	cd $REPOSITORY 2>/var/log/setup_log && gitted
	cd $CURRENT
done
