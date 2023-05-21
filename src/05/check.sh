#!/bin/bash

function check()
{
	if [[ $countValue -ne 1 ]]
	then
		echo -e "${red}ERROR${normal} invalid number of args"
		exit 1
	fi
	reg='^[1-4]$'
	if ! [[ $arg =~ $reg ]]
	then
		echo -e "${red}ERROR${normal} invalid argument"
		exit 1
	fi
}
