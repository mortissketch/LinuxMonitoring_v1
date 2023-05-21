#!bin/bash

function removeMethod()
{
	case $method in
		1)method1;;
		2)method2;;
		3)method3;;
	esac
}

function method1()
{
	folderName="$(grep -e "^/[a-zA-Z0-9]*/[a-zA-Z]*_[0-9]* -- 20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] --" ../02/result.log -x | awk '{print $1}')"
	folderNameOneMore="$(grep -e "^/[a-zA-Z]*_[0-9]* -- 20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] --" ../02/result.log -x | awk '{print $1}')"
	if ! [[ -z $folderName ]]
	then
		for i in $folderName
		do
			if  [[ $i =~ $folderName ]]
			then
				sudo rm -rf $i
			fi
		done
	fi
	if ! [[ -z $folderNameOneMore ]]
	then
		for i in $folderNameOneMore
		do
			if [[ $i =~ $folderNameOneMore ]]
			then
				sudo rm -rf $i
			fi
		done
	fi
}

function method2()
{
	echo "enter the start and end date of the script"
	echo "(example, YYYY-MM-DD hh:mm)"
	read -p "start -- " startTime
	read -p "end -- " endTime
	startScript="$(cat ../02/result.log | head -1 | awk '{print $4 $5}')"
	endScript="$(cat ../02/result.log | tail -n 3 | head -1 | awk '{print $4 $5}')"
	onlyDateLogStart="$(echo ${startScript:0:10})"
	onlyDateStart="$(echo ${startTime:0:10})"
	if [[ $onlyDateLogStart -eq $onlyDateStart ]]
	then
		onlyDateLogEnd="$(echo ${endScript:0:10})"
		onlyDateEnd="$(echo ${endTime:0:10})"
		if ! [[ $onlyDateLogEnd -eq $onlyDateEnd ]]
		then
			echo -e "${red}ERROR${normal} incorrect date"
			exit 1
		fi

		hoursLogStart="$(echo ${startScript:10:2})"
		hoursStart="$(echo ${startTime:11:2})"
		if ! [[ $hoursLogStart -eq $hoursStart ]]
		then
			echo -e "${red}ERROR${normal} incorrect time"
			exit 1
		fi

		hoursLogEnd="$(echo ${endScript:10:2})"
		hoursEnd="$(echo ${endTime:11:2})"
		if ! [[ $hoursLogStart -eq $hoursStart ]]
		then
			echo -e "${red}ERROR${normal} incorrect time"
			exit 1
		fi

		minutsLogStart="$(echo ${startScript:13:2})"
		minutsStart="$(echo ${startTime:14:2})"
		if ! [[ $minutsLogStart -eq $minutsStart ]]
		then
			echo -e "${red}ERROR${normal} incorrect time"
			exit 1
		fi

		minutsLogEnd=$(echo ${endScript:13:2})
		minutsEnd=$(echo ${endTime:14:2})
		let minutsLogEnd++
		if ! [[ $minutsEnd -eq $minutsLogEnd ]]
		then
			echo -e "${red}ERROR${normal} incorrect time"
			exit 1
		fi

		folders="$(find / -type d -newermt "$startTime" ! -newermt "$endTime" | grep -E "^*_20[0-9][0-9][0-9][0-9]$")"
		for i in $folders
		do
			sudo rm -rf $i
		done
	else
		echo -e "${red}ERROR${normal} incorrect date"
		exit 1
	fi
}

function method3()
{
	echo "enter mask (letters and date, like qwer_DDMMYY)"
	read mask
	letterFolders=$(echo "$mask" | awk -F'_' '{print $1}')
	date=$(echo "$mask" | awk -F'_' '{print $2}')
	countLetters=${#letterFolders}
	lastLetter=$(( $countLetters - 1))
	reg=""
	if [[ $countLetters -lt 5 ]]
	then
		reg+="["
		reg+="$(echo ${letterFolders:0:1})"
		reg+="]*"
		reg+="$(echo ${letterFolders:1:$lastLetter})"
		reg+="_"
		reg+=$date
	else
		reg+="$(echo ${letterFolders:0:$lastLetter})"
		reg+="["
		reg+="$(echo ${letterFolders:$lastLetter:1})"
		reg+="]*_"
		reg+=$date
	fi
	find / -type d -name $reg | xargs rm -rf
}
