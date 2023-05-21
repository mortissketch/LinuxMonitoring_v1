#!/bin/bash

function create()
{
	start=$(date +'%s%N')
	startTimeScript=$(date +'%Y-%m-%d %H:%M:%S')
	touch result.log
	touch errFolder.log
	touch errFile.log
	echo "script started at $startTimeScript" > result.log
	echo "script started at $startTimeScript"
	countFolders=$(( 1 + $RANDOM % 100 ))
	notCreate='\/[s]?bin'
	sumIter=0
	for (( count=0; count<$countFolders; count++ ))
	do
		cd /
		path=""
		nameFolder=""
		createFolder
	done
	stopScript
}

function createFolder()
{
	pathForCount=$path"/*"
	countFoldersAtCurrentFolder=$(echo $(ls -l -d $pathForCount 2>/dev/null | wc -l ))
	lenLetterFolder=${#letterFolders}
	pathPr=$(find / -type d -name "DO4_LinuxMonitoring_v2.0-?")
	pathErr=$pathPr"/src/02/errFolder.log"
	if [[ $countFoldersAtCurrentFolder -eq 0 ]]
	then
		randomNum=0
	else
		randomNum=$(( $RANDOM % $countFoldersAtCurrentFolder ))
	fi
	if [[ $randomNum -eq 0 ]]
	then
		if [[ $lenLetterFolder -lt 5 ]]
		then
			nameFolder=""
			nameFolderMin
		else
			nameFolder=$letterFolders
			nameFolderMax
		fi
		pathForFolderCreate=$path"/"$nameFolder
		mkdir $pathForFolderCreate 2> $pathErr
		if ! [[ -s $pathErr ]]
		then
			pathResult=$pathPr"/src/02/result.log"
			echo $pathForFolderCreate -- $(date +'%Y-%m-%d %H:%M:%S') -- >> $pathResult
			createFile
		fi
	else
		path+=$( ls -l -d /* | awk '{print $9}' | sed -n "$randomNum"p )
		if ! [[ $path =~ $notCreate ]]
		then
			cd $path 2> $pathErr
			createFolder
		fi
	fi
}

function nameFolderMin()
{
	for (( i=0; i<6-$lenLetterFolder+$count; i++ ))
	do
		nameFolder+="$(echo ${letterFolders:0:1})"
	done
	nameFolder+=$letterFolders
	nameFolder+="_"
	nameFolder+=$(date +"%d%m%y")
}

function nameFolderMax()
{
	lastLetter=$lenLetterFolder-1
	for (( i=0; i<$count; i++ ))
	do
		nameFolder+="$(echo ${letterFolders:$lastLetter:1})"
	done
	nameFolder+="_"
	nameFolder+=$(date +"%d%m%y")
}

function createFile()
{
	fileFirstPart="$(echo "$letterFiles" | awk -F "." '{print $1}')"
	expansion="$(echo "$letterFiles" | awk -F "." '{print $2}')"
	countFiles=$(( $RANDOM % 2000 ))
	countLetterFile=${#fileFirstPart}
	pathPr=$(find / -type d -name "DO4_LinuxMonitoring_v2.0-?")
	pathErrFile=$pathPr"/src/02/errFile.log"
	pathResult=$pathPr"/src/02/result.log"
	for (( filesCounter=0; filesCounter<$countFiles; filesCounter++ ))
	do
		if [[ $countLetterFile -lt 5 ]]
		then
			if ! [[ -s $pathErrFile ]]
			then
				nameFile=""
				nameFileMin
				echo $path"/"$nameFolder"/"$nameFile -- $(date +'%Y-%m-%d %H:%M:%S') -- $size "Mb" >> $pathResult
			else
				rm -rf $pathErrFile
				break
			fi
		else
			if ! [[ -s $pathErrFile ]]
			then
				nameFile=$fileFirstPart
				nameFileMax
				echo $path"/"$nameFolder"/"$nameFile -- $(date +'%Y-%m-%d %H:%M:%S') -- $size "Mb" >> $pathResult
			else
				rm -rf $pathErrFile
				break
			fi
		fi
		sumIter=$(( $sumIter+1 ))
	done
}

function nameFileMin()
{
	for (( i=0; i<6+$sumIter-$countLetterFile; i++ ))
	do
		nameFile+="$(echo ${letterFiles:0:1})"
	done
	nameFile+=$fileFirstPart
	nameFile+="_"
	nameFile+=$(date +"%d%m%y")
	nameFile+="."
	nameFile+=$expansion
	fallocate -l $size"MB" $path/$nameFolder/$nameFile 2> $pathErrFile
	if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
	then
		stopScript
		exit 1
	fi
}

function nameFileMax()
{
	lastLetter=$countLetterFile-1
	for (( i=$countFolders*$countFiles-1; i>$sumIter; i-- ))
	do
		nameFile+="$(echo ${letterFiles:$lastLetter:1})"
	done
	nameFile+="_"
	nameFile+=$(date +"%d%m%y")
	nameFile+="."
	nameFile+=$expansion
	fallocate -l $size"MB" $path/$nameFolder/$nameFile 2> $pathErrFile
	if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
	then
		stopScript
		exit 1
	fi
}

function stopScript()
{
	rm -rf $pathErr
	rm -rf $pathErrFile
	pathPr=$(find / -type d -name "DO4_LinuxMonitoring_v2.0-?")
	pathResult=$pathPr"/src/02/result.log"
	end=$(date +'%s%N')
	endTimeScript=$(date +'%Y-%m-%d %H:%M:%S')
	echo "Script finished at $endTimeScript" >> $pathResult
	echo "Script finished at $endTimeScript"
	let "time = $end - $start"
	let "allTime = $time / 100000000"
	echo "Script execution time (in seconds) = $(( $allTime / 10 )).$(( $allTime % 10 ))" >> $pathResult
	echo "Script execution time (in seconds) = $(( $allTime / 10 )).$(( $allTime % 10 ))"
	echo -e "" >> $pathResult
}
