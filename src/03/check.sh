#!bin/bash

function check()
{
	if [[ $countValue -ne 1 ]]
	then
		echo -e "${red}ERROR${normal} invalid number of argument"
		exit 1
	fi

	regNumber='^[1-3]$'
	if ! [[ $method =~ $regNumber ]]
	then
		echo -e "${red}ERROR${normal} invalid argument"
		exit 1
	fi
}
