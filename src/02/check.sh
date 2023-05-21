#!/bin/bash

function check()
{
	if [[ $countValue -ne 3 ]]
	then
		echo -e "${red}ERROR${normal} invalid number of arguments"
		exit 1
	else
		regLetterFolder='^[a-zA-Z]{1,7}$'
		if ! [[ $letterFolders =~ $regLetterFolder ]]
		then
			echo -e "${red}ERROR${normal} incorrect name for folders"
			exit 1
		else
			regLetterFile='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
			if ! [[ $letterFiles =~ $regLetterFile ]]
			then
				echo -e "${red}ERROR${normal} incorrect name of files"
				exit 1
			else
				regSize='^[1-9][0-9]?$|^100Mb$'
				if ! [[ $size =~ $regSize ]]
				then
					echo -e "${red}ERROR${normal} incorrect size"
					exit 1
				else
					size=$(echo $size | awk -F"Mb" '{print $1}')
				fi
			fi
		fi
	fi
}
