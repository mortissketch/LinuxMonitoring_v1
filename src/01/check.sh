#!/bin/bash

function check()
{
	#кол-во аргументов
	if [[ $countVal -ne 6 ]]
	then
		echo -e "${red}ERROR${normal} invalid number of arguments"
		exit 1
	else
		#проверка на правильность ввода пути
		lastSymPath=$(echo "${path}" | tail -c 2)
		if [[ $lastSymPath == "/" ]] || ! [[ -d $path ]]
		then
			echo -e "${red}ERROR${normal} incorrect path"
			exit 1
		else
			plusCheck
		fi
	fi
}

function plusCheck()
{
	regNumber='^[1-9][0-9]+?$'
	if ! [[ $countFolders =~ $regNumber ]] || ! [[ $countFiles =~ $regNumber ]]
	then
		echo -e "${red}ERROR${normal} non-numeric argument for folders or files"
	else
		regNameFolders='^[a-zA-Z]{1,7}$'
		if ! [[ $letterFolders =~ $regNameFolders ]]
		then
			echo -e "${red}ERROR${normal} incorrect name for folders"
			exit 1
		else
			regNameFiles='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
			if ! [[ $letterFiles =~ $regNameFiles ]]
			then
				echo -e "${red}ERROR${normal} incorrect name for files"
				exit 1
			else
				regSize='^[1-9][0-9]?[0]?kb$'
				if ! [[ $size =~ $regSize ]]
				then
					echo -e "${red}ERROR${normal} incorrect size"
					exit 1
				else
					size=$(echo $size | awk -F"kb" '{print $1}')
				fi
			fi
		fi
	fi
}
