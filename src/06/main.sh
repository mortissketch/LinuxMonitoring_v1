#!/bin/bash

red='\033[031m'
normal='\033[0m'

if [[ $# -ne 0 ]]
then
	echo "${red}ERROR${normal} should be 0 args"
else
	goaccess ../04/[1-5]_file.log --log-format=COMBINED > result.html
fi
